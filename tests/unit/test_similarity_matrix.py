import unittest.mock as mock

import eia.languages as languages
import eia.similarity_matrix as similarity_matrix
import eia.scopes as scopes
import eia.tests.utilities as utilities


def test_row_generator_yields_tuples_of_row_label_and_row():
    test_directory_path = utilities.create_test_directory('test_similarity_matrix')

    file_content_by_relative_path = {
        'state_a_english.txt': 'State A test file contents',
        'state_b_english.txt': 'State B test file contents',
        'state_c_english.txt': 'State C test file contents',
    }

    similarity_by_row_and_column_text = {
        ('State A test file contents', 'State A test file contents'): 1,
        ('State A test file contents', 'State B test file contents'): 2,
        ('State A test file contents', 'State C test file contents'): 3,
        ('State B test file contents', 'State A test file contents'): 4,
        ('State B test file contents', 'State B test file contents'): 5,
        ('State B test file contents', 'State C test file contents'): 6,
        ('State C test file contents', 'State A test file contents'): 7,
        ('State C test file contents', 'State B test file contents'): 8,
        ('State C test file contents', 'State C test file contents'): 9,
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
            algorithm, scopes.FULL_TEXT, languages.ENGLISH, test_directory_path)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_labels_and_rows == actual_labels_and_rows
