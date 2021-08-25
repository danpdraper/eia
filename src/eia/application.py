import itertools
import logging
import logging.handlers as handlers
import os
import statistics

import eia.environment as environment
import eia.files.csv_files as csv_files
import eia.files.input_output as input_output
import eia.files.text_files as text_files
import eia.heap as heap
import eia.plots as plots
import eia.similarity_matrix as similarity_matrix
import eia.transformations as transformations


def configure_logging(debug):
    logging.basicConfig(
        datefmt='%Y-%m-%d %H:%M:%S',
        format='%(asctime)s [%(levelname)s] (%(name)s) %(message)s',
        handlers=[
            handlers.RotatingFileHandler(
                os.path.join(environment.LOG_DIRECTORY_PATH, 'application.txt'),
                maxBytes=(1024 ** 2 * 50), backupCount=3),
        ],
        level=logging.DEBUG if debug else logging.INFO)


def matrix_and_plot(arguments):
    configure_logging(arguments.debug)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "algorithm = {}, "
        "scope = {}, "
        "language = {}, "
        "output_directory_path = {}, "
        "legislation_directory_path = {}, "
        "debug = {}, "
        "preserve_provision_delimiters = {}, "
        "states_to_include_file_path = {}, "
        "matrix_only = {}".format(
            arguments.algorithm.to_string(), arguments.scope, arguments.language,
            arguments.output_directory_path,
            arguments.legislation_directory_path, arguments.debug,
            arguments.preserve_provision_delimiters,
            arguments.states_to_include_file_path, arguments.matrix_only))

    if not os.path.isdir(arguments.output_directory_path):
        raise ValueError("{} is not a directory.".format(
            arguments.output_directory_path))
    algorithm_output_directory_path = os.path.join(
        arguments.output_directory_path, arguments.algorithm.to_string())
    if not os.path.isdir(algorithm_output_directory_path):
        logger.info("Creating directory {}".format(algorithm_output_directory_path))
        os.makedirs(algorithm_output_directory_path)
    output_file_path = os.path.join(
        algorithm_output_directory_path, "{}.csv".format(arguments.scope))

    labels_and_rows = [
        row for row in similarity_matrix.row_generator(
            arguments.algorithm, arguments.scope, arguments.language,
            arguments.legislation_directory_path,
            arguments.preserve_provision_delimiters,
            arguments.states_to_include_file_path)
    ]

    input_output.write(output_file_path, ["language:{}".format(arguments.language)])
    input_output.append(
        output_file_path, map(
            lambda value: transformations.label_and_row_tuple_to_comma_separated_string(value),
            labels_and_rows))
    logger.info("Wrote similarity matrix and labels to {}".format(output_file_path))

    if not arguments.matrix_only:
        output_image_path = os.path.join(
            algorithm_output_directory_path, "{}.png".format(arguments.scope))
        plots.similarity_heatmap(
            labels_and_rows, arguments.algorithm, arguments.scope,
            arguments.preserve_provision_delimiters, output_image_path)


def is_same_state(first_label, second_label):
    return csv_files.state_and_provision_number_from_label(first_label)[0] == \
        csv_files.state_and_provision_number_from_label(second_label)[0]


def calculate_scaled_average(provision_group, provision_pairs, matrix):
    similarity_scores = []
    for pair in provision_pairs:
        if pair[0] < len(matrix) and pair[1] < len(matrix[pair[0]]):
            similarity_scores.append(matrix[pair[0]][pair[1]])
        else:
            similarity_scores.append(matrix[pair[1]][pair[0]])
    return statistics.mean(similarity_scores) * (len(provision_group) - 1)


def populate_heap(labels, matrix, heap, base_provision_group, base_index):
    logger = logging.getLogger(__name__)
    for index in range(base_index, len(labels)):
        if base_provision_group and \
                is_same_state(labels[base_provision_group[-1]], labels[index]):
            continue
        working_provision_group = base_provision_group + [index]
        logger.info("Processing provision group {}.".format(working_provision_group))
        if len(working_provision_group) > 1:
            heap.push((
                calculate_scaled_average(
                    working_provision_group,
                    itertools.combinations(working_provision_group, 2), matrix),
                working_provision_group,
            ))
        populate_heap(labels, matrix, heap, working_provision_group, index + 1)


def highest_provision_group_scores(arguments):
    configure_logging(arguments.debug)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "matrix_file_path = {}, "
        "number_of_scores = {}, "
        "include_provision_contents_in_output = {}, "
        "legislation_directory_path = {}, "
        "debug = {}".format(
            arguments.matrix_file_path, arguments.number_of_scores,
            arguments.include_provision_contents_in_output,
            arguments.legislation_directory_path, arguments.debug))

    labels, matrix = similarity_matrix.from_file(arguments.matrix_file_path)

    min_heap = heap.BoundedMinHeap(arguments.number_of_scores)
    populate_heap(labels, matrix, min_heap, [], 0)
    scores_and_provision_groups = sorted(
        sorted(
            min_heap.to_list(),
            key=lambda score_and_provision_group: score_and_provision_group[1]),
        key=lambda score_and_provision_group: score_and_provision_group[0],
        reverse=True)

    language = similarity_matrix.get_language(arguments.matrix_file_path)
    scores_and_provision_groups = map(
        lambda score_and_provision_group: (
            score_and_provision_group[0],
            map(
                lambda provision_index: (labels[provision_index],) + (
                    (text_files.find_provision_contents(
                        arguments.legislation_directory_path, language,
                        *csv_files.state_and_provision_number_from_label(
                            labels[provision_index])),)
                    if arguments.include_provision_contents_in_output else ()
                ),
                score_and_provision_group[1]),
        ),
        scores_and_provision_groups)

    for index, score_and_provision_group in enumerate(scores_and_provision_groups):
        if index > 0:
            print('\n----------\n')
        # Convert map to list to permit multiple traversals
        provision_group = list(score_and_provision_group[1])
        for provision in provision_group:
            print(provision[0])
        print("Scaled average: {:.3f}".format(score_and_provision_group[0]))
        for provision in provision_group:
            if len(provision) > 1:
                print("\n{}: {}".format(provision[0], provision[1]))
