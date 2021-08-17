import logging
import os

import eia.environment as environment
import eia.files.csv_files as csv_files
import eia.files.input_output as input_output
import eia.files.text_files as text_files
import eia.plots as plots
import eia.similarity_matrix as similarity_matrix
import eia.transformations as transformations


def configure_logging(debug):
    logging.basicConfig(
        datefmt='%Y-%m-%d %H:%M:%S',
        filemode='w',
        filename=os.path.join(environment.LOG_DIRECTORY_PATH, 'application.txt'),
        format='%(asctime)s [%(levelname)s] (%(name)s) %(message)s',
        level=logging.DEBUG if debug else logging.INFO)


def calculate_similarity(
        algorithm, scope, language, output_directory_path,
        legislation_directory_path, debug, preserve_provision_delimiters,
        states_to_include_file_path):
    configure_logging(debug)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "algorithm = {}, "
        "scope = {}, "
        "language = {}, "
        "output_directory_path = {}, "
        "legislation_directory_path = {}, "
        "debug = {}, "
        "preserve_provision_delimiters = {},"
        "states_to_include_file_path = {}".format(
            algorithm.to_string(), scope, language, output_directory_path,
            legislation_directory_path, debug, preserve_provision_delimiters,
            states_to_include_file_path))

    if not os.path.isdir(output_directory_path):
        raise ValueError("{} is not a directory.".format(output_directory_path))
    algorithm_output_directory_path = os.path.join(
        output_directory_path, algorithm.to_string())
    if not os.path.isdir(algorithm_output_directory_path):
        logger.info("Creating directory {}".format(algorithm_output_directory_path))
        os.makedirs(algorithm_output_directory_path)
    output_file_path = os.path.join(
        algorithm_output_directory_path, "{}.csv".format(scope))

    labels_and_rows = [
        row for row in similarity_matrix.row_generator(
            algorithm, scope, language, legislation_directory_path,
            preserve_provision_delimiters, states_to_include_file_path)
    ]

    input_output.write(output_file_path, ["language:{}".format(language)])
    input_output.append(
        output_file_path, map(
            lambda value: transformations.label_and_row_tuple_to_comma_separated_string(value),
            labels_and_rows))
    logger.info("Wrote similarity matrix and labels to {}".format(output_file_path))

    output_image_path = os.path.join(
        algorithm_output_directory_path, "{}.png".format(scope))
    plots.similarity_heatmap(
        labels_and_rows, algorithm, scope, preserve_provision_delimiters, output_image_path)


def extract_highest_similarity_scores(
        similarity_matrix_file_path, number_of_scores,
        include_provision_contents_in_output, legislation_directory_path, debug):
    configure_logging(debug)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "similarity_matrix_file_path = {}, "
        "number_of_scores = {}, "
        "include_provision_contents_in_output = {}, "
        "legislation_directory_path = {}, "
        "debug = {}".format(
            similarity_matrix_file_path, number_of_scores,
            include_provision_contents_in_output, legislation_directory_path,
            debug))

    sorted_labels_and_elements = sorted(
        map(
            lambda label_tuples_and_element: (
                # Return the state and provision separated by a space if the
                # row label contains a provision; otherwise, return the state.
                "{} {}".format(*label_tuples_and_element[0])
                if label_tuples_and_element[0][1]
                else label_tuples_and_element[0][0],
                # Return the state and provision separated by a space if the
                # column label contains a provision; otherwise, return the state.
                "{} {}".format(*label_tuples_and_element[1])
                if label_tuples_and_element[1][1]
                else label_tuples_and_element[1][0],
                label_tuples_and_element[2]
            ),
            filter(
                lambda label_tuples_and_element:
                # The following predicate is equivalent to: column state < row
                # state, and will evaluate to True when the column state would
                # precede the row state if the two were sorted in ascending
                # alphabetical order (e.g. column state = A, row state = B).
                label_tuples_and_element[1][0] < label_tuples_and_element[0][0],
                map(
                    lambda labels_and_element: (
                        csv_files.state_and_provision_number_from_label(
                            labels_and_element[0]),
                        csv_files.state_and_provision_number_from_label(
                            labels_and_element[1]),
                        labels_and_element[2],
                    ),
                    similarity_matrix.element_generator(
                        similarity_matrix_file_path)))),
        # Sort by the element (i.e. the similarity score).
        key=lambda labels_and_element: labels_and_element[2],
        reverse=True)[:number_of_scores]

    if include_provision_contents_in_output:
        language = similarity_matrix.get_language(similarity_matrix_file_path)
        return map(
            lambda labels_and_element: labels_and_element + (
                text_files.find_provision_contents(
                    legislation_directory_path, language,
                    *csv_files.state_and_provision_number_from_label(
                        labels_and_element[0])),
                text_files.find_provision_contents(
                    legislation_directory_path, language,
                    *csv_files.state_and_provision_number_from_label(
                        labels_and_element[1])),
            ),
            sorted_labels_and_elements)

    return sorted_labels_and_elements
