import os

import eia.text_file_discoverer as text_file_discoverer
import utilities


class TestTextFileDiscoverer(object):
    def setup(self):
        self.text_file_directory_path = os.path.join(
            os.path.sep, 'tmp', 'text_file_discoverer')
        utilities.silently_delete_directory_tree(self.text_file_directory_path)
        os.makedirs(self.text_file_directory_path)
        self.text_file_discoverer = text_file_discoverer.TextFileDiscoverer(
            self.text_file_directory_path)

    def teardown(self):
        utilities.silently_delete_directory_tree(self.text_file_directory_path)

    def test_discover_returns_paths_to_all_text_files_in_directory(self):
        first_file_path = os.path.join(self.text_file_directory_path, 'first_file.txt')
        # Misspelled extension
        second_file_path = os.path.join(self.text_file_directory_path, 'second_file.tx')
        # File with non-text extension
        third_file_path = os.path.join(self.text_file_directory_path, 'third_file.py')
        # File without extension
        fourth_file_path = os.path.join(self.text_file_directory_path, 'fourth_file')
        fifth_file_path = os.path.join(self.text_file_directory_path, 'fifth_file.txt')
        open(first_file_path, 'w').close()
        open(second_file_path, 'w').close()
        open(third_file_path, 'w').close()
        open(fourth_file_path, 'w').close()
        open(fifth_file_path, 'w').close()
        expected_file_paths = sorted([first_file_path, fifth_file_path])
        actual_file_paths = sorted(self.text_file_discoverer.discover())
        assert expected_file_paths == actual_file_paths

    def test_discover_returns_paths_to_text_files_in_nested_directories(self):
        nested_directory = os.path.join(self.text_file_directory_path, 'nested')
        nested_nested_directory = os.path.join(
            self.text_file_directory_path, 'nested', 'nested_again')
        os.makedirs(nested_nested_directory)
        first_file_path = os.path.join(self.text_file_directory_path, 'first_file.txt')
        second_file_path = os.path.join(nested_directory, 'second_file.txt')
        third_file_path = os.path.join(nested_nested_directory, 'third_file.txt')
        # File without extension
        fourth_file_path = os.path.join(nested_nested_directory, 'fourth_file')
        open(first_file_path, 'w').close()
        open(second_file_path, 'w').close()
        open(third_file_path, 'w').close()
        open(fourth_file_path, 'w').close()
        expected_file_paths = sorted([first_file_path, second_file_path, third_file_path])
        actual_file_paths = sorted(self.text_file_discoverer.discover())
        assert expected_file_paths == actual_file_paths
