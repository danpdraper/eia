import os

import eia.file_reader as file_reader
import eia.tests.utilities as utilities


class TestFileReader(object):
    def setup(self):
        self.file_path = os.path.join(os.path.sep, 'tmp', 'test_file_loader.txt')
        utilities.silently_unlink_file(self.file_path)
        self.file_reader = file_reader.FileReader(self.file_path)

    def teardown(self):
        utilities.silently_unlink_file(self.file_path)

    def write_contents_to_file(self, contents):
        with open(self.file_path, 'w') as file_object:
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
