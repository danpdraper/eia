import logging
import os
import unittest.mock as mock

import eia.languages as languages
import eia.similarity_matrix as similarity_matrix
import eia.scopes as scopes
import eia.tests.utilities as utilities


LOGGER = logging.getLogger(__name__)


def create_test_directory():
    test_directory_path = os.path.join(os.path.sep, 'tmp', 'test_similarity_matrix')
    utilities.silently_delete_directory_tree(test_directory_path)
    os.makedirs(test_directory_path)
    LOGGER.info("Created directory {}".format(test_directory_path))
    return test_directory_path


def populate_row_generator_test_files(test_directory_path):
    state_a_file_path = os.path.join(test_directory_path, 'state_a_english.txt')
    state_b_file_path = os.path.join(test_directory_path, 'state_b_english.txt')
    state_c_file_path = os.path.join(test_directory_path, 'state_c_english.txt')

    with open(state_a_file_path, 'w') as file_object:
        file_object.write('State A test file contents')
    LOGGER.info("Wrote State A file contents to {}".format(state_a_file_path))

    with open(state_b_file_path, 'w') as file_object:
        file_object.write('State B test file contents')
    LOGGER.info("Wrote State B file contents to {}".format(state_b_file_path))

    with open(state_c_file_path, 'w') as file_object:
        file_object.write('State C test file contents')
    LOGGER.info("Wrote State C file contents to {}".format(state_c_file_path))


def test_row_generator_yields_tuples_of_row_label_and_row():
    test_directory_path = create_test_directory()

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
        populate_row_generator_test_files(test_directory_path)
        row_generator = similarity_matrix.row_generator(
            algorithm, scopes.FULL_TEXT, languages.ENGLISH, test_directory_path)
        actual_labels_and_rows = [label_and_row for label_and_row in row_generator]
    finally:
        utilities.silently_delete_directory_tree(test_directory_path)
        LOGGER.info("Deleted directory {}".format(test_directory_path))

    assert expected_labels_and_rows == actual_labels_and_rows
