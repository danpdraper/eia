import logging
import os

import eia.files.input_output as input_output
import eia.transformations as transformations


COMMA = ','
EDGES_FILE_NAME = 'edges.csv'
NODES_FILE_NAME = 'nodes.csv'


LOGGER = logging.getLogger(__name__)


def contains_comma(string):
    return COMMA in string


def write_similarity_matrix(similarity_matrix_file_path, language, labels_and_rows):
    input_output.write(similarity_matrix_file_path, ["language:{}".format(language)])
    input_output.append(
        similarity_matrix_file_path, map(
            lambda value: transformations.label_and_row_tuple_to_comma_separated_string(value),
            labels_and_rows))


def write_nodes(nodes_directory_path, nodes):
    nodes_file_path = os.path.join(nodes_directory_path, NODES_FILE_NAME)
    input_output.write(
        nodes_file_path,
        ['ID,Label'] + [
            "{},{}".format(index, node) for index, node in enumerate(sorted(nodes))
        ])


def write_edges(edges_directory_path, nodes, edges):
    edges_file_path = os.path.join(edges_directory_path, EDGES_FILE_NAME)
    sorted_nodes = sorted(list(nodes))
    input_output.write(
        edges_file_path,
        ['ID,Source,Target,Type,Weight'] + [
            "{},{},{},Undirected,{}".format(
                index, sorted_nodes.index(edge[0]), sorted_nodes.index(edge[1]),
                edge[2]) for index, edge in enumerate(
                    sorted(
                        sorted(edges, key=lambda edge: edge[1]),
                        key=lambda edge: edge[0]))
        ])


def get_enactment_years(enactment_years_file_path):
    enactment_years = {}
    for state_and_enactment_year in input_output.line_generator(enactment_years_file_path):
        LOGGER.debug("Read {} from {}".format(
            state_and_enactment_year, enactment_years_file_path))
        state, enactment_year = state_and_enactment_year.split(COMMA)
        enactment_years[state] = int(enactment_year)
    return enactment_years
