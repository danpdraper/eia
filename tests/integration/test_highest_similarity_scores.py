import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


def execute_highest_similarity_scores_without_provision_contents_test(
        number_of_scores, expected_output):
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  D 1  D 2  E 1  E 2  ]
        [ A 1 ] [ 1.00 0.06 0.11 0.16 0.21 0.26 0.31 0.36 0.41 0.46 ]
        [ A 2 ] [ 0.06 1.00 0.90 0.85 0.80 0.75 0.70 0.65 0.60 0.55 ]
        [ B 1 ] [ 0.11 0.90 1.00 0.17 0.22 0.27 0.32 0.37 0.42 0.47 ]
        [ B 2 ] [ 0.16 0.85 0.17 1.00 0.79 0.74 0.69 0.64 0.59 0.54 ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79 1.00 0.28 0.33 0.38 0.43 0.48 ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74 0.28 1.00 0.68 0.63 0.58 0.53 ]
        [ D 1 ] [ 0.31 0.70 0.32 0.69 0.33 0.68 1.00 0.39 0.44 0.49 ]
        [ D 2 ] [ 0.36 0.65 0.37 0.64 0.38 0.63 0.39 1.00 0.57 0.52 ]
        [ E 1 ] [ 0.41 0.60 0.42 0.59 0.43 0.58 0.44 0.57 1.00 0.50 ]
        [ E 2 ] [ 0.46 0.55 0.47 0.54 0.48 0.53 0.49 0.52 0.50 1.00 ]

    The application should not consider intra-state similarity scores and should
    ignore duplicates, which leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  D 1  D 2  E 1  E 2  ]
        [ A 1 ] [                                                   ]
        [ A 2 ] [                                                   ]
        [ B 1 ] [ 0.11 0.90                                         ]
        [ B 2 ] [ 0.16 0.85                                         ]
        [ C 1 ] [ 0.21 0.80 0.22 0.79                               ]
        [ C 2 ] [ 0.26 0.75 0.27 0.74                               ]
        [ D 1 ] [ 0.31 0.70 0.32 0.69 0.33 0.68                     ]
        [ D 2 ] [ 0.36 0.65 0.37 0.64 0.38 0.63                     ]
        [ E 1 ] [ 0.41 0.60 0.42 0.59 0.43 0.58 0.44 0.57           ]
        [ E 2 ] [ 0.46 0.55 0.47 0.54 0.48 0.53 0.49 0.52           ]
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'State A 1,1.0,0.06,0.11,0.16,0.21,0.26,0.31,0.36,0.41,0.46\n'
            'State A 2,0.06,1.0,0.9,0.85,0.8,0.75,0.7,0.65,0.6,0.55\n'
            'State B 1,0.11,0.9,1.0,0.17,0.22,0.27,0.32,0.37,0.42,0.47\n'
            'State B 2,0.16,0.85,0.17,1.0,0.79,0.74,0.69,0.64,0.59,0.54\n'
            'State C 1,0.21,0.8,0.22,0.79,1.0,0.28,0.33,0.38,0.43,0.48\n'
            'State C 2,0.26,0.75,0.27,0.74,0.28,1.0,0.68,0.63,0.58,0.53\n'
            'State D 1,0.31,0.7,0.32,0.69,0.33,0.68,1.0,0.39,0.44,0.49\n'
            'State D 2,0.36,0.65,0.37,0.64,0.38,0.63,0.39,1.0,0.57,0.52\n'
            'State E 1,0.41,0.6,0.42,0.59,0.43,0.58,0.44,0.57,1.0,0.5\n'
            'State E 2,0.46,0.55,0.47,0.54,0.48,0.53,0.49,0.52,0.5,1.0\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity',
        'highest_similarity_scores.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        completed_process = subprocess.run(
            [
                script_file_path,
                similarity_matrix_file_path,
                str(number_of_scores),
                '--debug',
            ],
            capture_output=True, check=True, text=True)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_output in completed_process.stdout


