import logging
import logging.handlers as handlers
import math
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


def calculate_mean_and_standard_deviation(labels, matrix):
    summ = 0
    number_of_elements = 0
    for row_index, row in enumerate(matrix):
        for column_index, element in enumerate(row):
            if is_same_state(labels[row_index], labels[column_index]):
                break
            summ += element
            number_of_elements += 1
    mean = summ / number_of_elements

    sum_of_squared_differences = 0
    for row_index, row in enumerate(matrix):
        for column_index, element in enumerate(row):
            if is_same_state(labels[row_index], labels[column_index]):
                break
            sum_of_squared_differences += (element - mean) ** 2
    standard_deviation = math.sqrt(
        sum_of_squared_differences / number_of_elements)

    return mean, standard_deviation


def calculate_scaled_average(provision_pairs, row, provisions_in_group):
    similarity_scores = [row[pair[1]] for pair in provision_pairs]
    return statistics.mean(similarity_scores) * (len(provisions_in_group) - 1)


def traverse_row(
        labels, row_index, row, heap, score_threshold, base_provision_pair_group,
        base_column_index):
    logger = logging.getLogger(__name__)
    for index in range(base_column_index, len(row)):
        if is_same_state(labels[row_index], labels[index]):
            continue
        if base_provision_pair_group and \
                is_same_state(labels[base_provision_pair_group[-1][1]], labels[index]):
            continue
        if score_threshold and row[index] < score_threshold:
            continue
        working_provision_pair_group = base_provision_pair_group + [(row_index, index)]
        logger.info("Processing provision pair group {}".format(
            working_provision_pair_group))
        provisions_in_group = set([
            index for pair in working_provision_pair_group for index in pair
        ])
        heap.push((
            calculate_scaled_average(
                working_provision_pair_group, row, provisions_in_group),
            provisions_in_group,
        ))
        traverse_row(
            labels, row_index, row, heap, score_threshold,
            working_provision_pair_group, index + 1)


def populate_heap(labels, matrix, heap, score_threshold):
    for row_index, row in enumerate(matrix):
        traverse_row(labels, row_index, row, heap, score_threshold, [], 0)


def highest_provision_group_scores(arguments):
    configure_logging(arguments.debug)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "matrix_file_path = {}, "
        "number_of_scores = {}, "
        "include_provision_contents_in_output = {}, "
        "legislation_directory_path = {}, "
        "score_threshold = {}, "
        "reduce_redundancy_in_output = {}, "
        "debug = {}".format(
            arguments.matrix_file_path, arguments.number_of_scores,
            arguments.include_provision_contents_in_output,
            arguments.legislation_directory_path, arguments.score_threshold,
            arguments.reduce_redundancy_in_output, arguments.debug))

    labels, matrix = similarity_matrix.from_file(arguments.matrix_file_path)

    score_threshold = 0
    if arguments.score_threshold:
        mean, standard_deviation = calculate_mean_and_standard_deviation(
            labels, matrix)
        score_threshold = mean + arguments.score_threshold * standard_deviation

    min_heap = heap.BoundedMinHeap(
        arguments.number_of_scores,
        reduce_element_data_redundancy=arguments.reduce_redundancy_in_output)
    populate_heap(labels, matrix, min_heap, score_threshold)
    logger.debug("Unsorted heap contents following population: {}".format(
        min_heap.to_list()))
    scores_and_provision_groups = sorted(
        sorted(
            min_heap.to_list(),
            key=lambda score_and_provision_group: sorted(
                list(score_and_provision_group[1]))),
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

    if arguments.score_threshold:
        print("Mean: {:.3f}".format(mean))
        print("Standard deviation: {:.3f}".format(standard_deviation))
        print("Mean + {} * standard deviation: {:.3f}".format(
            arguments.score_threshold,
            mean + arguments.score_threshold * standard_deviation))
        print('\n----------\n')
    for index, score_and_provision_group in enumerate(scores_and_provision_groups):
        if index > 0:
            print('\n----------\n')
        # Convert map to list to permit multiple traversals
        provision_group = sorted(list(score_and_provision_group[1]))
        for provision in provision_group:
            print(provision[0])
        print("Scaled average: {:.3f}".format(score_and_provision_group[0]))
        for provision in provision_group:
            if len(provision) > 1:
                print("\n{}: {}".format(provision[0], provision[1]))
