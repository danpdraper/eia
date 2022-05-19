import logging
import re

import eia.files.csv_files as csv_files
import eia.files.input_output as input_output
import eia.files.text_files as text_files
import eia.transformations as transformations


COMMA_AND_SPACE = ', '
LANGUAGE_REGEX = re.compile(r'^language:([a-z]+)$')


LOGGER = logging.getLogger(__name__)


def row_generator(
        algorithm, scope, language, text_file_directory_path,
        preserve_provision_delimiters, states_to_include_file_path=None):
    states_to_include = {}
    if states_to_include_file_path:
        states_to_include = input_output.read_json(states_to_include_file_path)
    if states_to_include:
        LOGGER.info(
            "Generating rows from legislation from the following states: "
            "{}".format(COMMA_AND_SPACE.join(states_to_include.keys())))
    else:
        LOGGER.info('Generating rows from legislation from all discovered states.')

    for row_label, row_text in text_files.input_text_generator(
            scope, language, text_file_directory_path,
            preserve_provision_delimiters, states_to_include):
        row = []
        for column_label, column_text in text_files.input_text_generator(
                scope, language, text_file_directory_path,
                preserve_provision_delimiters, states_to_include):
            LOGGER.info(
                "Applying {} to row {} and column {}".format(
                    algorithm.to_string(), row_label, column_label))
            row.append(algorithm.apply(row_text, column_text))
        yield row_label, row


def from_file(similarity_matrix_file_path):
    # The following produces labels and a lower diagonal matrix without the
    # diagonal.
    labels_and_rows = map(
        lambda index_and_label_and_row: (
            index_and_label_and_row[1][0],
            index_and_label_and_row[1][1][:index_and_label_and_row[0]],
        ), enumerate(map(
            lambda line: transformations.comma_separated_string_to_label_and_row_tuple(line),
            filter(
                lambda line: csv_files.contains_comma(line),
                input_output.line_generator(similarity_matrix_file_path)))))

    return zip(*labels_and_rows)


def get_language(similarity_matrix_file_path):
    languages = list(map(
        lambda line: re.sub(LANGUAGE_REGEX, r'\1', line),
        filter(
            lambda line: re.match(LANGUAGE_REGEX, line) is not None,
            input_output.line_generator(similarity_matrix_file_path))))
    if len(languages) != 1:
        raise RuntimeError(
            "Expected one language in {}, found: {}.".format(
                similarity_matrix_file_path, languages))
    return languages[0]


def reduce_transitive_similarity(
        similarity_matrix_file_path, minimum_proportion, enactment_years):
    labels, rows = from_file(similarity_matrix_file_path)

    new_rows = []
    for row_index, row_label in enumerate(labels):
        row_state, _ = transformations.label_to_state_and_provision_identifier(row_label)
        new_row = []
        for column_index, column_label in enumerate(labels[:row_index]):
            column_state, _ = transformations.label_to_state_and_provision_identifier(column_label)
            if row_state == column_state:
                new_row.append(rows[row_index][column_index])
                continue

            minimum_similarity = rows[row_index][column_index] * minimum_proportion
            is_overriden = False
            LOGGER.info("Processing row {} and column {}".format(row_label, column_label))

            for nested_column_index, nested_column_label in enumerate(labels[:row_index]):
                nested_column_state, _ = \
                    transformations.label_to_state_and_provision_identifier(nested_column_label)
                if nested_column_state != row_state and \
                        nested_column_state != column_state and \
                        enactment_years[nested_column_state] < enactment_years[column_state] and \
                        enactment_years[nested_column_state] < enactment_years[row_state] and \
                        rows[row_index][nested_column_index] >= minimum_similarity:
                    LOGGER.debug(
                        "The similarity at row {} and column {} ({}) is "
                        "greater than or equal to {} * {} = {}. As the legislation "
                        "corresponding to provision {} is older than the "
                        "legislation corresponding to provision {} and the "
                        "legislation corresponding to provision {}, the "
                        "similarity should be zeroed.".format(
                            row_label, nested_column_label,
                            rows[row_index][nested_column_index],
                            rows[row_index][column_index], minimum_proportion,
                            rows[row_index][column_index] * minimum_proportion,
                            nested_column_label, column_label, row_label))
                    new_row.append(0.0)
                    is_overriden = True
                    break

            if not is_overriden:
                for nested_row_index, nested_row_label in enumerate(labels[row_index + 1:]):
                    nested_row_index += row_index + 1
                    nested_row_state, _ = \
                        transformations.label_to_state_and_provision_identifier(nested_row_label)
                    if nested_row_state != row_state and \
                            enactment_years[nested_row_state] < enactment_years[column_state] and \
                            enactment_years[nested_row_state] < enactment_years[row_state] and \
                            rows[nested_row_index][row_index] >= minimum_similarity:
                        LOGGER.debug(
                            "The similarity at row {} and column {} ({}) is "
                            "greater than or equal to {} * {} = {}. As the legislation "
                            "corresponding to provision {} is older than the "
                            "legislation corresponding to provision {} and the "
                            "legislation corresponding to provision {}, the "
                            "similarity should be zeroed.".format(
                                nested_row_label, row_label,
                                rows[nested_row_index][row_index],
                                rows[row_index][column_index],
                                minimum_proportion,
                                rows[row_index][column_index] * minimum_proportion,
                                nested_row_label, column_label, row_label))
                        new_row.append(0.0)
                        is_overriden = True
                        break

            if not is_overriden:
                new_row.append(rows[row_index][column_index])

        new_rows.append(new_row)

    return labels, new_rows


def add_diagonal_and_upper_triangle_to_matrix(rows):
    for row_index, row in enumerate(rows):
        for column_index in range(row_index, len(rows)):
            if column_index == row_index:
                rows[row_index].append(1.0)
            else:
                rows[row_index].append(rows[column_index][row_index])
