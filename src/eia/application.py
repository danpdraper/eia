import logging
import os

import eia.environment as environment
import eia.files.input_output as input_output
import eia.plots as plots
import eia.similarity_matrix as similarity_matrix
import eia.transformations as transformations


def run(algorithm, scope, language, output_directory_path,
        legislation_directory_path, debug, preserve_provision_delimiters):
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
        "output_directory_path = {}, "
        "legislation_directory_path = {}, "
        "debug = {}, "
        "preserve_provision_delimiters = {}".format(
            algorithm.to_string(), scope, language, output_directory_path,
            legislation_directory_path, debug, preserve_provision_delimiters))

    if not os.path.isdir(output_directory_path):
        raise ValueError("{} is not a directory.".format(output_directory_path))
    algorithm_output_directory_path = os.path.join(
        output_directory_path, algorithm.to_string())
    if not os.path.isdir(algorithm_output_directory_path):
        logger.info("Creating directory {}".format(algorithm_output_directory_path))
        os.makedirs(algorithm_output_directory_path)
    output_file_path = os.path.join(
        algorithm_output_directory_path, "{}.txt".format(scope))

    labels_and_rows = [
        row for row in similarity_matrix.row_generator(
            algorithm, scope, language, legislation_directory_path,
            preserve_provision_delimiters)
    ]

    input_output.write(
        output_file_path, map(
            lambda value: transformations.label_and_row_tuple_to_comma_separated_string(value),
            labels_and_rows))
    logger.info("Wrote similarity matrix and labels to {}".format(output_file_path))

    output_image_path = os.path.join(
        algorithm_output_directory_path, "{}.png".format(scope))
    plots.similarity_heatmap(labels_and_rows, algorithm, scope, output_image_path)
    logger.info("Wrote similarity heatmap to {}".format(output_image_path))
