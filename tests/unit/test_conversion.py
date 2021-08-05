import pytest

import eia.conversion as conversion


def test_file_path_to_state_name_capitalized_strips_leading_path_components_and_language_and_suffix_from_path():
    file_path = '/path/to/state_a_english.txt'
    assert 'State A' == conversion.file_path_to_state_name_capitalized(file_path)


def test_file_path_to_state_name_capitalized_capitalizes_first_letter_in_each_word_and_replaces_underscores():
    file_path = '/path/to/very_long_state_name_english.txt'
    assert 'Very Long State Name' == conversion.file_path_to_state_name_capitalized(file_path)


def test_to_state_name_capitalized_raises_value_error_if_file_path_does_not_conform_to_expected_format():
    # File name missing extension
    file_path = '/path/to/state_a_english'
    with pytest.raises(ValueError):
        conversion.file_path_to_state_name_capitalized(file_path)
    # File name missing path
    file_path = 'state_a_english.txt'
    with pytest.raises(ValueError):
        conversion.file_path_to_state_name_capitalized(file_path)
    # File name contains uppercase characters
    file_path = '/path/to/State_A_English.txt'
    with pytest.raises(ValueError):
        conversion.file_path_to_state_name_capitalized(file_path)


def test_label_and_row_tuple_to_comma_separated_string_converts_list_containing_integers_to_comma_separated_string():
    label_and_row = ('Test Label', [1, 2, 3])
    expected_string = 'Test Label,1,2,3'
    actual_string = conversion.label_and_row_tuple_to_comma_separated_string(label_and_row)
    assert expected_string == actual_string


def test_label_and_row_tuple_to_comma_separated_string_converts_list_containing_floats_to_comma_separated_string():
    label_and_row = ('Test Label', [0.1, 0.2, 0.3])
    expected_string = 'Test Label,0.1,0.2,0.3'
    actual_string = conversion.label_and_row_tuple_to_comma_separated_string(label_and_row)
    assert expected_string == actual_string


def test_capitalized_string_to_snake_case_converts_capitalized_letters_to_lowercase_and_adds_underscores():
    capitalized_string = 'TestCapitalizedString'
    expected_string = 'test_capitalized_string'
    actual_string = conversion.capitalized_string_to_snake_case(capitalized_string)
    assert expected_string == actual_string


def test_capitalized_string_to_snake_case_raises_value_error_if_string_is_not_capitalized():
    # Snake case string
    string = 'test_capitalized_string'
    with pytest.raises(ValueError):
        conversion.capitalized_string_to_snake_case(string)
