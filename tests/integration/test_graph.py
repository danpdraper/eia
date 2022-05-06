import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


def get_nodes_and_edges(output_directory_path):
    nodes_file_path = os.path.join(output_directory_path, 'nodes.csv')
    edges_file_path = os.path.join(output_directory_path, 'edges.csv')

    with open(nodes_file_path, 'r') as file_object:
        nodes = file_object.read()
    with open(edges_file_path, 'r') as file_object:
        edges = file_object.read()

    return nodes, edges


def test_graph_eightieth_percentile():
    '''
    Similarity matrix:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3  ]
        [ A 1 ] [ 1.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 ]
        [ A 2 ] [ 0.01 1.00 0.09 0.10 0.11 0.12 0.13 0.14 0.15 ]
        [ A 3 ] [ 0.02 0.09 1.00 0.16 0.17 0.18 0.19 0.20 0.21 ]
        [ B 1 ] [ 0.03 0.10 0.16 1.00 0.22 0.23 0.24 0.25 0.26 ]
        [ B 2 ] [ 0.04 0.11 0.17 0.22 1.00 0.27 0.28 0.29 0.30 ]
        [ B 3 ] [ 0.05 0.12 0.18 0.23 0.27 1.00 0.31 0.32 0.33 ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31 1.00 0.34 0.35 ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32 0.34 1.00 0.36 ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33 0.35 0.36 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3 ]
        [ A 1 ] [                                             ]
        [ A 2 ] [                                             ]
        [ A 3 ] [                                             ]
        [ B 1 ] [ 0.03 0.10 0.16                              ]
        [ B 2 ] [ 0.04 0.11 0.17                              ]
        [ B 3 ] [ 0.05 0.12 0.18                              ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31               ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32               ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33               ]

    Grouping similarity scores by edge yields:
        (B, A): [0.03, 0.10, 0.16, 0.04, 0.11, 0.17, 0.05, 0.12, 0.18]
        (C, A): [0.06, 0.13, 0.19, 0.07, 0.14, 0.20, 0.08, 0.15, 0.21]
        (C, B): [0.24, 0.28, 0.31, 0.25, 0.29, 0.32, 0.26, 0.30, 0.33]

    Sorting the grouped similarity scores yields:
        (B, A): [0.03, 0.04, 0.05, 0.10, 0.11, 0.12, 0.16, 0.17, 0.18]
        (C, A): [0.06, 0.07, 0.08, 0.13, 0.14, 0.15, 0.19, 0.20, 0.21]
        (C, B): [0.24, 0.25, 0.26, 0.28, 0.29, 0.30, 0.31, 0.32, 0.33]

    The index in each sorted similarity score array corresponding to the
    eightieth percentile is index 6: floor(9 * 0.8) - 1 = 6. The expected values
    corresponding to the eightieth percentile are thus:
        (B, A): 0.16
        (C, A): 0.19
        (C, B): 0.31
    '''
    test_directory_path = utilities.create_test_directory('test_graph')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08\n'
            'State A 2,0.01,1.0,0.09,0.1,0.11,0.12,0.13,0.14,0.15\n'
            'State A 3,0.02,0.09,1.0,0.16,0.17,0.18,0.19,0.2,0.21\n'
            'State B 1,0.03,0.1,0.16,1.0,0.22,0.23,0.24,0.25,0.26\n'
            'State B 2,0.04,0.11,0.17,0.22,1.0,0.27,0.28,0.29,0.3\n'
            'State B 3,0.05,0.12,0.18,0.23,0.27,1.0,0.31,0.32,0.33\n'
            'State C 1,0.06,0.13,0.19,0.24,0.28,0.31,1.0,0.34,0.35\n'
            'State C 2,0.07,0.14,0.2,0.25,0.29,0.32,0.34,1.0,0.36\n'
            'State C 3,0.08,0.15,0.21,0.26,0.3,0.33,0.35,0.36,1.0\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--debug',
                'graph',
                'eightieth_percentile',
                similarity_matrix_file_path,
                test_directory_path,
            ],
            check=True)
        actual_nodes, actual_edges = get_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,1,0,Undirected,0.16000\n'
        '1,2,0,Undirected,0.19000\n'
        '2,2,1,Undirected,0.31000\n'
    )

    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_graph_mean():
    '''
    Similarity matrix:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3  ]
        [ A 1 ] [ 1.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 ]
        [ A 2 ] [ 0.01 1.00 0.09 0.10 0.11 0.12 0.13 0.14 0.15 ]
        [ A 3 ] [ 0.02 0.09 1.00 0.16 0.17 0.18 0.19 0.20 0.21 ]
        [ B 1 ] [ 0.03 0.10 0.16 1.00 0.22 0.23 0.24 0.25 0.26 ]
        [ B 2 ] [ 0.04 0.11 0.17 0.22 1.00 0.27 0.28 0.29 0.30 ]
        [ B 3 ] [ 0.05 0.12 0.18 0.23 0.27 1.00 0.31 0.32 0.33 ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31 1.00 0.34 0.35 ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32 0.34 1.00 0.36 ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33 0.35 0.36 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3 ]
        [ A 1 ] [                                             ]
        [ A 2 ] [                                             ]
        [ A 3 ] [                                             ]
        [ B 1 ] [ 0.03 0.10 0.16                              ]
        [ B 2 ] [ 0.04 0.11 0.17                              ]
        [ B 3 ] [ 0.05 0.12 0.18                              ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31               ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32               ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33               ]

    Grouping similarity scores by edge yields:
        (B, A): [0.03, 0.10, 0.16, 0.04, 0.11, 0.17, 0.05, 0.12, 0.18]
        (C, A): [0.06, 0.13, 0.19, 0.07, 0.14, 0.20, 0.08, 0.15, 0.21]
        (C, B): [0.24, 0.28, 0.31, 0.25, 0.29, 0.32, 0.26, 0.30, 0.33]

    Calculating the mean of each similarity score array yields:
        (B, A): 0.10667
        (C, A): 0.13667
        (C, B): 0.28667
    '''
    test_directory_path = utilities.create_test_directory('test_graph')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08\n'
            'State A 2,0.01,1.0,0.09,0.1,0.11,0.12,0.13,0.14,0.15\n'
            'State A 3,0.02,0.09,1.0,0.16,0.17,0.18,0.19,0.2,0.21\n'
            'State B 1,0.03,0.1,0.16,1.0,0.22,0.23,0.24,0.25,0.26\n'
            'State B 2,0.04,0.11,0.17,0.22,1.0,0.27,0.28,0.29,0.3\n'
            'State B 3,0.05,0.12,0.18,0.23,0.27,1.0,0.31,0.32,0.33\n'
            'State C 1,0.06,0.13,0.19,0.24,0.28,0.31,1.0,0.34,0.35\n'
            'State C 2,0.07,0.14,0.2,0.25,0.29,0.32,0.34,1.0,0.36\n'
            'State C 3,0.08,0.15,0.21,0.26,0.3,0.33,0.35,0.36,1.0\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--debug',
                'graph',
                'mean',
                similarity_matrix_file_path,
                test_directory_path,
            ],
            check=True)
        actual_nodes, actual_edges = get_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,1,0,Undirected,0.10667\n'
        '1,2,0,Undirected,0.13667\n'
        '2,2,1,Undirected,0.28667\n'
    )

    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_graph_median():
    '''
    Similarity matrix:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3  ]
        [ A 1 ] [ 1.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 ]
        [ A 2 ] [ 0.01 1.00 0.09 0.10 0.11 0.12 0.13 0.14 0.15 ]
        [ A 3 ] [ 0.02 0.09 1.00 0.16 0.17 0.18 0.19 0.20 0.21 ]
        [ B 1 ] [ 0.03 0.10 0.16 1.00 0.22 0.23 0.24 0.25 0.26 ]
        [ B 2 ] [ 0.04 0.11 0.17 0.22 1.00 0.27 0.28 0.29 0.30 ]
        [ B 3 ] [ 0.05 0.12 0.18 0.23 0.27 1.00 0.31 0.32 0.33 ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31 1.00 0.34 0.35 ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32 0.34 1.00 0.36 ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33 0.35 0.36 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3 ]
        [ A 1 ] [                                             ]
        [ A 2 ] [                                             ]
        [ A 3 ] [                                             ]
        [ B 1 ] [ 0.03 0.10 0.16                              ]
        [ B 2 ] [ 0.04 0.11 0.17                              ]
        [ B 3 ] [ 0.05 0.12 0.18                              ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31               ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32               ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33               ]

    Grouping similarity scores by edge yields:
        (B, A): [0.03, 0.10, 0.16, 0.04, 0.11, 0.17, 0.05, 0.12, 0.18]
        (C, A): [0.06, 0.13, 0.19, 0.07, 0.14, 0.20, 0.08, 0.15, 0.21]
        (C, B): [0.24, 0.28, 0.31, 0.25, 0.29, 0.32, 0.26, 0.30, 0.33]

    Sorting the grouped similarity scores yields:
        (B, A): [0.03, 0.04, 0.05, 0.10, 0.11, 0.12, 0.16, 0.17, 0.18]
        (C, A): [0.06, 0.07, 0.08, 0.13, 0.14, 0.15, 0.19, 0.20, 0.21]
        (C, B): [0.24, 0.25, 0.26, 0.28, 0.29, 0.30, 0.31, 0.32, 0.33]

    The median of each sorted similarity score array is as follows:
        (B, A): 0.11
        (C, A): 0.14
        (C, B): 0.29
    '''
    test_directory_path = utilities.create_test_directory('test_graph')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08\n'
            'State A 2,0.01,1.0,0.09,0.1,0.11,0.12,0.13,0.14,0.15\n'
            'State A 3,0.02,0.09,1.0,0.16,0.17,0.18,0.19,0.2,0.21\n'
            'State B 1,0.03,0.1,0.16,1.0,0.22,0.23,0.24,0.25,0.26\n'
            'State B 2,0.04,0.11,0.17,0.22,1.0,0.27,0.28,0.29,0.3\n'
            'State B 3,0.05,0.12,0.18,0.23,0.27,1.0,0.31,0.32,0.33\n'
            'State C 1,0.06,0.13,0.19,0.24,0.28,0.31,1.0,0.34,0.35\n'
            'State C 2,0.07,0.14,0.2,0.25,0.29,0.32,0.34,1.0,0.36\n'
            'State C 3,0.08,0.15,0.21,0.26,0.3,0.33,0.35,0.36,1.0\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--debug',
                'graph',
                'median',
                similarity_matrix_file_path,
                test_directory_path,
            ],
            check=True)
        actual_nodes, actual_edges = get_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,1,0,Undirected,0.11000\n'
        '1,2,0,Undirected,0.14000\n'
        '2,2,1,Undirected,0.29000\n'
    )

    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_graph_ninetieth_percentile():
    '''
    Similarity matrix:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3  ]
        [ A 1 ] [ 1.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 ]
        [ A 2 ] [ 0.01 1.00 0.09 0.10 0.11 0.12 0.13 0.14 0.15 ]
        [ A 3 ] [ 0.02 0.09 1.00 0.16 0.17 0.18 0.19 0.20 0.21 ]
        [ B 1 ] [ 0.03 0.10 0.16 1.00 0.22 0.23 0.24 0.25 0.26 ]
        [ B 2 ] [ 0.04 0.11 0.17 0.22 1.00 0.27 0.28 0.29 0.30 ]
        [ B 3 ] [ 0.05 0.12 0.18 0.23 0.27 1.00 0.31 0.32 0.33 ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31 1.00 0.34 0.35 ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32 0.34 1.00 0.36 ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33 0.35 0.36 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3 ]
        [ A 1 ] [                                             ]
        [ A 2 ] [                                             ]
        [ A 3 ] [                                             ]
        [ B 1 ] [ 0.03 0.10 0.16                              ]
        [ B 2 ] [ 0.04 0.11 0.17                              ]
        [ B 3 ] [ 0.05 0.12 0.18                              ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31               ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32               ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33               ]

    Grouping similarity scores by edge yields:
        (B, A): [0.03, 0.10, 0.16, 0.04, 0.11, 0.17, 0.05, 0.12, 0.18]
        (C, A): [0.06, 0.13, 0.19, 0.07, 0.14, 0.20, 0.08, 0.15, 0.21]
        (C, B): [0.24, 0.28, 0.31, 0.25, 0.29, 0.32, 0.26, 0.30, 0.33]

    Sorting the grouped similarity scores yields:
        (B, A): [0.03, 0.04, 0.05, 0.10, 0.11, 0.12, 0.16, 0.17, 0.18]
        (C, A): [0.06, 0.07, 0.08, 0.13, 0.14, 0.15, 0.19, 0.20, 0.21]
        (C, B): [0.24, 0.25, 0.26, 0.28, 0.29, 0.30, 0.31, 0.32, 0.33]

    The index in each sorted similarity score array corresponding to the
    ninetieth percentile is index 7: floor(9 * 0.9) - 1 = 7. The expected values
    corresponding to the ninetieth percentile are thus:
        (B, A): 0.17
        (C, A): 0.20
        (C, B): 0.32
    '''
    test_directory_path = utilities.create_test_directory('test_graph')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08\n'
            'State A 2,0.01,1.0,0.09,0.1,0.11,0.12,0.13,0.14,0.15\n'
            'State A 3,0.02,0.09,1.0,0.16,0.17,0.18,0.19,0.2,0.21\n'
            'State B 1,0.03,0.1,0.16,1.0,0.22,0.23,0.24,0.25,0.26\n'
            'State B 2,0.04,0.11,0.17,0.22,1.0,0.27,0.28,0.29,0.3\n'
            'State B 3,0.05,0.12,0.18,0.23,0.27,1.0,0.31,0.32,0.33\n'
            'State C 1,0.06,0.13,0.19,0.24,0.28,0.31,1.0,0.34,0.35\n'
            'State C 2,0.07,0.14,0.2,0.25,0.29,0.32,0.34,1.0,0.36\n'
            'State C 3,0.08,0.15,0.21,0.26,0.3,0.33,0.35,0.36,1.0\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--debug',
                'graph',
                'ninetieth_percentile',
                similarity_matrix_file_path,
                test_directory_path,
            ],
            check=True)
        actual_nodes, actual_edges = get_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,1,0,Undirected,0.17000\n'
        '1,2,0,Undirected,0.20000\n'
        '2,2,1,Undirected,0.32000\n'
    )

    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_graph_ninetyninth_percentile():
    '''
    Similarity matrix:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3  ]
        [ A 1 ] [ 1.00 0.01 0.02 0.03 0.04 0.05 0.06 0.07 0.08 ]
        [ A 2 ] [ 0.01 1.00 0.09 0.10 0.11 0.12 0.13 0.14 0.15 ]
        [ A 3 ] [ 0.02 0.09 1.00 0.16 0.17 0.18 0.19 0.20 0.21 ]
        [ B 1 ] [ 0.03 0.10 0.16 1.00 0.22 0.23 0.24 0.25 0.26 ]
        [ B 2 ] [ 0.04 0.11 0.17 0.22 1.00 0.27 0.28 0.29 0.30 ]
        [ B 3 ] [ 0.05 0.12 0.18 0.23 0.27 1.00 0.31 0.32 0.33 ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31 1.00 0.34 0.35 ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32 0.34 1.00 0.36 ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33 0.35 0.36 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  A 3  B 1  B 2  B 3  C 1  C 2  C 3 ]
        [ A 1 ] [                                             ]
        [ A 2 ] [                                             ]
        [ A 3 ] [                                             ]
        [ B 1 ] [ 0.03 0.10 0.16                              ]
        [ B 2 ] [ 0.04 0.11 0.17                              ]
        [ B 3 ] [ 0.05 0.12 0.18                              ]
        [ C 1 ] [ 0.06 0.13 0.19 0.24 0.28 0.31               ]
        [ C 2 ] [ 0.07 0.14 0.20 0.25 0.29 0.32               ]
        [ C 3 ] [ 0.08 0.15 0.21 0.26 0.30 0.33               ]

    Grouping similarity scores by edge yields:
        (B, A): [0.03, 0.10, 0.16, 0.04, 0.11, 0.17, 0.05, 0.12, 0.18]
        (C, A): [0.06, 0.13, 0.19, 0.07, 0.14, 0.20, 0.08, 0.15, 0.21]
        (C, B): [0.24, 0.28, 0.31, 0.25, 0.29, 0.32, 0.26, 0.30, 0.33]

    Sorting the grouped similarity scores yields:
        (B, A): [0.03, 0.04, 0.05, 0.10, 0.11, 0.12, 0.16, 0.17, 0.18]
        (C, A): [0.06, 0.07, 0.08, 0.13, 0.14, 0.15, 0.19, 0.20, 0.21]
        (C, B): [0.24, 0.25, 0.26, 0.28, 0.29, 0.30, 0.31, 0.32, 0.33]

    The index in each sorted similarity score array corresponding to the
    ninetyninth percentile is index 7: floor(9 * 0.99) - 1 = 7. The expected
    values corresponding to the ninetyninth percentile are thus:
        (B, A): 0.17
        (C, A): 0.20
        (C, B): 0.32
    '''
    test_directory_path = utilities.create_test_directory('test_graph')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08\n'
            'State A 2,0.01,1.0,0.09,0.1,0.11,0.12,0.13,0.14,0.15\n'
            'State A 3,0.02,0.09,1.0,0.16,0.17,0.18,0.19,0.2,0.21\n'
            'State B 1,0.03,0.1,0.16,1.0,0.22,0.23,0.24,0.25,0.26\n'
            'State B 2,0.04,0.11,0.17,0.22,1.0,0.27,0.28,0.29,0.3\n'
            'State B 3,0.05,0.12,0.18,0.23,0.27,1.0,0.31,0.32,0.33\n'
            'State C 1,0.06,0.13,0.19,0.24,0.28,0.31,1.0,0.34,0.35\n'
            'State C 2,0.07,0.14,0.2,0.25,0.29,0.32,0.34,1.0,0.36\n'
            'State C 3,0.08,0.15,0.21,0.26,0.3,0.33,0.35,0.36,1.0\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--debug',
                'graph',
                'ninetyninth_percentile',
                similarity_matrix_file_path,
                test_directory_path,
            ],
            check=True)
        actual_nodes, actual_edges = get_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,1,0,Undirected,0.17000\n'
        '1,2,0,Undirected,0.20000\n'
        '2,2,1,Undirected,0.32000\n'
    )

    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_graph_invalid_output_directory():
    test_directory_path = utilities.create_test_directory('test_graph')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.01,0.02,0.03,0.04,0.05,0.06,0.07,0.08\n'
            'State A 2,0.01,1.0,0.09,0.1,0.11,0.12,0.13,0.14,0.15\n'
            'State A 3,0.02,0.09,1.0,0.16,0.17,0.18,0.19,0.2,0.21\n'
            'State B 1,0.03,0.1,0.16,1.0,0.22,0.23,0.24,0.25,0.26\n'
            'State B 2,0.04,0.11,0.17,0.22,1.0,0.27,0.28,0.29,0.3\n'
            'State B 3,0.05,0.12,0.18,0.23,0.27,1.0,0.31,0.32,0.33\n'
            'State C 1,0.06,0.13,0.19,0.24,0.28,0.31,1.0,0.34,0.35\n'
            'State C 2,0.07,0.14,0.2,0.25,0.29,0.32,0.34,1.0,0.36\n'
            'State C 3,0.08,0.15,0.21,0.26,0.3,0.33,0.35,0.36,1.0\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    output_directory_path = os.path.join(
        os.path.sep, 'invalid', 'output', 'directory', 'path')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        completed_process = subprocess.run(
            [
                script_file_path,
                '--debug',
                'graph',
                'median',
                similarity_matrix_file_path,
                output_directory_path,
            ],
            capture_output=True,
            text=True)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert 0 != completed_process.returncode
    assert 'ValueError' in completed_process.stderr
