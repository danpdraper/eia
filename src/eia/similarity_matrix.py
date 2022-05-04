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
