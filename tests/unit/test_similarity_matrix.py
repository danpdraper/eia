import os
import unittest.mock as mock

import pytest

import eia.languages as languages
import eia.similarity_matrix as similarity_matrix
import eia.scopes as scopes
import eia.tests.utilities as utilities


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

    states_to_include_file_path = os.path.join(
        test_directory_path, 'states_to_include.txt')
    open(states_to_include_file_path, 'w').close()

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
            True, states_to_include_file_path)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_rows == actual_labels_and_rows


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

    states_to_include_file_path = os.path.join(
        test_directory_path, 'states_to_include.txt')
    open(states_to_include_file_path, 'w').close()

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
            False, states_to_include_file_path)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_rows == actual_labels_and_rows


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

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.txt')
    with open(states_to_include_file_path, 'w') as file_object:
        file_object.write('state_a\n')
        file_object.write('state_c\n')

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

    assert expected_labels_and_rows == actual_labels_and_rows


def test_row_generator_ignores_comments_in_states_to_include_file():
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

    transformed_state_b_contents = (
        "title i general provisions (1) state b's first provision (2) state "
        "b's second provision [1] is better than the first provision"
    )
    transformed_state_c_contents = (
        "title i general provisions (1) state c's first provision (2) state "
        "c's second provision [•] is better than the first provision"
    )

    similarity_by_row_and_column_text = {
        (transformed_state_b_contents, transformed_state_b_contents): 5,
        (transformed_state_b_contents, transformed_state_c_contents): 6,
        (transformed_state_c_contents, transformed_state_b_contents): 8,
        (transformed_state_c_contents, transformed_state_c_contents): 9,
    }

    states_to_include_file_path = os.path.join(test_directory_path, 'states_to_include.txt')
    with open(states_to_include_file_path, 'w') as file_object:
        file_object.write('# state_a\n')
        file_object.write('state_b\n')
        file_object.write('state_c\n')

    algorithm = mock.Mock()
    algorithm.apply.side_effect = \
        lambda row_text, column_text: similarity_by_row_and_column_text[(row_text, column_text)]

    expected_labels_and_rows = [
        ('State B', [5, 6]),
        ('State C', [8, 9]),
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

    assert expected_labels_and_rows == actual_labels_and_rows


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
