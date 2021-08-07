import logging
import os

import eia.environment as environment
import eia.files.input_output as input_output
import eia.similarity_matrix as similarity_matrix
import eia.transformations as transformations


def run(algorithm, scope, language, legislation_directory_path,
        output_file_path, debug, preserve_provision_delimiters):
    logging.basicConfig(
        datefmt='%Y-%m-%d %H:%M:%S',
        filemode='w',
        filename=os.path.join(environment.LOG_DIRECTORY_PATH, 'application.txt'),
        format='%(asctime)s [%(levelname)s] (%(name)s) %(message)s',
        level=logging.DEBUG if debug else logging.INFO)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "algorithm = {}, "
        "scope = {}, "
        "language = {}, "
        "legislation_directory_path = {}, "
        "output_file_path = {}, "
        "debug = {}, "
        "preserve_provision_delimiters = {}".format(
            algorithm.to_string(), scope, language, legislation_directory_path,
            output_file_path, debug, preserve_provision_delimiters))

    input_output.write(
        output_file_path, map(
            lambda value: transformations.label_and_row_tuple_to_comma_separated_string(value),
            similarity_matrix.row_generator(
                algorithm, scope, language, legislation_directory_path,
                preserve_provision_delimiters)))