def test_highest_similarity_scores_without_provision_contents():
    # Five highest scores
    expected_output = (
        'State B 1\tState A 2\t0.900\n'
        'State B 2\tState A 2\t0.850\n'
        'State C 1\tState A 2\t0.800\n'
        'State C 1\tState B 2\t0.790\n'
        'State C 2\tState A 2\t0.750\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        5, expected_output)

    # Ten highest scores
    expected_output = (
        'State B 1\tState A 2\t0.900\n'
        'State B 2\tState A 2\t0.850\n'
        'State C 1\tState A 2\t0.800\n'
        'State C 1\tState B 2\t0.790\n'
        'State C 2\tState A 2\t0.750\n'
        'State C 2\tState B 2\t0.740\n'
        'State D 1\tState A 2\t0.700\n'
        'State D 1\tState B 2\t0.690\n'
        'State D 1\tState C 2\t0.680\n'
        'State D 2\tState A 2\t0.650\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        10, expected_output)

    # Fifteen highest scores
    expected_output = (
        'State B 1\tState A 2\t0.900\n'
        'State B 2\tState A 2\t0.850\n'
        'State C 1\tState A 2\t0.800\n'
        'State C 1\tState B 2\t0.790\n'
        'State C 2\tState A 2\t0.750\n'
        'State C 2\tState B 2\t0.740\n'
        'State D 1\tState A 2\t0.700\n'
        'State D 1\tState B 2\t0.690\n'
        'State D 1\tState C 2\t0.680\n'
        'State D 2\tState A 2\t0.650\n'
        'State D 2\tState B 2\t0.640\n'
        'State D 2\tState C 2\t0.630\n'
        'State E 1\tState A 2\t0.600\n'
        'State E 1\tState B 2\t0.590\n'
        'State E 1\tState C 2\t0.580\n'
    )
    execute_highest_similarity_scores_without_provision_contents_test(
        15, expected_output)


def test_highest_similarity_scores_with_provision_contents():
    '''
    Similarity matrix:
            [ A 1  A 2  B 1  B 2  C 1  C 2  D 1  D 2  ]
    [ A 1 ] [ 1.00 0.01 0.99 0.11 0.89 0.21 0.79 0.31 ]
    [ A 2 ] [ 0.01 1.00 0.02 0.98 0.12 0.88 0.22 0.78 ]
    [ B 1 ] [ 0.99 0.02 1.00 0.03 0.97 0.13 0.87 0.23 ]
    [ B 2 ] [ 0.11 0.98 0.03 1.00 0.04 0.96 0.14 0.86 ]
    [ C 1 ] [ 0.89 0.12 0.97 0.04 1.00 0.05 0.95 0.15 ]
    [ C 2 ] [ 0.21 0.88 0.13 0.96 0.05 1.00 0.06 0.94 ]
    [ D 1 ] [ 0.79 0.22 0.87 0.14 0.95 0.06 1.00 0.07 ]
    [ D 2 ] [ 0.31 0.78 0.23 0.86 0.15 0.94 0.07 1.00 ]

    The application should not consider intra-state similarity scores and should
    ignore duplicates, which leaves:
            [ A 1  A 2  B 1  B 2  C 1  C 2  D 1  D 2  ]
    [ A 1 ] [                                         ]
    [ A 2 ] [                                         ]
    [ B 1 ] [ 0.99 0.02                               ]
    [ B 2 ] [ 0.11 0.98                               ]
    [ C 1 ] [ 0.89 0.12 0.97 0.04                     ]
    [ C 2 ] [ 0.21 0.88 0.13 0.96                     ]
    [ D 1 ] [ 0.79 0.22 0.87 0.14 0.95 0.06           ]
    [ D 2 ] [ 0.31 0.78 0.23 0.86 0.15 0.94           ]
    '''

    test_directory_path = utilities.create_test_directory('test_highest_similarity_scores')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.01,0.99,0.11,0.89,0.21,0.79,0.31\n'
            'State A 2,0.01,1.0,0.02,0.98,0.12,0.88,0.22,0.78\n'
            'State B 1,0.99,0.02,1.0,0.03,0.97,0.13,0.87,0.23\n'
            'State B 2,0.11,0.98,0.03,1.0,0.04,0.96,0.14,0.86\n'
            'State C 1,0.89,0.12,0.97,0.04,1.0,0.05,0.95,0.15\n'
            'State C 2,0.21,0.88,0.13,0.96,0.05,1.0,0.06,0.94\n'
            'State D 1,0.79,0.22,0.87,0.14,0.95,0.06,1.0,0.07\n'
            'State D 2,0.31,0.78,0.23,0.86,0.15,0.94,0.07,1.0\n'
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
        os.path.join('legislation', 'state_d_english.txt'): (
            '(1) First provision in State D legislation\n'
            '(2) Second provision in State D legislation\n'
        ),
        os.path.join('legislation', 'state_d_french.txt'): (
            "(1) Première disposition de la législation de l'État D\n"
            "(2) Deuxième disposition de la législation de l'État D\n"
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity',
        'highest_similarity_scores.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    legislation_directory_path = os.path.join(test_directory_path, 'legislation')

    expected_output = (
        'State B 1\tState A 1\t0.990\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        'State A 1: First provision in State A legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State B 2\tState A 2\t0.980\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        'State A 2: Second provision in State A legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State C 1\tState B 1\t0.970\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        'State B 1: First provision in State B legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State C 2\tState B 2\t0.960\n'
        '\n'
        'State C 2: Second provision in State C legislation\n'
        '\n'
        'State B 2: Second provision in State B legislation\n'
        '\n'
        '----------\n'
        '\n'
        'State D 1\tState C 1\t0.950\n'
        '\n'
        'State D 1: First provision in State D legislation\n'
        '\n'
        'State C 1: First provision in State C legislation\n'
        '\n'
        '----------\n'
    )

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        completed_process = subprocess.run(
            [
                script_file_path,
                similarity_matrix_file_path,
                '5',
                '--include_provision_contents_in_output',
                '--legislation_directory_path',
                legislation_directory_path,
                '--debug',
            ],
            capture_output=True, check=True, text=True)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_output in completed_process.stdout
