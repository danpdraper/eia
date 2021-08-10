import logging

import eia.files.input_output as input_output
import eia.files.text_files as text_files


LOGGER = logging.getLogger(__name__)


def row_generator(
        algorithm, scope, language, text_file_directory_path,
        preserve_provision_delimiters, states_to_include_file_path):
    states_to_include = list(filter(
        lambda line: text_files.is_not_comment(line),
        input_output.line_generator(states_to_include_file_path)))
    if states_to_include:
        LOGGER.info(
            "Generating rows from legislation from the following states: "
            "{}".format(states_to_include))
    else:
        LOGGER.info('Generating rows from legislation from all states.')

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
