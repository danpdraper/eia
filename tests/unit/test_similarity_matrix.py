import unittest.mock as mock

import eia.languages as languages
import eia.similarity_matrix as similarity_matrix
import eia.scopes as scopes
import eia.tests.utilities as utilities


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

    assert expected_labels_and_rows == actual_labels_and_rows
