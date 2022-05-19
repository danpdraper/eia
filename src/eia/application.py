import logging
import logging.handlers as handlers
import math
import os
import statistics

import eia.environment as environment
import eia.files.csv_files as csv_files
import eia.files.text_files as text_files
import eia.heap as heap
import eia.plots as plots
import eia.similarity_matrix as similarity_matrix
import eia.transformations as transformations


PERIOD = '.'


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

    csv_files.write_similarity_matrix(
        output_file_path, arguments.language, labels_and_rows)
    logger.info("Wrote similarity matrix and labels to {}".format(output_file_path))

    if not arguments.matrix_only:
        output_image_path = os.path.join(
            algorithm_output_directory_path, "{}.png".format(arguments.scope))
        plots.similarity_heatmap(
            labels_and_rows, arguments.algorithm, arguments.scope,
            arguments.preserve_provision_delimiters, output_image_path)


def is_same_state(first_label, second_label):
    return transformations.label_to_state_and_provision_identifier(first_label)[0] == \
        transformations.label_to_state_and_provision_identifier(second_label)[0]


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
        labels, row_index, row, min_heap, score_threshold,
        base_provision_pair_group, base_column_index):
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
        provisions_in_group = set([
            index for pair in working_provision_pair_group for index in pair
        ])
        labels_of_provisions_in_group = {
            labels[provision_index] for provision_index in provisions_in_group
        }
        logger.info(
            "Processing provision pair group {}, which contains unique "
            "provisions {}".format(
                working_provision_pair_group, labels_of_provisions_in_group))
        min_heap.push(heap.ProvisionGroupHeapElement(
            calculate_scaled_average(
                working_provision_pair_group, row, provisions_in_group),
            len(working_provision_pair_group), labels_of_provisions_in_group))
        traverse_row(
            labels, row_index, row, min_heap, score_threshold,
            working_provision_pair_group, index + 1)


def populate_heap(labels, matrix, min_heap, score_threshold):
    for row_index, row in enumerate(matrix):
        traverse_row(labels, row_index, row, min_heap, score_threshold, [], 0)


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

    min_heap = heap.SetBoundedMinHeap(
        arguments.number_of_scores * (10000 if arguments.reduce_redundancy_in_output else 1))
    populate_heap(labels, matrix, min_heap, score_threshold)
    if arguments.reduce_redundancy_in_output:
        min_heap.consolidate()
    logger.debug("Unsorted heap contents following population: {}".format(
        min_heap.to_list()))
    heap_elements = sorted(
        sorted(
            min_heap.to_list(),
            key=lambda heap_element: sorted(list(heap_element.provisions))),
        key=lambda heap_element: heap_element.scaled_average,
        reverse=True)[:arguments.number_of_scores]
    logger.debug(
        "Top {} heap elements: {}".format(
            arguments.number_of_scores, heap_elements))

    language = similarity_matrix.get_language(arguments.matrix_file_path)
    scores_and_provision_groups = list(map(
        lambda heap_element: (
            heap_element.scaled_average,
            sorted(list(map(
                lambda provision: (provision,) + (
                    (text_files.find_provision_contents(
                        arguments.legislation_directory_path, language,
                        *transformations.label_to_state_and_provision_identifier(provision)),)
                    if arguments.include_provision_contents_in_output else ()
                ),
                heap_element.provisions)),
                key=lambda provision: provision[0]),
        ),
        heap_elements))
    logger.debug(
        "Transformed top {} heap elements into scores and provision groups "
        "{}".format(arguments.number_of_scores, scores_and_provision_groups))

    matrix_directory_path_components = arguments.matrix_file_path.split(os.path.sep)[:-1]
    matrix_directory_path = (os.path.sep if matrix_directory_path_components[0] == '' else '') + os.path.join(
        *matrix_directory_path_components)
    if arguments.score_threshold:
        text_files.write_statistics_header(
            matrix_directory_path, mean, standard_deviation,
            arguments.score_threshold)
    text_files.write_scores_and_provision_groups(
        matrix_directory_path, scores_and_provision_groups)
    logger.info("Wrote scores and provision groups {} to directory {}".format(
        scores_and_provision_groups, matrix_directory_path))

    provision_groups = [
        [
            provision_and_contents[0] for provision_and_contents in
            score_and_provision_group[1]
        ] for score_and_provision_group in scores_and_provision_groups
    ]
    if arguments.deduplicate_transitive_similarity:
        nodes, edges = transformations.provision_groups_to_transitively_deduplicated_nodes_and_edges(
            provision_groups, csv_files.get_enactment_years(
                arguments.enactment_years_file_path))
    else:
        nodes, edges = transformations.provision_groups_to_nodes_and_edges(provision_groups)
    logger.debug(
        "Transformed scores and provision groups {} into nodes {} and edges {}".format(
            scores_and_provision_groups, nodes, edges))
    csv_files.write_nodes(matrix_directory_path, nodes)
    csv_files.write_edges(matrix_directory_path, nodes, edges)
    logger.info("Wrote nodes {} and edges {} to directory {}".format(
        nodes, edges, matrix_directory_path))


