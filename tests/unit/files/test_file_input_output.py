import os

import eia.files.file_input_output as file_input_output
import eia.tests.utilities as utilities


class TestFileReader(object):
    def setup(self):
        self.test_directory_path = utilities.create_test_directory('test_file_input_output')
        self.test_file_path = os.path.join(self.test_directory_path, 'test_file.txt')
        self.file_reader = file_input_output.FileReader(self.test_file_path)

    def teardown(self):
        utilities.delete_test_directory(self.test_directory_path)

    def write_contents_to_file(self, contents):
        with open(self.test_file_path, 'w') as file_object:
            file_object.write(contents)

    def test_read_next_line_returns_next_line_with_line_index_on_each_successive_invocation(self):
        file_contents = 'First line\nSecond line\nThird line'
        self.write_contents_to_file(file_contents)
        assert (0, 'First line') == self.file_reader.read_next_line()
        assert (1, 'Second line') == self.file_reader.read_next_line()
        assert (2, 'Third line') == self.file_reader.read_next_line()

    def test_read_next_line_loops_back_to_first_line_after_reading_last_line(self):
        file_contents = 'First line\nSecond line'
        self.write_contents_to_file(file_contents)
        assert (0, 'First line') == self.file_reader.read_next_line()
        assert (1, 'Second line') == self.file_reader.read_next_line()
        assert (0, 'First line') == self.file_reader.read_next_line()
        assert (1, 'Second line') == self.file_reader.read_next_line()
        assert (0, 'First line') == self.file_reader.read_next_line()
        assert (1, 'Second line') == self.file_reader.read_next_line()

    def test_read_text_unbroken_returns_file_contents_as_unbroken_string(self):
        expected_file_contents = 'First line\nSecond line\nThird line'
        self.write_contents_to_file(expected_file_contents)
        actual_file_contents = self.file_reader.read_text_unbroken()
        assert expected_file_contents == actual_file_contents


def line_generator(lines):
    for line in lines:
        yield line


def test_write_writes_all_lines_yielded_by_generator_to_provided_file_path():
    test_directory_path = utilities.create_test_directory('test_file_input_output')
    test_file_path = os.path.join(test_directory_path, 'output.csv')
    expected_output = [
        '1,2,3,4',
        '5,6,7,8',
        '9,10,11,12',
    ]
    try:
        file_input_output.write(test_file_path, line_generator(expected_output))
        with open(test_file_path, 'r') as file_object:
            actual_output = file_object.read().split('\n')[:-1]
    finally:
        utilities.delete_test_directory(test_directory_path)
    assert expected_output == actual_output
