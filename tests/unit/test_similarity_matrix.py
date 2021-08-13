import os
import unittest.mock as mock

import eia.languages as languages
import eia.similarity_matrix as similarity_matrix
import eia.scopes as scopes
import eia.tests.utilities as utilities


EPSILON = 0.0005


def test_row_generator_yields_tuples_of_row_label_and_row_with_provision_delimiters():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'state_a_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_a_contents = (
        "title i general dispositions (1) state a's first provision (2) state "
        "a's second provision [a] is better than the first provision"
    )
    transformed_state_b_contents = (
        "title i general dispositions (1) state b's first provision (2) state "
        "b's second provision [1] is better than the first provision"
    )
    transformed_state_c_contents = (
        "title i general dispositions (1) state c's first provision (2) state "
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
            "Title I - General Dispositions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_a_contents = (
        "title i general dispositions state a's first provision state a's "
        "second provision is better than the first provision"
    )
    transformed_state_b_contents = (
        "title i general dispositions state b's first provision state b's "
        "second provision is better than the first provision"
    )
    transformed_state_c_contents = (
        "title i general dispositions state c's first provision state c's "
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
            "Title I - General Dispositions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_a_contents = (
        "title i general dispositions (1) state a's first provision (2) state "
        "a's second provision [a] is better than the first provision"
    )
    transformed_state_c_contents = (
        "title i general dispositions (1) state c's first provision (2) state "
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
            "Title I - General Dispositions\n"
            "(1) State A's first provision.\n"
            "(2) State A's second provision: [a] is better than the first provision.\n"
        ),
        'state_b_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State B's first provision.\n"
            "(2) State B's second provision: [1] is better than the first provision.\n"
        ),
        'state_c_english.txt': (
            "Title I - General Dispositions\n"
            "(1) State C's first provision.\n"
            "(2) State C's second provision: [•] is better than the first provision.\n"
        ),
    }

    transformed_state_b_contents = (
        "title i general dispositions (1) state b's first provision (2) state "
        "b's second provision [1] is better than the first provision"
    )
    transformed_state_c_contents = (
        "title i general dispositions (1) state c's first provision (2) state "
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


def test_element_generator_yields_tuple_of_row_label_and_column_label_and_element():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'test_similarity_matrix.csv': (
            'State A,0.01,0.02,0.03\n'
            'State B,0.04,0.05,0.06\n'
            'State C,0.07,0.08,0.09\n'
        ),
    }

    similarity_matrix_file_path = os.path.join(
        test_directory_path, 'test_similarity_matrix.csv')

    expected_row_labels_and_column_labels_and_elements = [
        ('State A', 'State A', 0.01),
        ('State A', 'State B', 0.02),
        ('State A', 'State C', 0.03),
        ('State B', 'State A', 0.04),
        ('State B', 'State B', 0.05),
        ('State B', 'State C', 0.06),
        ('State C', 'State A', 0.07),
        ('State C', 'State B', 0.08),
        ('State C', 'State C', 0.09),
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_row_labels_and_column_labels_and_elements = [
            labels_and_element for labels_and_element in
            similarity_matrix.element_generator(similarity_matrix_file_path)
        ]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert len(expected_row_labels_and_column_labels_and_elements) == \
        len(actual_row_labels_and_column_labels_and_elements)
    for index in range(len(expected_row_labels_and_column_labels_and_elements)):
        assert len(expected_row_labels_and_column_labels_and_elements[index]) == \
            len(actual_row_labels_and_column_labels_and_elements[index])
        assert expected_row_labels_and_column_labels_and_elements[index][0] == \
            actual_row_labels_and_column_labels_and_elements[index][0]
        assert expected_row_labels_and_column_labels_and_elements[index][1] == \
            actual_row_labels_and_column_labels_and_elements[index][1]
        assert round(abs(
            expected_row_labels_and_column_labels_and_elements[index][2] -
            actual_row_labels_and_column_labels_and_elements[index][2]), 4) <= EPSILON
