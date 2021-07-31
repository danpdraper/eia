import pytest

import eia.file_path_converter as file_path_converter


def test_to_state_name_capitalized_strips_leading_path_components_and_language_and_suffix_from_path():
    file_path = '/path/to/state_a_english.txt'
    assert 'State A' == file_path_converter.to_state_name_capitalized(file_path)

def test_to_state_name_capitalized_capitalizes_first_letter_in_each_word_and_replaces_underscores_with_spaces():
    file_path = '/path/to/very_long_state_name_english.txt'
    assert 'Very Long State Name' == file_path_converter.to_state_name_capitalized(file_path)

def test_to_state_name_capitalized_raises_value_error_if_file_path_does_not_conform_to_expected_format():
    # File name missing extension
    file_path = '/path/to/state_a_english'
    with pytest.raises(ValueError):
        file_path_converter.to_state_name_capitalized(file_path)
    # File name missing path
    file_path = 'state_a_english.txt'
    with pytest.raises(ValueError):
        file_path_converter.to_state_name_capitalized(file_path)
    # File name contains uppercase characters
    file_path = '/path/to/State_A_English.txt'
    with pytest.raises(ValueError):
        file_path_converter.to_state_name_capitalized(file_path)
