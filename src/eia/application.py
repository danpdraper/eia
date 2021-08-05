import logging
import os

import eia.conversion as conversion
import eia.environment as environment
import eia.files.file_input_output as file_input_output
import eia.similarity_matrix as similarity_matrix


def run(algorithm, scope, language, legislation_directory_path, output_file_path):
    logging.basicConfig(
        datefmt='%Y-%m-%d %H:%M:%S',
        filemode='w',
        filename=os.path.join(environment.LOG_DIRECTORY_PATH, 'application.txt'),
        format='%(asctime)s [%(levelname)s] (%(name)s) %(message)s',
        level=logging.INFO)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "algorithm = {}, "
        "scope = {}, "
        "language = {}, "
        "legislation_directory_path = {}, "
        "output_file_path = {}".format(
            algorithm.to_string(), scope, language, legislation_directory_path,
            output_file_path))

    file_input_output.write(
        output_file_path, map(
            lambda value: conversion.label_and_row_tuple_to_comma_separated_string(value),
            similarity_matrix.row_generator(
                algorithm, scope, language, legislation_directory_path)))
