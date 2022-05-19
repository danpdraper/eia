import os
import subprocess

import eia.environment as environment
import eia.tests.utilities as utilities


def test_reduce_transitive_similarity():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.00,0.36,0.35,0.34,0.33,0.32,0.31,0.30,0.29\n'
            'State A 2,0.36,1.00,0.28,0.27,0.26,0.25,0.24,0.23,0.22\n'
            'State A 3,0.35,0.28,1.00,0.21,0.20,0.19,0.18,0.17,0.16\n'
            'State B 1,0.34,0.27,0.21,1.00,0.15,0.14,0.13,0.12,0.11\n'
            'State B 2,0.33,0.26,0.20,0.15,1.00,0.10,0.09,0.08,0.07\n'
            'State B 3,0.32,0.25,0.19,0.14,0.10,1.00,0.06,0.05,0.04\n'
            'State C 1,0.31,0.24,0.18,0.13,0.09,0.06,1.00,0.03,0.02\n'
            'State C 2,0.30,0.23,0.17,0.12,0.08,0.05,0.03,1.00,0.01\n'
            'State C 3,0.29,0.22,0.16,0.11,0.07,0.04,0.02,0.01,1.00\n'
        ),
        'enactment_years.csv': (
            'State A,2005\n'
            'State B,2000\n'
            'State C,1995\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    enactment_years_file_path = os.path.join(
        test_directory_path, 'enactment_years.csv')
    revised_similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix_reduced_transitive_similarity.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        subprocess.run(
            [
                script_file_path,
                '--debug',
                'reduce_transitive_similarity',
                similarity_matrix_file_path,
                test_directory_path,
                '0.4',
                '--enactment_years_file_path',
                enactment_years_file_path,
            ],
            check=True)
        with open(revised_similarity_matrix_file_path, 'r') as file_object:
            actual_matrix = file_object.read()
    finally:
        utilities.delete_test_directory(test_directory_path)

    expected_matrix = (
        'language:english\n'
        'State A 1,1.00000,0.36000,0.35000,0.34000,0.33000,0.32000,0.31000,0.30000,0.29000\n'
        'State A 2,0.36000,1.00000,0.28000,0.00000,0.26000,0.25000,0.24000,0.23000,0.22000\n'
        'State A 3,0.35000,0.28000,1.00000,0.00000,0.00000,0.19000,0.18000,0.17000,0.16000\n'
        'State B 1,0.34000,0.00000,0.00000,1.00000,0.15000,0.14000,0.13000,0.12000,0.11000\n'
        'State B 2,0.33000,0.26000,0.00000,0.15000,1.00000,0.10000,0.09000,0.08000,0.07000\n'
        'State B 3,0.32000,0.25000,0.19000,0.14000,0.10000,1.00000,0.06000,0.05000,0.04000\n'
        'State C 1,0.31000,0.24000,0.18000,0.13000,0.09000,0.06000,1.00000,0.03000,0.02000\n'
        'State C 2,0.30000,0.23000,0.17000,0.12000,0.08000,0.05000,0.03000,1.00000,0.01000\n'
        'State C 3,0.29000,0.22000,0.16000,0.11000,0.07000,0.04000,0.02000,0.01000,1.00000\n'
    )

    assert expected_matrix == actual_matrix


def test_reduce_transitive_similarity_invalid_output_directory():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.00,0.36,0.35,0.34,0.33,0.32,0.31,0.30,0.29\n'
            'State A 2,0.36,1.00,0.28,0.27,0.26,0.25,0.24,0.23,0.22\n'
            'State A 3,0.35,0.28,1.00,0.21,0.20,0.19,0.18,0.17,0.16\n'
            'State B 1,0.34,0.27,0.21,1.00,0.15,0.14,0.13,0.12,0.11\n'
            'State B 2,0.33,0.26,0.20,0.15,1.00,0.10,0.09,0.08,0.07\n'
            'State B 3,0.32,0.25,0.19,0.14,0.10,1.00,0.06,0.05,0.04\n'
            'State C 1,0.31,0.24,0.18,0.13,0.09,0.06,1.00,0.03,0.02\n'
            'State C 2,0.30,0.23,0.17,0.12,0.08,0.05,0.03,1.00,0.01\n'
            'State C 3,0.29,0.22,0.16,0.11,0.07,0.04,0.02,0.01,1.00\n'
        ),
        'enactment_years.csv': (
            'State A,2005\n'
            'State B,2000\n'
            'State C,1995\n'
        ),
    }

    script_file_path = os.path.join(
        environment.ENVIRONMENT_ROOT_PATH, 'scripts', 'similarity.py')
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    output_directory_path = os.path.join(
        os.path.sep, 'invalid', 'output', 'directory', 'path')
    enactment_years_file_path = os.path.join(
        test_directory_path, 'enactment_years.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        completed_process = subprocess.run(
            [
                script_file_path,
                '--debug',
                'reduce_transitive_similarity',
                similarity_matrix_file_path,
                output_directory_path,
                '0.4',
                '--enactment_years_file_path',
                enactment_years_file_path,
            ],
            capture_output=True,
            text=True)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert 0 != completed_process.returncode
    assert 'ValueError' in completed_process.stderr
