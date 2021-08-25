import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


def execute_highest_similarity_scores_without_provision_contents_test(
        number_of_scores, expected_output):
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

    The application should rank provision groups by the scaled average of the
    constituent provision pair similarity scores, where the scaled average is
    the arithmetic average of the pair scores multiplied by the number of
    provisions in the group minus one (to account for the fact that a provision
    group cannot contain less than two provisions).

    The following table lists each provision combination, the associated
    provision pair scores, the arithmetic average of said scores and the scaled
    average of said scores. Taking provision group 'A 1,B 1,C 1' as an example,
    pairs 'A 1,B 1', 'A 1,C 1' and 'B 1,C 1' have similarity scores of 0.11,
    0.21 and 0.22 respectively. The arithmetic average of these scores is (0.11
    + 0.21 + 0.22) / 3 = 0.180, while the scaled average is 0.180 * (3 - 1) =
    0.360.

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
    A 1,B 1,C 1      0.11,0.21,0.22     0.180               0.360
    A 1,B 1,C 2      0.11,0.26,0.27     0.213               0.427
    A 1,B 2,C 1      0.16,0.21,0.79     0.387               0.773
    A 1,B 2,C 2      0.16,0.26,0.74     0.387               0.773
    A 2,B 1,C 1      0.90,0.80,0.22     0.640               1.280
    A 2,B 1,C 2      0.90,0.75,0.27     0.640               1.280
    A 2,B 2,C 1      0.85,0.80,0.79     0.813               1.627
    A 2,B 2,C 2      0.85,0.75,0.74     0.780               1.560

    The following table lists the provision groups sorted by scaled average in
    descending order.

    Provision group  Scaled average
    A 2,B 2,C 1      1.627
    A 2,B 2,C 2      1.560
    A 2,B 1,C 1      1.280
    A 2,B 1,C 2      1.280
    A 2,B 1          0.900
    A 2,B 2          0.850
    A 2,C 1          0.800
    B 2,C 1          0.790
    A 1,B 2,C 1      0.773
    A 1,B 2,C 2      0.773
    A 2,C 2          0.750
    B 2,C 2          0.740
    A 1,B 1,C 2      0.427
    A 1,B 1,C 1      0.360
    B 1,C 2          0.270
    A 1,C 2          0.260
    B 1,C 1          0.220
    A 1,C 1          0.210
    A 1,B 2          0.160
    A 1,B 1          0.110
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
        completed_process = subprocess.run(
            [
                script_file_path,
                '--debug',
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                str(number_of_scores),
            ],
            capture_output=True, check=True, text=True)
    finally:
        utilities.delete_test_directory(test_directory_path)

    print("Expected:\n{}".format(expected_output))
    print("Actual:\n{}".format(completed_process.stdout))
    assert expected_output in completed_process.stdout


def test_highest_similarity_scores_without_provision_contents():
    # Five highest scores
    expected_output = (
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.627\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 1.560\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 1.280\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 1.280\n'
        '\n'
        '----------\n'
        '\n'
        'State A 2\n'
        'State B 1\n'
        'Scaled average: 0.900\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        5, expected_output)

    # Ten highest scores
    expected_output += (
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
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 0.773\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 2\n'
        'State C 2\n'
        'Scaled average: 0.773\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        10, expected_output)

    # Fifteen highest scores
    expected_output += (
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
        'Scaled average: 0.427\n'
        '\n'
        '----------\n'
        '\n'
        'State A 1\n'
        'State B 1\n'
        'State C 1\n'
        'Scaled average: 0.360\n'
        '\n'
        '----------\n'
        '\n'
        'State B 1\n'
        'State C 2\n'
        'Scaled average: 0.270\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        15, expected_output)

    # Twenty highest scores
    expected_output += (
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
        20, expected_output)


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

    The application should rank provision groups by the scaled average of the
    constituent provision pair similarity scores, where the scaled average is
    the arithmetic average of the pair scores multiplied by the number of
    provisions in the group minus one (to account for the fact that a provision
    group cannot contain less than two provisions).

    The following table lists each provision combination, the associated
    provision pair scores, the arithmetic average of said scores and the scaled
    average of said scores. Taking provision group 'A 1,B 1,C 1' as an example,
    pairs 'A 1,B 1', 'A 1,C 1' and 'B 1,C 1' have similarity scores of 0.11,
    0.21 and 0.22 respectively. The arithmetic average of these scores is (0.11
    + 0.21 + 0.22) / 3 = 0.180, while the scaled average is 0.180 * (3 - 1) =
    0.360.

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
    A 1,B 1,C 1      0.11,0.21,0.22     0.180               0.360
    A 1,B 1,C 2      0.11,0.26,0.27     0.213               0.426
    A 1,B 2,C 1      0.16,0.21,0.79     0.387               0.774
    A 1,B 2,C 2      0.16,0.26,0.74     0.387               0.774
    A 2,B 1,C 1      0.90,0.80,0.22     0.640               1.280
    A 2,B 1,C 2      0.90,0.75,0.27     0.640               1.280
    A 2,B 2,C 1      0.85,0.80,0.79     0.813               1.627
    A 2,B 2,C 2      0.85,0.75,0.74     0.780               1.560

    The following table lists the provision groups sorted by scaled average in
    descending order.

    Provision group  Scaled average
    A 2,B 2,C 1      1.627
    A 2,B 2,C 2      1.560
    A 2,B 1,C 1      1.280
    A 2,B 1,C 2      1.280
    A 2,B 1          0.900
    A 2,B 2          0.850
    A 2,C 1          0.800
    B 2,C 1          0.790
    A 1,B 2,C 1      0.774
    A 1,B 2,C 2      0.774
    A 2,C 2          0.750
    B 2,C 2          0.740
    A 1,B 1,C 2      0.426
    A 1,B 1,C 1      0.360
    B 1,C 2          0.270
    A 1,C 2          0.260
    B 1,C 1          0.220
    A 1,C 1          0.210
    A 1,B 2          0.160
    A 1,B 1          0.110
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

    expected_output = (
        'State A 2\n'
        'State B 2\n'
        'State C 1\n'
        'Scaled average: 1.627\n'
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
        'Scaled average: 1.560\n'
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
        'Scaled average: 1.280\n'
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
        'Scaled average: 1.280\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
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
    )

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        completed_process = subprocess.run(
            [
                script_file_path,
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
                'highest_provision_group_scores',
                similarity_matrix_file_path,
                '5',
                '--include_provision_contents_in_output',
            ],
            capture_output=True, check=True, text=True)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_output in completed_process.stdout
