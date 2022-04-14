import os

import eia.files.csv_files as csv_files
import eia.tests.utilities as utilities


def test_contains_comma_returns_true_when_string_contains_comma():
    assert csv_files.contains_comma('test, string') is True


def test_contains_comma_returns_false_when_string_does_not_contain_comma():
    assert csv_files.contains_comma('test string') is False


def test_write_similarity_matrix_writes_language_and_labels_and_similarity_matrix_to_provided_file_path():
    test_directory_path = utilities.create_test_directory('test_csv_files')
    similarity_matrix_file_path = os.path.join(test_directory_path, 'matrix.csv')
    language = 'english'
    labels_and_rows = [
        ('A 1', [0.01, 0.02, 0.03, 0.04]),
        ('B 1', [0.05, 0.06, 0.07, 0.08]),
        ('C 1', [0.09, 0.10, 0.11, 0.12]),
        ('D 1', [0.13, 0.14, 0.15, 0.16]),
    ]

    expected_file_contents = (
        'language:english\n'
        'A 1,0.01000,0.02000,0.03000,0.04000\n'
        'B 1,0.05000,0.06000,0.07000,0.08000\n'
        'C 1,0.09000,0.10000,0.11000,0.12000\n'
        'D 1,0.13000,0.14000,0.15000,0.16000\n'
    )

    try:
        csv_files.write_similarity_matrix(
            similarity_matrix_file_path, language, labels_and_rows)
        with open(similarity_matrix_file_path, 'r') as file_object:
            actual_file_contents = file_object.read()
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_file_contents == actual_file_contents


def test_write_nodes_writes_identifiers_and_labels_and_headers_to_provided_file():
    test_directory_path = utilities.create_test_directory('test_csv_files')
    nodes = {'D', 'C', 'B', 'A'}

    nodes_file_path = os.path.join(test_directory_path, 'nodes.csv')
    expected_file_contents = (
        'ID,Label\n'
        '0,A\n'
        '1,B\n'
        '2,C\n'
        '3,D\n'
    )

    try:
        csv_files.write_nodes(test_directory_path, nodes)
        with open(nodes_file_path, 'r') as file_object:
            actual_file_contents = file_object.read()
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_file_contents == actual_file_contents


def test_write_edges_writes_identifiers_and_nodes_and_type_and_weight_and_headers_to_provided_file():
    test_directory_path = utilities.create_test_directory('test_csv_files')
    nodes = {'D', 'C', 'B', 'A'}
    edges = [
        ('A', 'D', 5),
        ('B', 'C', 4),
        ('A', 'C', 3),
        ('A', 'B', 2),
        ('B', 'D', 1),
    ]

    edges_file_path = os.path.join(test_directory_path, 'edges.csv')
    expected_file_contents = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,2\n'
        '1,0,2,Undirected,3\n'
        '2,0,3,Undirected,5\n'
        '3,1,2,Undirected,4\n'
        '4,1,3,Undirected,1\n'
    )

    try:
        csv_files.write_edges(test_directory_path, nodes, edges)
        with open(edges_file_path, 'r') as file_object:
            actual_file_contents = file_object.read()
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_file_contents == actual_file_contents
