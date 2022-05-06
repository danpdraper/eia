import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


def get_highest_provision_group_scores_and_nodes_and_edges(test_directory_path):
    highest_provision_group_scores_file_path = os.path.join(
        test_directory_path, 'highest_provision_group_scores.txt')
    nodes_file_path = os.path.join(test_directory_path, 'nodes.csv')
    edges_file_path = os.path.join(test_directory_path, 'edges.csv')
    with open(highest_provision_group_scores_file_path, 'r') as file_object:
        highest_provision_group_scores = file_object.read()
    with open(nodes_file_path, 'r') as file_object:
        nodes = file_object.read()
    with open(edges_file_path, 'r') as file_object:
        edges = file_object.read()
    return highest_provision_group_scores, nodes, edges


def execute_highest_similarity_scores_without_provision_contents_test(
        number_of_scores, expected_highest_provision_group_scores, expected_nodes,
        expected_edges):
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [ 1.00 0.06 0.11 0.16 0.21 0.26 ]
        [ A 2 ] [ 0.06 1.00 0.90 0.85 0.80 0.75 ]
        [ B 1 ] [ 0.11 0.90 1.00 0.17 0.22 0.27 ]
        [ B 2 ] [ 0.16 0.85 0.17 1.00 0.79 0.74 ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79 1.00 0.28 ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74 0.28 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [ 0.11 0.90                     ]
        [ B 2 ] [ 0.16 0.85                     ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79           ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74           ]

    The application should rank row-wise provision groups by the scaled average
    of the constituent provision pair similarity scores, where the scaled
    average is the arithmetic average of the pair scores multiplied by the
    number of provisions in the group minus one (to account for the fact that a
    provision group cannot contain less than two provisions).

    The following table lists each remaining provision combination, the
    associated row-wise provision pair scores, the arithmetic average of said
    scores and the scaled average of said scores. Taking provision group 'A 1,B
    1,C 1' as an example, pairs 'C 1,A 1' and 'C 1,B 1' have similarity scores
    of 0.21 and 0.22 respectively. The arithmetic average of these scores is
    (0.21 + 0.22) / 2 = 0.215, while the scaled average is 0.215 * (3 - 1) = 0.430.

    Provision group  Group pair scores  Average pair score  Scaled average
    A 1,B 1          0.11               0.110               0.110
    A 1,B 2          0.16               0.160               0.160
    A 1,C 1          0.21               0.210               0.210
    A 1,C 2          0.26               0.260               0.260
    A 2,B 1          0.90               0.900               0.900
    A 2,B 2          0.85               0.850               0.850
    A 2,C 1          0.80               0.800               0.800
    A 2,C 2          0.75               0.750               0.750
    B 1,C 1          0.22               0.220               0.220
    B 1,C 2          0.27               0.270               0.270
    B 2,C 1          0.79               0.790               0.790
    B 2,C 2          0.74               0.740               0.740
    A 1,B 1,C 1      0.21,0.22          0.215               0.430
    A 1,B 1,C 2      0.26,0.27          0.265               0.530
    A 1,B 2,C 1      0.21,0.79          0.500               1.000
    A 1,B 2,C 2      0.26,0.74          0.500               1.000
    A 2,B 1,C 1      0.80,0.22          0.510               1.020
    A 2,B 1,C 2      0.75,0.27          0.510               1.020
    A 2,B 2,C 1      0.80,0.79          0.795               1.590
    A 2,B 2,C 2      0.75,0.74          0.745               1.490

    The following table lists the provision groups sorted by scaled average in
    descending order.

    Provision group  Scaled average
    A 2,B 2,C 1      1.590
    A 2,B 2,C 2      1.490
    A 2,B 1,C 1      1.020
    A 2,B 1,C 2      1.020
    A 1,B 2,C 1      1.000
    A 1,B 2,C 2      1.000
    A 2,B 1          0.900
    A 2,B 2          0.850
    A 2,C 1          0.800
    B 2,C 1          0.790
    A 2,C 2          0.750
    B 2,C 2          0.740
    A 1,B 1,C 2      0.530
    A 1,B 1,C 1      0.430
    B 1,C 2          0.270
    A 1,C 2          0.260
    B 1,C 1          0.220
    A 1,C 1          0.210
    A 1,B 2          0.160
    A 1,B 1          0.110

    The application should also identify all of the nodes and edges among the
    provision groups, with each node representing a state and the weight of each
    edge representing the number of unique combinations of provisions of the two
    connected nodes that appear together in a group.

    Among the provision groups above, there are only three nodes: A, B and C.
    Each of those nodes appears in sixteen provision groups. Each provision of
    each node appears in eight groups. Each provision of each node appears in
    the same group as each of the other provisions (of different nodes) three
    times. That said, there are only four unique combinations of provision pairs
    of which each provision is a member. For example, provision 'A 1' is a
    member of four unique combinations of provision pairs: 'A 1,B 1', 'A 1,B 2',
    'A 1,C 1' and 'A 1,C 2'. As only two of those combinations involve a given
    pair of nodes, the most that a given provision can contribute to the weight
    of an edge in this case is four (two for each of the two provisions
    associated with each node). The edge table corresponding to the list of
    provision groups above thus takes the following form:

    First node  Second node  Weight
    A           B            4
    A           C            4
    B           C            4
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.06,0.11,0.16,0.21,0.26\n'
            'State A 2,0.06,1.0,0.9,0.85,0.8,0.75\n'
            'State B 1,0.11,0.9,1.0,0.17,0.22,0.27\n'
            'State B 2,0.16,0.85,0.17,1.0,0.79,0.74\n'
            'State C 1,0.21,0.8,0.22,0.79,1.0,0.28\n'
            'State C 2,0.26,0.75,0.27,0.74,0.28,1.0\n'
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
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                str(number_of_scores),
            ],
            check=True)
        actual_highest_provision_group_scores, actual_nodes, actual_edges = \
            get_highest_provision_group_scores_and_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_highest_provision_group_scores == actual_highest_provision_group_scores
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_highest_similarity_scores_without_provision_contents():
    # Six highest scores
    expected_highest_provision_group_scores = (
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.590\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.490\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 1.020\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 1.020\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.000\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.000\n'
    )
    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,3.00000\n'
        '1,0,2,Undirected,4.00000\n'
        '2,1,2,Undirected,4.00000\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        6, expected_highest_provision_group_scores, expected_nodes, expected_edges)

    # Ten highest scores
    expected_highest_provision_group_scores += (
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'Scaled average: 0.900\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'Scaled average: 0.850\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State C 1\n'
        'Scaled average: 0.800\n'
        '\n'
        '----------\n'
        '\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 0.790\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        10, expected_highest_provision_group_scores, expected_nodes, expected_edges)

    # Fifteen highest scores
    expected_highest_provision_group_scores += (
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State C 2\n'
        'Scaled average: 0.750\n'
        '\n'
        '----------\n'
        '\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 0.740\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 0.530\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 0.430\n'
        '\n'
        '----------\n'
        '\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 0.270\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,4.00000\n'
        '1,0,2,Undirected,4.00000\n'
        '2,1,2,Undirected,4.00000\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        15, expected_highest_provision_group_scores, expected_nodes, expected_edges)

    # Twenty highest scores
    expected_highest_provision_group_scores += (
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State C 2\n'
        'Scaled average: 0.260\n'
        '\n'
        '----------\n'
        '\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 0.220\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State C 1\n'
        'Scaled average: 0.210\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'Scaled average: 0.160\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'Scaled average: 0.110\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        20, expected_highest_provision_group_scores, expected_nodes, expected_edges)


def execute_highest_similarity_scores_without_provision_contents_but_with_score_threshold_test(
        number_of_scores, expected_highest_provision_group_scores,
        expected_nodes, expected_edges):
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [ 1.00 0.06 0.11 0.16 0.21 0.26 ]
        [ A 2 ] [ 0.06 1.00 0.90 0.85 0.80 0.75 ]
        [ B 1 ] [ 0.11 0.90 1.00 0.17 0.22 0.27 ]
        [ B 2 ] [ 0.16 0.85 0.17 1.00 0.79 0.74 ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79 1.00 0.28 ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74 0.28 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [ 0.11 0.90                     ]
        [ B 2 ] [ 0.16 0.85                     ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79           ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74           ]

    The mean of the remaining scores is:

    mean = sum(0.11, 0.90, 0.16, 0.85, 0.21, 0.80, 0.22, 0.79, 0.26, 0.75,
               0.27, 0.74) / 12
    mean = 6.06 / 12 = 0.505

    The standard deviation of the remaining scores is:

    stddev = sqrt(sum((0.11 - 0.505) ^ 2, (0.90 - 0.505) ^ 2, (0.16 - 0.505) ^ 2,
                      (0.85 - 0.505) ^ 2, (0.21 - 0.505) ^ 2, (0.80 - 0.505) ^ 2,
                      (0.22 - 0.505) ^ 2, (0.79 - 0.505) ^ 2, (0.26 - 0.505) ^ 2,
                      (0.75 - 0.505) ^ 2, (0.27 - 0.505) ^ 2, (0.74 - 0.505) ^ 2) / 12)
    stddev ~= sqrt(1.12 / 12) ~= 0.305

    Excluding the remaining scores that are less than 0.5 standard deviations
    above the mean leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [      0.90                     ]
        [ B 2 ] [      0.85                     ]
        [ C 1 ] [      0.80      0.79           ]
        [ C 2 ] [      0.75      0.74           ]

    The application should rank row-wise provision groups by the scaled average
    of the constituent provision pair similarity scores, where the scaled
    average is the arithmetic average of the pair scores multiplied by the
    number of provisions in the group minus one (to account for the fact that a
    provision group cannot contain less than two provisions).

    The following table lists each remaining provision combination, the
    associated row-wise provision pair scores, the arithmetic average of said
    scores and the scaled average of said scores. Taking provision group 'A 2,B
    2,C 1' as an example, pairs 'C 1,A 2' and 'C 1,B 2' have similarity scores
    of 0.80 and 0.79 respectively. The arithmetic average of these scores is
    (0.80 + 0.79) / 2 = 0.795, while the scaled average is 0.795 * (3 - 1) = 1.590.

    Provision group  Group pair scores  Average pair score  Scaled average
    A 2,B 1          0.90               0.900               0.900
    A 2,B 2          0.85               0.850               0.850
    A 2,C 1          0.80               0.800               0.800
    A 2,C 2          0.75               0.750               0.750
    B 2,C 1          0.79               0.790               0.790
    B 2,C 2          0.74               0.740               0.740
    A 2,B 2,C 1      0.80,0.79          0.795               1.590
    A 2,B 2,C 2      0.75,0.74          0.745               1.490

    The following table lists the provision groups sorted by scaled average in
    descending order.

    Provision group  Scaled average
    A 2,B 2,C 1      1.590
    A 2,B 2,C 2      1.490
    A 2,B 1          0.900
    A 2,B 2          0.850
    A 2,C 1          0.800
    B 2,C 1          0.790
    A 2,C 2          0.750
    B 2,C 2          0.740

    The application should also identify all of the nodes and edges among the
    provision groups, with each node representing a state and the weight of each
    edge representing the number of unique combinations of provisions of the two
    connected nodes that appear together in a group.

    Among the provision groups above, there are only three nodes: A, B and C.
    Node A appears in six provision groups, while nodes B and C each appear in
    five provision groups. The following table lists the number of times that
    each provision pair appears in the same group together.

    First provision  Second provision  Appearances in same group
    A 2              B 1               1
    A 2              B 2               3
    A 2              C 1               2
    A 2              C 2               2
    B 2              C 1               2
    B 2              C 2               1

    While 'A 2' appears in the same group as each of the other provisions (of
    different nodes) a total of seven times, there are only four unique
    combinations of provision pairs of which provision 'A 2' is a member:
    'A 2,B 1', 'A 2,B 2', 'A 2,C 1' and 'A 2,C 2'. Similarly, while 'B 2'
    appears in the same group as the other provisions a total of six times,
    there are only three unique combinations of provision pairs of which
    provision 'B 2' is a member: 'A 2,B 2', 'B 2,C 1' and 'B 2,C 2'. Thus, in
    total, there are six unique combinations of provisions ('A 2,B 2' is
    included in both of the foregoing lists), two of which involve the node pair
    'A,B', two of which involve the node pair 'A,C' and two of which involve the
    node pair 'B,C'. Consequently, the edge table corresponding to the list of
    provision groups above should take the following form:

    First node  Second node  Weight
    A           B            2
    A           C            2
    B           C            2
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.06,0.11,0.16,0.21,0.26\n'
            'State A 2,0.06,1.0,0.9,0.85,0.8,0.75\n'
            'State B 1,0.11,0.9,1.0,0.17,0.22,0.27\n'
            'State B 2,0.16,0.85,0.17,1.0,0.79,0.74\n'
            'State C 1,0.21,0.8,0.22,0.79,1.0,0.28\n'
            'State C 2,0.26,0.75,0.27,0.74,0.28,1.0\n'
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
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                str(number_of_scores),
                '--score_threshold',
                '0.5'
            ],
            check=True)
        actual_highest_provision_group_scores, actual_nodes, actual_edges = \
            get_highest_provision_group_scores_and_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_highest_provision_group_scores == actual_highest_provision_group_scores
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_highest_similarity_scores_without_provision_contents_but_with_score_threshold():
    # Five highest scores
    expected_highest_provision_group_scores = (
        'Mean: 0.505\n'
        'Standard deviation: 0.305\n'
        'Mean + 0.5 * standard deviation: 0.658\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.590\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.490\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'Scaled average: 0.900\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'Scaled average: 0.850\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State C 1\n'
        'Scaled average: 0.800\n'
    )
    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,2.00000\n'
        '1,0,2,Undirected,2.00000\n'
        '2,1,2,Undirected,2.00000\n'
    )
    execute_highest_similarity_scores_without_provision_contents_but_with_score_threshold_test(
        5, expected_highest_provision_group_scores, expected_nodes, expected_edges)

    # Ten highest scores
    expected_highest_provision_group_scores += (
        '\n'
        '----------\n'
        '\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 0.790\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State C 2\n'
        'Scaled average: 0.750\n'
        '\n'
        '----------\n'
        '\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 0.740\n'
    )
    execute_highest_similarity_scores_without_provision_contents_but_with_score_threshold_test(
        10, expected_highest_provision_group_scores, expected_nodes, expected_edges)


def test_highest_similarity_scores_without_provision_contents_but_with_redundancy_reduction():
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [ 1.00 0.06 0.11 0.16 0.21 0.26 ]
        [ A 2 ] [ 0.06 1.00 0.90 0.85 0.80 0.75 ]
        [ B 1 ] [ 0.11 0.90 1.00 0.17 0.22 0.27 ]
        [ B 2 ] [ 0.16 0.85 0.17 1.00 0.79 0.74 ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79 1.00 0.28 ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74 0.28 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [ 0.11 0.90                     ]
        [ B 2 ] [ 0.16 0.85                     ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79           ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74           ]

    The application should rank row-wise provision groups by the scaled average
    of the constituent provision pair similarity scores, where the scaled
    average is the arithmetic average of the pair scores multiplied by the
    number of provisions in the group minus one (to account for the fact that a
    provision group cannot contain less than two provisions).

    The following table lists each remaining provision combination, the
    associated row-wise provision pair scores, the arithmetic average of said
    scores and the scaled average of said scores. Taking provision group 'A 1,B
    1,C 1' as an example, pairs 'C 1,A 1' and 'C 1,B 1' have similarity scores
    of 0.21 and 0.22 respectively. The arithmetic average of these scores is
    (0.21 + 0.22) / 2 = 0.215, while the scaled average is 0.215 * (3 - 1) = 0.430.

    Provision group  Group pair scores  Average pair score  Scaled average
    A 1,B 1          0.11               0.110               0.110
    A 1,B 2          0.16               0.160               0.160
    A 1,C 1          0.21               0.210               0.210
    A 1,C 2          0.26               0.260               0.260
    A 2,B 1          0.90               0.900               0.900
    A 2,B 2          0.85               0.850               0.850
    A 2,C 1          0.80               0.800               0.800
    A 2,C 2          0.75               0.750               0.750
    B 1,C 1          0.22               0.220               0.220
    B 1,C 2          0.27               0.270               0.270
    B 2,C 1          0.79               0.790               0.790
    B 2,C 2          0.74               0.740               0.740
    A 1,B 1,C 1      0.21,0.22          0.215               0.430
    A 1,B 1,C 2      0.26,0.27          0.265               0.530
    A 1,B 2,C 1      0.21,0.79          0.500               1.000
    A 1,B 2,C 2      0.26,0.74          0.500               1.000
    A 2,B 1,C 1      0.80,0.22          0.510               1.020
    A 2,B 1,C 2      0.75,0.27          0.510               1.020
    A 2,B 2,C 1      0.80,0.79          0.795               1.590
    A 2,B 2,C 2      0.75,0.74          0.745               1.490

    The following table lists the provision groups sorted by scaled average in
    descending order and excludes any provision group that is a subset of
    another group with a higher score. The excluded groups should not factor
    into the output when the reduce_redundancy_in_output argument is provided.

    Provision group  Scaled average
    A 2,B 2,C 1      1.590
    A 2,B 2,C 2      1.490
    A 2,B 1,C 1      1.020
    A 2,B 1,C 2      1.020
    A 1,B 2,C 1      1.000
    A 1,B 2,C 2      1.000
    A 1,B 1,C 2      0.530
    A 1,B 1,C 1      0.430

    The application should also identify all of the nodes and edges among the
    provision groups, with each node representing a state and the weight of each
    edge representing the number of unique combinations of provisions of the two
    connected nodes that appear together in a group.

    Among the provision groups above, there are only three nodes: A, B and C.
    Each node appears in all eight provision groups. While each provision
    appears in the same group as each of the other provisions (of different nodes)
    twice, there are only four unique combinations of provision pairs of which
    each provision is a member. For example, provision 'A 1' appears in the same
    provision group as each of 'B 1', 'B 2', 'C 1' and 'C 2' twice, but is only
    a member of four unique combinations of provision pairs: 'A 1,B 1',
    'A 1,B 2', 'A 1,C 1' and 'A 1,C 2'. Two of the unique combinations involve
    one of the two potential node pairs, while the other two unique combinations
    involve the other potential node pair (i.e. 'A,B' and 'A,C' in the preceding
    example). As there are two provisions per node, the edge table corresponding
    to the list of provision groups above should take the following form:

    First node  Second node  Weight
    A           B            4
    A           C            4
    B           C            4
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.06,0.11,0.16,0.21,0.26\n'
            'State A 2,0.06,1.0,0.9,0.85,0.8,0.75\n'
            'State B 1,0.11,0.9,1.0,0.17,0.22,0.27\n'
            'State B 2,0.16,0.85,0.17,1.0,0.79,0.74\n'
            'State C 1,0.21,0.8,0.22,0.79,1.0,0.28\n'
            'State C 2,0.26,0.75,0.27,0.74,0.28,1.0\n'
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
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                '10',
                '--reduce_redundancy_in_output'
            ],
            check=True)
        actual_highest_provision_group_scores, actual_nodes, actual_edges = \
            get_highest_provision_group_scores_and_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_highest_provision_group_scores = (
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.590\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.490\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 1.020\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 1.020\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.000\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.000\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 0.530\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 0.430\n'
    )
    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,4.00000\n'
        '1,0,2,Undirected,4.00000\n'
        '2,1,2,Undirected,4.00000\n'
    )
    assert expected_highest_provision_group_scores == actual_highest_provision_group_scores
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_highest_similarity_scores_with_provision_contents():
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [ 1.00 0.06 0.11 0.16 0.21 0.26 ]
        [ A 2 ] [ 0.06 1.00 0.90 0.85 0.80 0.75 ]
        [ B 1 ] [ 0.11 0.90 1.00 0.17 0.22 0.27 ]
        [ B 2 ] [ 0.16 0.85 0.17 1.00 0.79 0.74 ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79 1.00 0.28 ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74 0.28 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [ 0.11 0.90                     ]
        [ B 2 ] [ 0.16 0.85                     ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79           ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74           ]

    The application should rank row-wise provision groups by the scaled average
    of the constituent provision pair similarity scores, where the scaled
    average is the arithmetic average of the pair scores multiplied by the
    number of provisions in the group minus one (to account for the fact that a
    provision group cannot contain less than two provisions).

    The following table lists each remaining provision combination, the
    associated row-wise provision pair scores, the arithmetic average of said
    scores and the scaled average of said scores. Taking provision group 'A 1,B
    1,C 1' as an example, pairs 'C 1,A 1' and 'C 1,B 1' have similarity scores
    of 0.21 and 0.22 respectively. The arithmetic average of these scores is
    (0.21 + 0.22) / 2 = 0.215, while the scaled average is 0.215 * (3 - 1) = 0.430.

    Provision group  Group pair scores  Average pair score  Scaled average
    A 1,B 1          0.11               0.110               0.110
    A 1,B 2          0.16               0.160               0.160
    A 1,C 1          0.21               0.210               0.210
    A 1,C 2          0.26               0.260               0.260
    A 2,B 1          0.90               0.900               0.900
    A 2,B 2          0.85               0.850               0.850
    A 2,C 1          0.80               0.800               0.800
    A 2,C 2          0.75               0.750               0.750
    B 1,C 1          0.22               0.220               0.220
    B 1,C 2          0.27               0.270               0.270
    B 2,C 1          0.79               0.790               0.790
    B 2,C 2          0.74               0.740               0.740
    A 1,B 1,C 1      0.21,0.22          0.215               0.430
    A 1,B 1,C 2      0.26,0.27          0.265               0.530
    A 1,B 2,C 1      0.21,0.79          0.500               1.000
    A 1,B 2,C 2      0.26,0.74          0.500               1.000
    A 2,B 1,C 1      0.80,0.22          0.510               1.020
    A 2,B 1,C 2      0.75,0.27          0.510               1.020
    A 2,B 2,C 1      0.80,0.79          0.795               1.590
    A 2,B 2,C 2      0.75,0.74          0.745               1.490

    The following table lists the provision groups sorted by scaled average in
    descending order.

    Provision group  Scaled average
    A 2,B 2,C 1      1.590
    A 2,B 2,C 2      1.490
    A 2,B 1,C 1      1.020
    A 2,B 1,C 2      1.020
    A 1,B 2,C 1      1.000
    A 1,B 2,C 2      1.000
    A 2,B 1          0.900
    A 2,B 2          0.850
    A 2,C 1          0.800
    B 2,C 1          0.790
    A 2,C 2          0.750
    B 2,C 2          0.740
    A 1,B 1,C 2      0.530
    A 1,B 1,C 1      0.430
    B 1,C 2          0.270
    A 1,C 2          0.260
    B 1,C 1          0.220
    A 1,C 1          0.210
    A 1,B 2          0.160
    A 1,B 1          0.110

    The application should also identify all of the nodes and edges among the
    provision groups, with each node representing a state and the weight of each
    edge representing the number of unique combinations of provisions of the two
    connected nodes that appear together in a group.

    Among the provision groups above, there are only three nodes: A, B and C.
    Each of those nodes appears in sixteen provision groups. Each provision of
    each node appears in eight groups. Each provision of each node appears in
    the same group as each of the other provisions (of different nodes) three
    times. That said, there are only four unique combinations of provision pairs
    of which each provision is a member. For example, provision 'A 1' is a
    member of four unique combinations of provision pairs: 'A 1,B 1', 'A 1,B 2',
    'A 1,C 1' and 'A 1,C 2'. As only two of those combinations involve a given
    pair of nodes, the most that a given provision can contribute to the weight
    of an edge in this case is four (two for each of the two provisions
    associated with each node). The edge table corresponding to the list of
    provision groups above thus takes the following form:

    First node  Second node  Weight
    A           B            4
    A           C            4
    B           C            4
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.06,0.11,0.16,0.21,0.26\n'
            'State A 2,0.06,1.0,0.9,0.85,0.8,0.75\n'
            'State B 1,0.11,0.9,1.0,0.17,0.22,0.27\n'
            'State B 2,0.16,0.85,0.17,1.0,0.79,0.74\n'
            'State C 1,0.21,0.8,0.22,0.79,1.0,0.28\n'
            'State C 2,0.26,0.75,0.27,0.74,0.28,1.0\n'
        ),
        os.path.join('legislation', 'state_a_english.txt'): (
            '(1) First provision in State A legislation\n'
            '(2) Second provision in State A legislation\n'
        ),
        os.path.join('legislation', 'state_a_french.txt'): (
            "(1) Première disposition de la législation de l'État A\n"
            "(2) Deuxième disposition de la législation de l'État A\n"
        ),
        os.path.join('legislation', 'state_b_english.txt'): (
            '(1) First provision in State B legislation\n'
            '(2) Second provision in State B legislation\n'
        ),
        os.path.join('legislation', 'state_b_french.txt'): (
            "(1) Première disposition de la législation de l'État B\n"
            "(2) Deuxième disposition de la législation de l'État B\n"
        ),
        os.path.join('legislation', 'state_c_english.txt'): (
            '(1) First provision in State C legislation\n'
            '(2) Second provision in State C legislation\n'
        ),
        os.path.join('legislation', 'state_c_french.txt'): (
            "(1) Première disposition de la législation de l'État C\n"
            "(2) Deuxième disposition de la législation de l'État C\n"
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    expected_highest_provision_group_scores = (
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.590\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.490\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 1.020\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 1.020\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.000\n'
        '\n'
        'State A 1: First provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.000\n'
        '\n'
        'State A 1: First provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
    )
    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,3.00000\n'
        '1,0,2,Undirected,4.00000\n'
        '2,1,2,Undirected,4.00000\n'
    )

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                '6',
                '--include_provision_contents_in_output',
            ],
            check=True)
        actual_highest_provision_group_scores, actual_nodes, actual_edges = \
            get_highest_provision_group_scores_and_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_highest_provision_group_scores == actual_highest_provision_group_scores
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_highest_similarity_scores_with_provision_contents_and_score_threshold():
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [ 1.00 0.06 0.11 0.16 0.21 0.26 ]
        [ A 2 ] [ 0.06 1.00 0.90 0.85 0.80 0.75 ]
        [ B 1 ] [ 0.11 0.90 1.00 0.17 0.22 0.27 ]
        [ B 2 ] [ 0.16 0.85 0.17 1.00 0.79 0.74 ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79 1.00 0.28 ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74 0.28 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [ 0.11 0.90                     ]
        [ B 2 ] [ 0.16 0.85                     ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79           ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74           ]

    The mean of the remaining scores is:

    mean = sum(0.11, 0.90, 0.16, 0.85, 0.21, 0.80, 0.22, 0.79, 0.26, 0.75,
               0.27, 0.74) / 12
    mean = 6.06 / 12 = 0.505

    The standard deviation of the remaining scores is:

    stddev = sqrt(sum((0.11 - 0.505) ^ 2, (0.90 - 0.505) ^ 2, (0.16 - 0.505) ^ 2,
                      (0.85 - 0.505) ^ 2, (0.21 - 0.505) ^ 2, (0.80 - 0.505) ^ 2,
                      (0.22 - 0.505) ^ 2, (0.79 - 0.505) ^ 2, (0.26 - 0.505) ^ 2,
                      (0.75 - 0.505) ^ 2, (0.27 - 0.505) ^ 2, (0.74 - 0.505) ^ 2) / 12)
    stddev ~= sqrt(1.12 / 12) ~= 0.305

    Excluding the remaining scores that are less than 0.5 standard deviations
    above the mean leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [      0.90                     ]
        [ B 2 ] [      0.85                     ]
        [ C 1 ] [      0.80      0.79           ]
        [ C 2 ] [      0.75      0.74           ]

    The application should rank row-wise provision groups by the scaled average
    of the constituent provision pair similarity scores, where the scaled
    average is the arithmetic average of the pair scores multiplied by the
    number of provisions in the group minus one (to account for the fact that a
    provision group cannot contain less than two provisions).

    The following table lists each remaining provision combination, the
    associated row-wise provision pair scores, the arithmetic average of said
    scores and the scaled average of said scores. Taking provision group 'A 2,B
    2,C 1' as an example, pairs 'C 1,A 2' and 'C 1,B 2' have similarity scores
    of 0.80 and 0.79 respectively. The arithmetic average of these scores is
    (0.80 + 0.79) / 2 = 0.795, while the scaled average is 0.795 * (3 - 1) = 1.590.

    Provision group  Group pair scores  Average pair score  Scaled average
    A 2,B 1          0.90               0.900               0.900
    A 2,B 2          0.85               0.850               0.850
    A 2,C 1          0.80               0.800               0.800
    A 2,C 2          0.75               0.750               0.750
    B 2,C 1          0.79               0.790               0.790
    B 2,C 2          0.74               0.740               0.740
    A 2,B 2,C 1      0.80,0.79          0.795               1.590
    A 2,B 2,C 2      0.75,0.74          0.745               1.490

    The following table lists the provision groups sorted by scaled average in
    descending order.

    Provision group  Scaled average
    A 2,B 2,C 1      1.590
    A 2,B 2,C 2      1.490
    A 2,B 1          0.900
    A 2,B 2          0.850
    A 2,C 1          0.800
    B 2,C 1          0.790
    A 2,C 2          0.750

    The application should also identify all of the nodes and edges among the
    provision groups, with each node representing a state and the weight of each
    edge representing the number of unique combinations of provisions of the two
    connected nodes that appear together in a group.

    Among the provision groups above, there are only three nodes: A, B and C.
    Node A appears in six provision groups, while nodes B and C each appear in
    five provision groups. The following table lists the number of times that
    each provision pair appears in the same group together.

    First provision  Second provision  Appearances in same group
    A 2              B 1               1
    A 2              B 2               3
    A 2              C 1               2
    A 2              C 2               2
    B 2              C 1               2
    B 2              C 2               1

    While 'A 2' appears in the same group as each of the other provisions (of
    different nodes) a total of seven times, there are only four unique
    combinations of provision pairs of which provision 'A 2' is a member:
    'A 2,B 1', 'A 2,B 2', 'A 2,C 1' and 'A 2,C 2'. Similarly, while 'B 2'
    appears in the same group as the other provisions a total of six times,
    there are only three unique combinations of provision pairs of which
    provision 'B 2' is a member: 'A 2,B 2', 'B 2,C 1' and 'B 2,C 2'. Thus, in
    total, there are six unique combinations of provisions ('A 2,B 2' is
    included in both of the foregoing lists), two of which involve the node pair
    'A,B', two of which involve the node pair 'A,C' and two of which involve the
    node pair 'B,C'. Consequently, the edge table corresponding to the list of
    provision groups above should take the following form:

    First node  Second node  Weight
    A           B            2
    A           C            2
    B           C            2
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.06,0.11,0.16,0.21,0.26\n'
            'State A 2,0.06,1.0,0.9,0.85,0.8,0.75\n'
            'State B 1,0.11,0.9,1.0,0.17,0.22,0.27\n'
            'State B 2,0.16,0.85,0.17,1.0,0.79,0.74\n'
            'State C 1,0.21,0.8,0.22,0.79,1.0,0.28\n'
            'State C 2,0.26,0.75,0.27,0.74,0.28,1.0\n'
        ),
        os.path.join('legislation', 'state_a_english.txt'): (
            '(1) First provision in State A legislation\n'
            '(2) Second provision in State A legislation\n'
        ),
        os.path.join('legislation', 'state_a_french.txt'): (
            "(1) Première disposition de la législation de l'État A\n"
            "(2) Deuxième disposition de la législation de l'État A\n"
        ),
        os.path.join('legislation', 'state_b_english.txt'): (
            '(1) First provision in State B legislation\n'
            '(2) Second provision in State B legislation\n'
        ),
        os.path.join('legislation', 'state_b_french.txt'): (
            "(1) Première disposition de la législation de l'État B\n"
            "(2) Deuxième disposition de la législation de l'État B\n"
        ),
        os.path.join('legislation', 'state_c_english.txt'): (
            '(1) First provision in State C legislation\n'
            '(2) Second provision in State C legislation\n'
        ),
        os.path.join('legislation', 'state_c_french.txt'): (
            "(1) Première disposition de la législation de l'État C\n"
            "(2) Deuxième disposition de la législation de l'État C\n"
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    expected_highest_provision_group_scores = (
        'Mean: 0.505\n'
        'Standard deviation: 0.305\n'
        'Mean + 0.5 * standard deviation: 0.658\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.590\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.490\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'Scaled average: 0.900\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'Scaled average: 0.850\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State C 1\n'
        'Scaled average: 0.800\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
    )
    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,2.00000\n'
        '1,0,2,Undirected,2.00000\n'
        '2,1,2,Undirected,2.00000\n'
    )

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                '5',
                '--include_provision_contents_in_output',
                '--score_threshold',
                '0.5',
            ],
            check=True)
        actual_highest_provision_group_scores, actual_nodes, actual_edges = \
            get_highest_provision_group_scores_and_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_highest_provision_group_scores == actual_highest_provision_group_scores
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_highest_similarity_scores_with_provision_contents_and_redundancy_reduction():
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [ 1.00 0.06 0.11 0.16 0.21 0.26 ]
        [ A 2 ] [ 0.06 1.00 0.90 0.85 0.80 0.75 ]
        [ B 1 ] [ 0.11 0.90 1.00 0.17 0.22 0.27 ]
        [ B 2 ] [ 0.16 0.85 0.17 1.00 0.79 0.74 ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79 1.00 0.28 ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74 0.28 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [ 0.11 0.90                     ]
        [ B 2 ] [ 0.16 0.85                     ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79           ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74           ]

    The application should rank row-wise provision groups by the scaled average
    of the constituent provision pair similarity scores, where the scaled
    average is the arithmetic average of the pair scores multiplied by the
    number of provisions in the group minus one (to account for the fact that a
    provision group cannot contain less than two provisions).

    The following table lists each remaining provision combination, the
    associated row-wise provision pair scores, the arithmetic average of said
    scores and the scaled average of said scores. Taking provision group 'A 1,B
    1,C 1' as an example, pairs 'C 1,A 1' and 'C 1,B 1' have similarity scores
    of 0.21 and 0.22 respectively. The arithmetic average of these scores is
    (0.21 + 0.22) / 2 = 0.215, while the scaled average is 0.215 * (3 - 1) = 0.430.

    Provision group  Group pair scores  Average pair score  Scaled average
    A 1,B 1          0.11               0.110               0.110
    A 1,B 2          0.16               0.160               0.160
    A 1,C 1          0.21               0.210               0.210
    A 1,C 2          0.26               0.260               0.260
    A 2,B 1          0.90               0.900               0.900
    A 2,B 2          0.85               0.850               0.850
    A 2,C 1          0.80               0.800               0.800
    A 2,C 2          0.75               0.750               0.750
    B 1,C 1          0.22               0.220               0.220
    B 1,C 2          0.27               0.270               0.270
    B 2,C 1          0.79               0.790               0.790
    B 2,C 2          0.74               0.740               0.740
    A 1,B 1,C 1      0.21,0.22          0.215               0.430
    A 1,B 1,C 2      0.26,0.27          0.265               0.530
    A 1,B 2,C 1      0.21,0.79          0.500               1.000
    A 1,B 2,C 2      0.26,0.74          0.500               1.000
    A 2,B 1,C 1      0.80,0.22          0.510               1.020
    A 2,B 1,C 2      0.75,0.27          0.510               1.020
    A 2,B 2,C 1      0.80,0.79          0.795               1.590
    A 2,B 2,C 2      0.75,0.74          0.745               1.490

    The following table lists the provision groups sorted by scaled average in
    descending order and excludes any provision group that is a subset of
    another group with a higher score. The excluded groups should not factor
    into the output when the reduce_redundancy_in_output argument is provided.

    Provision group  Scaled average
    A 2,B 2,C 1      1.590
    A 2,B 2,C 2      1.490
    A 2,B 1,C 1      1.020
    A 2,B 1,C 2      1.020
    A 1,B 2,C 1      1.000
    A 1,B 2,C 2      1.000
    A 1,B 1,C 2      0.530
    A 1,B 1,C 1      0.430

    The application should also identify all of the nodes and edges among the
    provision groups, with each node representing a state and the weight of each
    edge representing the number of unique combinations of provisions of the two
    connected nodes that appear together in a group.

    Among the provision groups above, there are only three nodes: A, B and C.
    Each node appears in all eight provision groups. While each provision
    appears in the same group as each of the other provisions (of different nodes)
    twice, there are only four unique combinations of provision pairs of which
    each provision is a member. For example, provision 'A 1' appears in the same
    provision group as each of 'B 1', 'B 2', 'C 1' and 'C 2' twice, but is only
    a member of four unique combinations of provision pairs: 'A 1,B 1',
    'A 1,B 2', 'A 1,C 1' and 'A 1,C 2'. Two of the unique combinations involve
    one of the two potential node pairs, while the other two unique combinations
    involve the other potential node pair (i.e. 'A,B' and 'A,C' in the preceding
    example). As there are two provisions per node, the edge table corresponding
    to the list of provision groups above should take the following form:

    First node  Second node  Weight
    A           B            4
    A           C            4
    B           C            4
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.06,0.11,0.16,0.21,0.26\n'
            'State A 2,0.06,1.0,0.9,0.85,0.8,0.75\n'
            'State B 1,0.11,0.9,1.0,0.17,0.22,0.27\n'
            'State B 2,0.16,0.85,0.17,1.0,0.79,0.74\n'
            'State C 1,0.21,0.8,0.22,0.79,1.0,0.28\n'
            'State C 2,0.26,0.75,0.27,0.74,0.28,1.0\n'
        ),
        os.path.join('legislation', 'state_a_english.txt'): (
            '(1) First provision in State A legislation\n'
            '(2) Second provision in State A legislation\n'
        ),
        os.path.join('legislation', 'state_a_french.txt'): (
            "(1) Première disposition de la législation de l'État A\n"
            "(2) Deuxième disposition de la législation de l'État A\n"
        ),
        os.path.join('legislation', 'state_b_english.txt'): (
            '(1) First provision in State B legislation\n'
            '(2) Second provision in State B legislation\n'
        ),
        os.path.join('legislation', 'state_b_french.txt'): (
            "(1) Première disposition de la législation de l'État B\n"
            "(2) Deuxième disposition de la législation de l'État B\n"
        ),
        os.path.join('legislation', 'state_c_english.txt'): (
            '(1) First provision in State C legislation\n'
            '(2) Second provision in State C legislation\n'
        ),
        os.path.join('legislation', 'state_c_french.txt'): (
            "(1) Première disposition de la législation de l'État C\n"
            "(2) Deuxième disposition de la législation de l'État C\n"
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    expected_highest_provision_group_scores = (
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.590\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.490\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 1.020\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 1.020\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.000\n'
        '\n'
        'State A 1: First provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.000\n'
        '\n'
        'State A 1: First provision in State A legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 0.530\n'
        '\n'
        'State A 1: First provision in State A legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 0.430\n'
        '\n'
        'State A 1: First provision in State A legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
    )
    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,4.00000\n'
        '1,0,2,Undirected,4.00000\n'
        '2,1,2,Undirected,4.00000\n'
    )

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                '10',
                '--include_provision_contents_in_output',
                '--reduce_redundancy_in_output',
            ],
            check=True)
        actual_highest_provision_group_scores, actual_nodes, actual_edges = \
            get_highest_provision_group_scores_and_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_highest_provision_group_scores == actual_highest_provision_group_scores
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_highest_similarity_scores_with_redundancy_reduction_and_transitive_similarity_deduplication():
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [ 1.00 0.06 0.11 0.16 0.21 0.26 ]
        [ A 2 ] [ 0.06 1.00 0.90 0.85 0.80 0.75 ]
        [ B 1 ] [ 0.11 0.90 1.00 0.17 0.22 0.27 ]
        [ B 2 ] [ 0.16 0.85 0.17 1.00 0.79 0.74 ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79 1.00 0.28 ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74 0.28 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [ 0.11 0.90                     ]
        [ B 2 ] [ 0.16 0.85                     ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79           ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74           ]

    The application should rank row-wise provision groups by the scaled average
    of the constituent provision pair similarity scores, where the scaled
    average is the arithmetic average of the pair scores multiplied by the
    number of provisions in the group minus one (to account for the fact that a
    provision group cannot contain less than two provisions).

    The following table lists each remaining provision combination, the
    associated row-wise provision pair scores, the arithmetic average of said
    scores and the scaled average of said scores. Taking provision group 'A 1,B
    1,C 1' as an example, pairs 'C 1,A 1' and 'C 1,B 1' have similarity scores
    of 0.21 and 0.22 respectively. The arithmetic average of these scores is
    (0.21 + 0.22) / 2 = 0.215, while the scaled average is 0.215 * (3 - 1) = 0.430.

    Provision group  Group pair scores  Average pair score  Scaled average
    A 1,B 1          0.11               0.110               0.110
    A 1,B 2          0.16               0.160               0.160
    A 1,C 1          0.21               0.210               0.210
    A 1,C 2          0.26               0.260               0.260
    A 2,B 1          0.90               0.900               0.900
    A 2,B 2          0.85               0.850               0.850
    A 2,C 1          0.80               0.800               0.800
    A 2,C 2          0.75               0.750               0.750
    B 1,C 1          0.22               0.220               0.220
    B 1,C 2          0.27               0.270               0.270
    B 2,C 1          0.79               0.790               0.790
    B 2,C 2          0.74               0.740               0.740
    A 1,B 1,C 1      0.21,0.22          0.215               0.430
    A 1,B 1,C 2      0.26,0.27          0.265               0.530
    A 1,B 2,C 1      0.21,0.79          0.500               1.000
    A 1,B 2,C 2      0.26,0.74          0.500               1.000
    A 2,B 1,C 1      0.80,0.22          0.510               1.020
    A 2,B 1,C 2      0.75,0.27          0.510               1.020
    A 2,B 2,C 1      0.80,0.79          0.795               1.590
    A 2,B 2,C 2      0.75,0.74          0.745               1.490

    The following table lists the provision groups sorted by scaled average in
    descending order and excludes any provision group that is a subset of
    another group with a higher score. The excluded groups should not factor
    into the output when the reduce_redundancy_in_output argument is provided.

    Provision group  Scaled average
    A 2,B 2,C 1      1.590
    A 2,B 2,C 2      1.490
    A 2,B 1,C 1      1.020
    A 2,B 1,C 2      1.020
    A 1,B 2,C 1      1.000
    A 1,B 2,C 2      1.000
    A 1,B 1,C 2      0.530
    A 1,B 1,C 1      0.430

    The application should also identify all of the nodes and edges among the
    provision groups, with each node representing a state and the weight of each
    edge representing the number of unique combinations of provisions of the two
    connected nodes that appear together in a group. Furthermore, when the
    deduplicate_transitive_similarity argument is provided, only those
    constituent provision pairs of a given provision group that include the
    state in the group with the earliest enactment year should contribute to
    edge weights. The enactment years for the three states in the provision
    groups above are as follows:

    State  Enactment year
    A      1995
    B      2000
    C      2005

    Among the provision groups above, there are only three nodes: A, B and C.
    Each node appears in all eight provision groups. While each provision
    appears in the same group as each of the other provisions (of different nodes)
    twice, there are only four unique combinations of provision pairs of which
    each provision is a member. For example, provision 'A 1' appears in the same
    provision group as each of 'B 1', 'B 2', 'C 1' and 'C 2' twice, but is only
    a member of four unique combinations of provision pairs: 'A 1,B 1',
    'A 1,B 2', 'A 1,C 1' and 'A 1,C 2'. Two of the unique combinations involve
    one of the two potential node pairs, while the other two unique combinations
    involve the other potential node pair (i.e. 'A,B' and 'A,C' in the preceding
    example). That said, as the earliest enactment year in each provision group
    belongs to State A, only the provision pairs involving State A should
    contribute to the weights of the corresponding edges. As such, none of the
    provision pairs involving the pair of State B and State C should contribute
    to the weight of the B-C edge. The edge table corresponding to the list of
    provision groups above should thus take the following form:

    First node  Second node  Weight
    A           B            4
    A           C            4
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.06,0.11,0.16,0.21,0.26\n'
            'State A 2,0.06,1.0,0.9,0.85,0.8,0.75\n'
            'State B 1,0.11,0.9,1.0,0.17,0.22,0.27\n'
            'State B 2,0.16,0.85,0.17,1.0,0.79,0.74\n'
            'State C 1,0.21,0.8,0.22,0.79,1.0,0.28\n'
            'State C 2,0.26,0.75,0.27,0.74,0.28,1.0\n'
        ),
        'test_enactment_years.csv': (
            'State A,1995\n'
            'State B,2000\n'
            'State C,2005\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    enactment_years_file_path = os.path.join(
        test_directory_path, 'test_enactment_years.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--debug',
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                '10',
                '--reduce_redundancy_in_output',
                '--deduplicate_transitive_similarity',
                '--enactment_years_file_path',
                enactment_years_file_path,
            ],
            check=True)
        actual_highest_provision_group_scores, actual_nodes, actual_edges = \
            get_highest_provision_group_scores_and_nodes_and_edges(test_directory_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_highest_provision_group_scores = (
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.590\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.490\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 1.020\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 1.020\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.000\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.000\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 0.530\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 0.430\n'
    )
    expected_nodes = (
        'ID,Label\n'
        '0,State A\n'
        '1,State B\n'
        '2,State C\n'
    )
    expected_edges = (
        'ID,Source,Target,Type,Weight\n'
        '0,0,1,Undirected,4.00000\n'
        '1,0,2,Undirected,4.00000\n'
    )
    assert expected_highest_provision_group_scores == actual_highest_provision_group_scores
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges
