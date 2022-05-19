import json
import os
import unittest.mock as mock

import pytest

import eia.languages as languages
import eia.similarity_matrix as similarity_matrix
import eia.scopes as scopes
import eia.tests.utilities as utilities


def compare_expected_and_actual_labels_and_rows(
        expected_labels_and_rows, actual_labels_and_rows):
    expected_labels, expected_rows = zip(*expected_labels_and_rows)
    actual_labels, actual_rows = zip(*actual_labels_and_rows)
    utilities.compare_expected_and_actual_similarity_matrix_labels(
        expected_labels, actual_labels)
    utilities.compare_expected_and_actual_similarity_matrices(
        expected_rows, actual_rows, expected_labels, actual_labels)


def test_row_generator_yields_tuples_of_row_label_and_row_with_provision_delimiters():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            "Title I - General Provisions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Provisions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Provisions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_a_contents = (
        "title i general provisions (1) state a's first provision (2) state "
        "a's second provision [a] is better than the first provision"
    )
    transformed_state_b_contents = (
        "title i general provisions (1) state b's first provision (2) state "
        "b's second provision [1] is better than the first provision"
    )
    transformed_state_c_contents = (
        "title i general provisions (1) state c's first provision (2) state "
        "c's second provision [•] is better than the first provision"
    )

    similarity_by_row_and_column_text = {
        (transformed_state_a_contents, transformed_state_a_contents): 1,
        (transformed_state_a_contents, transformed_state_b_contents): 2,
        (transformed_state_a_contents, transformed_state_c_contents): 3,
        (transformed_state_b_contents, transformed_state_a_contents): 4,
        (transformed_state_b_contents, transformed_state_b_contents): 5,
        (transformed_state_b_contents, transformed_state_c_contents): 6,
        (transformed_state_c_contents, transformed_state_a_contents): 7,
        (transformed_state_c_contents, transformed_state_b_contents): 8,
        (transformed_state_c_contents, transformed_state_c_contents): 9,
    }

    algorithm = mock.Mock()
    algorithm.apply.side_effect = \
        lambda row_text, column_text: similarity_by_row_and_column_text[(row_text, column_text)]

    expected_labels_and_rows = [
        ('State A', [1, 2, 3]),
        ('State B', [4, 5, 6]),
        ('State C', [7, 8, 9]),
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        row_generator = similarity_matrix.row_generator(
            algorithm, scopes.FULL_TEXT, languages.ENGLISH, test_directory_path,
            True)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.delete_test_directory(test_directory_path)

    compare_expected_and_actual_labels_and_rows(
        expected_labels_and_rows, actual_labels_and_rows)


def test_row_generator_yields_tuples_of_row_label_and_row_without_provision_delimiters():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            "Title I - General Provisions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Provisions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Provisions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_a_contents = (
        "title i general provisions state a's first provision state a's "
        "second provision is better than the first provision"
    )
    transformed_state_b_contents = (
        "title i general provisions state b's first provision state b's "
        "second provision is better than the first provision"
    )
    transformed_state_c_contents = (
        "title i general provisions state c's first provision state c's "
        "second provision is better than the first provision"
    )

    similarity_by_row_and_column_text = {
        (transformed_state_a_contents, transformed_state_a_contents): 1,
        (transformed_state_a_contents, transformed_state_b_contents): 2,
        (transformed_state_a_contents, transformed_state_c_contents): 3,
        (transformed_state_b_contents, transformed_state_a_contents): 4,
        (transformed_state_b_contents, transformed_state_b_contents): 5,
        (transformed_state_b_contents, transformed_state_c_contents): 6,
        (transformed_state_c_contents, transformed_state_a_contents): 7,
        (transformed_state_c_contents, transformed_state_b_contents): 8,
        (transformed_state_c_contents, transformed_state_c_contents): 9,
    }

    algorithm = mock.Mock()
    algorithm.apply.side_effect = \
        lambda row_text, column_text: similarity_by_row_and_column_text[(row_text, column_text)]

    expected_labels_and_rows = [
        ('State A', [1, 2, 3]),
        ('State B', [4, 5, 6]),
        ('State C', [7, 8, 9]),
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        row_generator = similarity_matrix.row_generator(
            algorithm, scopes.FULL_TEXT, languages.ENGLISH, test_directory_path,
            False)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.delete_test_directory(test_directory_path)

    compare_expected_and_actual_labels_and_rows(
        expected_labels_and_rows, actual_labels_and_rows)


def test_row_generator_excludes_files_from_states_not_in_states_to_include_file():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            "Title I - General Provisions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Provisions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Provisions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_a_contents = (
        "title i general provisions (1) state a's first provision (2) state "
        "a's second provision [a] is better than the first provision"
    )
    transformed_state_c_contents = (
        "title i general provisions (1) state c's first provision (2) state "
        "c's second provision [•] is better than the first provision"
    )

    similarity_by_row_and_column_text = {
        (transformed_state_a_contents, transformed_state_a_contents): 1,
        (transformed_state_a_contents, transformed_state_c_contents): 3,
        (transformed_state_c_contents, transformed_state_a_contents): 7,
        (transformed_state_c_contents, transformed_state_c_contents): 9,
    }

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.json')
    with open(states_to_include_file_path, 'w') as file_object:
        json.dump(
            {
                'State A': {},
                'State C': {},
            },
            file_object)

    algorithm = mock.Mock()
    algorithm.apply.side_effect = \
        lambda row_text, column_text: similarity_by_row_and_column_text[(row_text, column_text)]

    expected_labels_and_rows = [
        ('State A', [1, 3]),
        ('State C', [7, 9]),
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        row_generator = similarity_matrix.row_generator(
            algorithm, scopes.FULL_TEXT, languages.ENGLISH, test_directory_path,
            True, states_to_include_file_path)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.delete_test_directory(test_directory_path)

    compare_expected_and_actual_labels_and_rows(
        expected_labels_and_rows, actual_labels_and_rows)


def test_row_generator_excludes_provisions_not_in_states_to_include_file():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            "Title I - General Provisions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Provisions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Provisions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_a_first_provision_contents = "state a's first provision"
    transformed_state_c_first_provision_contents = "state c's first provision"
    transformed_state_c_second_provision_contents = "state c's second provision [•] is better than the first provision"

    similarity_by_row_and_column_text = {
        (transformed_state_a_first_provision_contents, transformed_state_a_first_provision_contents): 1,
        (transformed_state_a_first_provision_contents, transformed_state_c_first_provision_contents): 3,
        (transformed_state_a_first_provision_contents, transformed_state_c_second_provision_contents): 5,
        (transformed_state_c_first_provision_contents, transformed_state_a_first_provision_contents): 7,
        (transformed_state_c_first_provision_contents, transformed_state_c_first_provision_contents): 9,
        (transformed_state_c_first_provision_contents, transformed_state_c_second_provision_contents): 11,
        (transformed_state_c_second_provision_contents, transformed_state_a_first_provision_contents): 13,
        (transformed_state_c_second_provision_contents, transformed_state_c_first_provision_contents): 15,
        (transformed_state_c_second_provision_contents, transformed_state_c_second_provision_contents): 17,
    }

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.json')
    with open(states_to_include_file_path, 'w') as file_object:
        json.dump(
            {
                'State A': {
                    'Provisions': ['1'],
                },
                'State C': {
                    'Provisions': ['1', '2'],
                },
            },
            file_object)

    algorithm = mock.Mock()
    algorithm.apply.side_effect = \
        lambda row_text, column_text: similarity_by_row_and_column_text[(row_text, column_text)]

    expected_labels_and_rows = [
        ('State A 1', [1, 3, 5]),
        ('State C 1', [7, 9, 11]),
        ('State C 2', [13, 15, 17]),
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        row_generator = similarity_matrix.row_generator(
            algorithm, scopes.PROVISION, languages.ENGLISH, test_directory_path,
            True, states_to_include_file_path)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.delete_test_directory(test_directory_path)

    compare_expected_and_actual_labels_and_rows(
        expected_labels_and_rows, actual_labels_and_rows)


def test_row_generator_treats_absence_of_provisions_key_as_equivalent_to_all_provisions_in_states_to_include_file():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            "Title I - General Provisions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Provisions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Provisions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_a_first_provision_contents = "state a's first provision"
    transformed_state_c_first_provision_contents = "state c's first provision"
    transformed_state_c_second_provision_contents = "state c's second provision [•] is better than the first provision"

    similarity_by_row_and_column_text = {
        (transformed_state_a_first_provision_contents, transformed_state_a_first_provision_contents): 1,
        (transformed_state_a_first_provision_contents, transformed_state_c_first_provision_contents): 3,
        (transformed_state_a_first_provision_contents, transformed_state_c_second_provision_contents): 5,
        (transformed_state_c_first_provision_contents, transformed_state_a_first_provision_contents): 7,
        (transformed_state_c_first_provision_contents, transformed_state_c_first_provision_contents): 9,
        (transformed_state_c_first_provision_contents, transformed_state_c_second_provision_contents): 11,
        (transformed_state_c_second_provision_contents, transformed_state_a_first_provision_contents): 13,
        (transformed_state_c_second_provision_contents, transformed_state_c_first_provision_contents): 15,
        (transformed_state_c_second_provision_contents, transformed_state_c_second_provision_contents): 17,
    }

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.json')
    with open(states_to_include_file_path, 'w') as file_object:
        json.dump(
            {
                'State A': {
                    'Provisions': ['1'],
                },
                'State C': {},
            },
            file_object)

    algorithm = mock.Mock()
    algorithm.apply.side_effect = \
        lambda row_text, column_text: similarity_by_row_and_column_text[(row_text, column_text)]

    expected_labels_and_rows = [
        ('State A 1', [1, 3, 5]),
        ('State C 1', [7, 9, 11]),
        ('State C 2', [13, 15, 17]),
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        row_generator = similarity_matrix.row_generator(
            algorithm, scopes.PROVISION, languages.ENGLISH, test_directory_path,
            True, states_to_include_file_path)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.delete_test_directory(test_directory_path)

    compare_expected_and_actual_labels_and_rows(
        expected_labels_and_rows, actual_labels_and_rows)


def test_from_file_returns_labels_and_lower_diagonal_matrix_without_diagonal():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'language:english\n'
            'State A 1,1.0,0.01,0.02,0.03,0.04,0.05\n'
            'State A 2,0.01,1.0,0.06,0.07,0.08,0.09\n'
            'State B 1,0.02,0.06,1.0,0.1,0.11,0.12\n'
            'State B 2,0.03,0.07,0.1,1.0,0.13,0.14\n'
            'State C 1,0.04,0.08,0.11,0.13,1.0,0.15\n'
            'State C 2,0.05,0.09,0.12,0.14,0.15,1.0\n'
        ),
    }

    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')

    expected_labels = (
        'State A 1',
        'State A 2',
        'State B 1',
        'State B 2',
        'State C 1',
        'State C 2',
    )
    expected_matrix = (
        [],
        [0.01],
        [0.02, 0.06],
        [0.03, 0.07, 0.1],
        [0.04, 0.08, 0.11, 0.13],
        [0.05, 0.09, 0.12, 0.14, 0.15],
    )

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_labels, actual_matrix = similarity_matrix.from_file(
            similarity_matrix_file_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels == actual_labels
    assert expected_matrix == actual_matrix


def test_get_language_extracts_language_from_matrix_file_at_provided_path():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'language_at_top.csv': (
            'language:english\n'
            'State A,0.01,0.02,0.03\n'
            'State B,0.04,0.05,0.06\n'
            'State C,0.07,0.08,0.09\n'
            'State D,0.10,0.11,0.12\n'
        ),
        'language_in_middle.csv': (
            'State A,0.01,0.02,0.03\n'
            'State B,0.04,0.05,0.06\n'
            'language:english\n'
            'State C,0.07,0.08,0.09\n'
            'State D,0.10,0.11,0.12\n'
        ),
        'language_at_bottom.csv': (
            'State A,0.01,0.02,0.03\n'
            'State B,0.04,0.05,0.06\n'
            'State C,0.07,0.08,0.09\n'
            'State D,0.10,0.11,0.12\n'
            'language:english\n'
        ),
    }

    language_at_top_file_path = os.path.join(
        test_directory_path, 'language_at_top.csv')
    language_in_middle_file_path = os.path.join(
        test_directory_path, 'language_in_middle.csv')
    language_at_bottom_file_path = os.path.join(
        test_directory_path, 'language_at_bottom.csv')

    expected_language = 'english'

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        # Language at top
        assert expected_language == similarity_matrix.get_language(
            language_at_top_file_path)
        # Language in middle
        assert expected_language == similarity_matrix.get_language(
            language_in_middle_file_path)
        # Language at bottom
        assert expected_language == similarity_matrix.get_language(
            language_at_bottom_file_path)
    finally:
        utilities.delete_test_directory(test_directory_path)


def test_get_language_raises_runtime_error_when_more_or_less_than_one_language_in_file():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'no_language.csv': (
            'State A,0.01,0.02,0.03\n'
            'State B,0.04,0.05,0.06\n'
            'State C,0.07,0.08,0.09\n'
            'State D,0.10,0.11,0.12\n'
        ),
        'two_languages.csv': (
            'language:english\n'
            'State A,0.01,0.02,0.03\n'
            'State B,0.04,0.05,0.06\n'
            'State C,0.07,0.08,0.09\n'
            'State D,0.10,0.11,0.12\n'
            'language:english\n'
        ),
    }

    no_language_file_path = os.path.join(test_directory_path, 'no_language.csv')
    two_languages_file_path = os.path.join(
        test_directory_path, 'two_languages.csv')

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        # No language in file
        with pytest.raises(RuntimeError):
            similarity_matrix.get_language(no_language_file_path)
        # Two languages in file
        with pytest.raises(RuntimeError):
            similarity_matrix.get_language(two_languages_file_path)
    finally:
        utilities.delete_test_directory(test_directory_path)


def test_reduce_transitive_similarity_replaces_newer_values_with_zero_when_older_value_meets_or_exceeds_threshold():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'State A 1,1.00,0.99,0.98,0.97,0.96,0.95,0.94,0.93,0.92,0.91,0.90,0.89\n'
            'State A 2,0.99,1.00,0.88,0.87,0.86,0.85,0.84,0.83,0.82,0.81,0.80,0.79\n'
            'State A 3,0.98,0.88,1.00,0.78,0.77,0.76,0.75,0.74,0.73,0.72,0.71,0.70\n'
            'State B 1,0.97,0.87,0.78,1.00,0.69,0.68,0.67,0.66,0.65,0.64,0.63,0.62\n'
            'State B 2,0.96,0.86,0.77,0.69,1.00,0.61,0.60,0.59,0.58,0.57,0.56,0.55\n'
            'State B 3,0.95,0.85,0.76,0.68,0.61,1.00,0.54,0.53,0.52,0.51,0.50,0.49\n'
            'State C 1,0.94,0.84,0.75,0.67,0.60,0.54,1.00,0.48,0.47,0.46,0.45,0.44\n'
            'State C 2,0.93,0.83,0.74,0.66,0.59,0.53,0.48,1.00,0.43,0.42,0.41,0.40\n'
            'State C 3,0.92,0.82,0.73,0.65,0.58,0.52,0.47,0.43,1.00,0.39,0.38,0.37\n'
            'State D 1,0.91,0.81,0.72,0.64,0.57,0.51,0.46,0.42,0.39,1.00,0.36,0.35\n'
            'State D 2,0.90,0.80,0.71,0.63,0.56,0.50,0.45,0.41,0.38,0.36,1.00,0.34\n'
            'State D 3,0.89,0.79,0.70,0.62,0.55,0.49,0.44,0.40,0.37,0.35,0.34,1.00\n'
        ),
    }
    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')
    minimum_proportion = 0.4
    enactment_years = {
        'State A': 2005,
        'State B': 2000,
        'State C': 1995,
        'State D': 2002,
    }

    expected_labels = (
        'State A 1',
        'State A 2',
        'State A 3',
        'State B 1',
        'State B 2',
        'State B 3',
        'State C 1',
        'State C 2',
        'State C 3',
        'State D 1',
        'State D 2',
        'State D 3',
    )
    expected_rows = [
        [],
        [0.99],
        [0.98, 0.88],
        [0.0, 0.0, 0.0],
        [0.0, 0.0, 0.0, 0.69],
        [0.0, 0.0, 0.0, 0.68, 0.61],
        [0.94, 0.84, 0.75, 0.67, 0.6, 0.54],
        [0.93, 0.83, 0.74, 0.66, 0.59, 0.53, 0.48],
        [0.92, 0.82, 0.73, 0.65, 0.58, 0.52, 0.47, 0.43],
        [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.46, 0.42, 0.39],
        [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.45, 0.41, 0.38, 0.36],
        [0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.44, 0.4, 0.37, 0.35, 0.34],
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_labels, actual_rows = similarity_matrix.reduce_transitive_similarity(
            similarity_matrix_file_path, minimum_proportion, enactment_years)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels == actual_labels
    assert expected_rows == actual_rows


def test_add_diagonal_and_upper_triangle_to_matrix_creates_symmetric_matrix():
    rows = [
        [],
        [0.01],
        [0.02, 0.03],
        [0.04, 0.05, 0.06],
        [0.07, 0.08, 0.09, 0.1],
        [0.11, 0.12, 0.13, 0.14, 0.15],
        [0.16, 0.17, 0.18, 0.19, 0.2, 0.21],
        [0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28],
        [0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36],
    ]
    expected_rows = [
        [1.0, 0.01, 0.02, 0.04, 0.07, 0.11, 0.16, 0.22, 0.29],
        [0.01, 1.0, 0.03, 0.05, 0.08, 0.12, 0.17, 0.23, 0.3],
        [0.02, 0.03, 1.0, 0.06, 0.09, 0.13, 0.18, 0.24, 0.31],
        [0.04, 0.05, 0.06, 1.0, 0.1, 0.14, 0.19, 0.25, 0.32],
        [0.07, 0.08, 0.09, 0.1, 1.0, 0.15, 0.2, 0.26, 0.33],
        [0.11, 0.12, 0.13, 0.14, 0.15, 1.0, 0.21, 0.27, 0.34],
        [0.16, 0.17, 0.18, 0.19, 0.2, 0.21, 1.0, 0.28, 0.35],
        [0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28, 1.0, 0.36],
        [0.29, 0.3, 0.31, 0.32, 0.33, 0.34, 0.35, 0.36, 1.0],
    ]
    similarity_matrix.add_diagonal_and_upper_triangle_to_matrix(rows)
    assert expected_rows == rows
