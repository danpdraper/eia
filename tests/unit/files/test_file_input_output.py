import os

import eia.files.file_input_output as file_input_output
import eia.tests.utilities as utilities


def test_read_returns_all_file_contents():
    test_directory_path = utilities.create_test_directory('test_file_input_output')
    file_content_by_relative_path = {
        'test_file.txt': 'First line\nSecond line\nThird line\n',
    }
    file_path = os.path.join(test_directory_path, 'test_file.txt')
    expected_contents = 'First line\nSecond line\nThird line\n'

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_contents = file_input_output.read(file_path)
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_contents == actual_contents


def test_line_generator_yields_all_lines_in_file():
    test_directory_path = utilities.create_test_directory('test_file_input_output')
    file_content_by_relative_path = {
        'test_file.txt': 'First line\nSecond line\nThird line\n',
    }
    file_path = os.path.join(test_directory_path, 'test_file.txt')
    expected_lines = [
        'First line',
        'Second line',
        'Third line',
    ]

    try:
        utilities.populate_test_directory(
            test_directory_path, file_content_by_relative_path)
        actual_lines = [line for line in file_input_output.line_generator(file_path)]
    finally:
        utilities.delete_test_directory(test_directory_path)

    assert expected_lines == actual_lines


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
