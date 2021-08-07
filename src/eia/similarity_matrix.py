import logging

import eia.files.text_files as text_files


LOGGER = logging.getLogger(__name__)


def row_generator(
        algorithm, scope, language, text_file_directory_path,
        preserve_provision_delimiters):
    for row_label, row_text in text_files.input_text_generator(
            scope, language, text_file_directory_path,
            preserve_provision_delimiters):
        row = []
        for column_label, column_text in text_files.input_text_generator(
                scope, language, text_file_directory_path,
                preserve_provision_delimiters):
            LOGGER.info(
                "Applying {} to row {} and column {}".format(
                    algorithm.to_string(), row_label, column_label))
            row.append(algorithm.apply(row_text, column_text))
        yield row_label, row