def graph(arguments):
    configure_logging(arguments.debug)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "statistic = {}, "
        "matrix_file_path = {}, "
        "output_directory_path = {}, "
        "debug = {}".format(
            arguments.statistic, arguments.matrix_file_path,
            arguments.output_directory_path, arguments.debug))

    if not os.path.isdir(arguments.output_directory_path):
        raise ValueError("{} is not a directory.".format(
            arguments.output_directory_path))

    nodes, edges = transformations.similarity_matrix_to_nodes_and_edges(
        *similarity_matrix.from_file(arguments.matrix_file_path))
    edges = [
        (edge[0], edge[1], arguments.statistic.apply(similarity_scores))
        for edge, similarity_scores in edges.items()
    ]
    logger.info(
        "Generated nodes and edges from similarity matrix at {}".format(
            arguments.matrix_file_path))

    csv_files.write_nodes(arguments.output_directory_path, nodes)
    csv_files.write_edges(arguments.output_directory_path, nodes, edges)
    logger.info(
        "Wrote nodes {} and edges {} to directory {}".format(
            nodes, edges, arguments.output_directory_path))


def reduce_transitive_similarity(arguments):
    configure_logging(arguments.debug)
    logger = logging.getLogger(__name__)
    logger.info(
        "Starting application with the following parameters: "
        "matrix_file_path = {}, "
        "output_directory_path = {}, "
        "minimum_proportion = {}, "
        "enactment_years_file_path = {}, "
        "debug = {}".format(
            arguments.matrix_file_path, arguments.output_directory_path,
            arguments.minimum_proportion, arguments.enactment_years_file_path,
            arguments.debug))

    if not os.path.isdir(arguments.output_directory_path):
        raise ValueError("{} is not a directory.".format(
            arguments.output_directory_path))
    matrix_file_name, matrix_file_suffix = \
        arguments.matrix_file_path.split(os.path.sep)[-1].split(PERIOD)
    output_file_path = os.path.join(
        arguments.output_directory_path,
        "{}_reduced_transitive_similarity.{}".format(
            matrix_file_name, matrix_file_suffix))

    labels, rows = similarity_matrix.reduce_transitive_similarity(
        arguments.matrix_file_path, arguments.minimum_proportion,
        csv_files.get_enactment_years(arguments.enactment_years_file_path))
    logger.info(
        "Reduced transitive similarity in similarity matrix at {}".format(
            arguments.matrix_file_path))
    similarity_matrix.add_diagonal_and_upper_triangle_to_matrix(rows)

    csv_files.write_similarity_matrix(
        output_file_path,
        similarity_matrix.get_language(arguments.matrix_file_path),
        zip(labels, rows))
    logger.info(
        "Wrote labels and similarity matrix with reduced transitive similarity "
        "to {}".format(output_file_path))
