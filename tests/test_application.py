import os
import unittest.mock as mock

import eia.application as application
import eia.languages as languages
import eia.text_file_discoverer as text_file_discoverer
import eia.text_file_language_filterer as text_file_language_filterer
import mock_similarity_calculator
import utilities


def test_compare_legislation_produces_similarity_matrix():
    # Create directory for test legislation
    legislation_directory_path = os.path.join(os.path.sep, 'tmp', 'test_application')
    utilities.silently_delete_directory_tree(legislation_directory_path)
    os.makedirs(legislation_directory_path)

    # Populate directory with test legislation from three states
    text_of_state_a_legislation = 'Text of state A legislation'
    text_of_state_b_legislation = 'Text of state B legislation'
    text_of_state_c_legislation = 'Text of state C legislation'
    legislation_text_by_file_path = {
        os.path.join(legislation_directory_path, 'state_a_english.txt'): text_of_state_a_legislation,
        os.path.join(legislation_directory_path, 'state_b_english.txt'): text_of_state_b_legislation,
        os.path.join(legislation_directory_path, 'state_c_english.txt'): text_of_state_c_legislation,
    }
    for file_path, text in legislation_text_by_file_path.items():
        with open(file_path, 'w') as file_object:
            file_object.write(text)

    discoverer = text_file_discoverer.TextFileDiscoverer(
        legislation_directory_path)
    language_filterer = text_file_language_filterer.TextFileLanguageFilterer(
        languages.ENGLISH)

    # The similarity_values dict corresponds to the following similarity matrix:
    #                  [ first_state second_state third_state ]
    # [ first_state  ] [      1           0.5         0.2     ]
    # [ second_state ] [     0.5           1          0.3     ]
    # [ third_state  ] [     0.2          0.3          1      ]
    similarity_values = {
        (text_of_state_a_legislation, text_of_state_a_legislation): 1,
        (text_of_state_a_legislation, text_of_state_b_legislation): 0.5,
        (text_of_state_a_legislation, text_of_state_c_legislation): 0.2,
        (text_of_state_b_legislation, text_of_state_a_legislation): 0.5,
        (text_of_state_b_legislation, text_of_state_b_legislation): 1,
        (text_of_state_b_legislation, text_of_state_c_legislation): 0.3,
        (text_of_state_c_legislation, text_of_state_a_legislation): 0.2,
        (text_of_state_c_legislation, text_of_state_b_legislation): 0.3,
        (text_of_state_c_legislation, text_of_state_c_legislation): 1,
    }
    # In production, the SimilarityCalculator subclass will apply the comparison
    # algorithm, e.g. Jaccard similarity, TF-IDF
    similarity_calculator = \
        mock_similarity_calculator.MockSimilarityCalculator(similarity_values)

    expected_labels = ['State A', 'State B', 'State C']
    try:
        actual_labels, similarity_matrix = application.compare_legislation(
            discoverer, language_filterer, similarity_calculator)
    finally:
        # Ensure that test legislation directory is deleted if the
        # compare_legislation function raises an exception
        utilities.silently_delete_directory_tree(legislation_directory_path)

    assert sorted(expected_labels) == sorted(actual_labels)
    state_a_index = actual_labels.index('State A')
    state_b_index = actual_labels.index('State B')
    state_c_index = actual_labels.index('State C')
    assert 1 == similarity_matrix[state_a_index][state_a_index]
    assert 0.5 == similarity_matrix[state_a_index][state_b_index]
    assert 0.2 == similarity_matrix[state_a_index][state_c_index]
    assert 0.5 == similarity_matrix[state_b_index][state_a_index]
    assert 1 == similarity_matrix[state_b_index][state_b_index]
    assert 0.3 == similarity_matrix[state_b_index][state_c_index]
    assert 0.2 == similarity_matrix[state_c_index][state_a_index]
    assert 0.3 == similarity_matrix[state_c_index][state_b_index]
    assert 1 == similarity_matrix[state_c_index][state_c_index]
