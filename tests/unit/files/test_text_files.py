import os

import eia.languages as languages
import eia.files.text_files as text_files
import eia.tests.utilities as utilities


def create_test_directory():
    test_directory_path = os.path.join(os.path.sep, 'tmp', 'test_text_files')
    utilities.silently_delete_directory_tree(test_directory_path)
    os.makedirs(test_directory_path)
    return test_directory_path


def test_discover_returns_paths_to_all_text_files_in_directory():
    test_directory_path = create_test_directory()
    first_file_path = os.path.join(test_directory_path, 'first_file.txt')
    # Misspelled extension
    second_file_path = os.path.join(test_directory_path, 'second_file.tx')
    # File with non-text extension
    third_file_path = os.path.join(test_directory_path, 'third_file.py')
    # File without extension
    fourth_file_path = os.path.join(test_directory_path, 'fourth_file')
    fifth_file_path = os.path.join(test_directory_path, 'fifth_file.txt')

    expected_file_paths = sorted([first_file_path, fifth_file_path])

    try:
        open(first_file_path, 'w').close()
        open(second_file_path, 'w').close()
        open(third_file_path, 'w').close()
        open(fourth_file_path, 'w').close()
        open(fifth_file_path, 'w').close()
        actual_file_paths = sorted(text_files.discover(test_directory_path))
    finally:
        utilities.silently_delete_directory_tree(test_directory_path)

    assert expected_file_paths == actual_file_paths


def test_discover_returns_paths_to_text_files_in_nested_directories():
    test_directory_path = create_test_directory()
    nested_directory = os.path.join(test_directory_path, 'nested')
    nested_nested_directory = os.path.join(
        test_directory_path, 'nested', 'nested_again')
    os.makedirs(nested_nested_directory)

    first_file_path = os.path.join(test_directory_path, 'first_file.txt')
    second_file_path = os.path.join(nested_directory, 'second_file.txt')
    third_file_path = os.path.join(nested_nested_directory, 'third_file.txt')
    # File without extension
    fourth_file_path = os.path.join(nested_nested_directory, 'fourth_file')

    expected_file_paths = sorted([first_file_path, second_file_path, third_file_path])

    try:
        open(first_file_path, 'w').close()
        open(second_file_path, 'w').close()
        open(third_file_path, 'w').close()
        open(fourth_file_path, 'w').close()
        actual_file_paths = sorted(text_files.discover(test_directory_path))
    finally:
        utilities.silently_delete_directory_tree(test_directory_path)

    assert expected_file_paths == actual_file_paths


def test_filter_file_paths_by_language_only_returns_files_whose_language_matches_that_provided():
    file_paths = [
        '/path/to/state_a_english.txt',
        '/path/to/state_b_french.txt',
        '/path/to/state_c_spanish.txt',
        '/path/to/state_d_russian.txt',
        # Misspelled language in file name
        '/path/to/state_e_engish.txt',
        '/path/to/state_f_english.txt',
    ]
    expected_file_paths = [
        '/path/to/state_a_english.txt',
        '/path/to/state_f_english.txt',
    ]
    assert expected_file_paths == \
        text_files.filter_file_paths_by_language(file_paths, languages.ENGLISH)
