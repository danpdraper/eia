import pytest

import eia.transformations as transformations


def test_file_path_to_state_name_capitalized_strips_leading_path_components_and_language_and_suffix_from_path():
    file_path = '/path/to/state_a_english.txt'
    assert 'State A' == transformations.file_path_to_state_name_capitalized(file_path)


def test_file_path_to_state_name_capitalized_capitalizes_first_letter_in_each_word_and_replaces_underscores():
    file_path = '/path/to/very_long_state_name_english.txt'
    assert 'Very Long State Name' == transformations.file_path_to_state_name_capitalized(file_path)


def test_file_path_to_state_name_capitalized_raises_value_error_if_file_path_does_not_conform_to_expected_format():
    # File name missing extension
    file_path = '/path/to/state_a_english'
    with pytest.raises(ValueError):
        transformations.file_path_to_state_name_capitalized(file_path)
    # File name missing path
    file_path = 'state_a_english.txt'
    with pytest.raises(ValueError):
        transformations.file_path_to_state_name_capitalized(file_path)
    # File name contains uppercase characters
    file_path = '/path/to/State_A_English.txt'
    with pytest.raises(ValueError):
        transformations.file_path_to_state_name_capitalized(file_path)


def test_label_and_row_tuple_to_comma_separated_string_converts_list_containing_integers_to_comma_separated_string():
    label_and_row = ('Test Label', [1, 2, 3])
    expected_string = 'Test Label,1,2,3'
    actual_string = transformations.label_and_row_tuple_to_comma_separated_string(label_and_row)
    assert expected_string == actual_string


def test_label_and_row_tuple_to_comma_separated_string_converts_list_containing_floats_to_comma_separated_string():
    label_and_row = ('Test Label', [0.1, 0.2, 0.3])
    expected_string = 'Test Label,0.10000,0.20000,0.30000'
    actual_string = transformations.label_and_row_tuple_to_comma_separated_string(label_and_row)
    assert expected_string == actual_string


def test_comma_separated_string_to_label_and_row_tuple_converts_string_to_label_and_list_containing_floats():
    comma_separated_string = 'Test Label,0.1,0.2,0.3'
    expected_label_and_row = ('Test Label', [0.1, 0.2, 0.3])
    actual_label_and_row = transformations.comma_separated_string_to_label_and_row_tuple(
        comma_separated_string)
    assert expected_label_and_row == actual_label_and_row


def test_capitalized_string_to_snake_case_converts_capitalized_letters_to_lowercase_and_adds_underscores():
    # No spaces
    capitalized_string = 'TestCapitalizedString'
    expected_string = 'test_capitalized_string'
    actual_string = transformations.capitalized_string_to_snake_case(capitalized_string)
    assert expected_string == actual_string
    # Spaces between words
    capitalized_string = 'Test Capitalized String'
    expected_string = 'test_capitalized_string'
    actual_string = transformations.capitalized_string_to_snake_case(capitalized_string)
    assert expected_string == actual_string


def test_capitalized_string_to_snake_case_raises_value_error_if_string_is_not_capitalized():
    # Snake case string
    string = 'test_capitalized_string'
    with pytest.raises(ValueError):
        transformations.capitalized_string_to_snake_case(string)


def test_snake_case_string_to_capitalized_capitalizes_first_letter_of_each_word_and_removes_underscores():
    snake_case_string = 'test_snake_case_string'
    expected_string = 'Test Snake Case String'
    actual_string = transformations.snake_case_string_to_capitalized(snake_case_string)
    assert expected_string == actual_string


def test_snake_case_string_to_capitalized_raises_value_error_if_string_is_not_snake_case():
    # Capitalized String
    string = 'Test Snake Case String'
    with pytest.raises(ValueError):
        transformations.snake_case_string_to_capitalized(string)
    # Uppercase String
    string = 'TEST SNAKE CASE STRING'
    with pytest.raises(ValueError):
        transformations.snake_case_string_to_capitalized(string)


def test_list_to_occurrences_returns_dict_containing_number_of_occurrences_of_each_item_in_provided_list():
    list_to_transform = ['i', 'like', 'walking', 'the', 'dog', 'while', 'walking', 'the', 'cat']
    expected_occurrences = {
        'i': 1,
        'like': 1,
        'walking': 2,
        'the': 2,
        'dog': 1,
        'while': 1,
        'cat': 1,
    }
    assert expected_occurrences == transformations.list_to_occurrences(list_to_transform)


def test_delete_punctuation_from_string_deletes_all_punctuation_from_provided_string():
    string = 'Test, test; test: test. test-test "Test" , \'test\' ; tes\'t . test : test ? test - test'
    expected_string = 'Test test test test testtest Test  test  tes\'t  test  test  test  test'
    actual_string = transformations.delete_punctuation_from_string(string)
    assert expected_string == actual_string


def test_delete_punctuation_from_string_preserves_parentheses_and_brackets():
    string = '(1) [1] Test [2] test [i] test'
    expected_string = '(1) [1] Test [2] test [i] test'
    actual_string = transformations.delete_punctuation_from_string(string)
    assert expected_string == actual_string


def test_delete_punctuation_from_string_preserves_apostrophes():
    string = "It's going to be difficult for the country's population to grow"
    expected_string = "It's going to be difficult for the country's population to grow"
    actual_string = transformations.delete_punctuation_from_string(string)
    assert expected_string == actual_string


def test_delete_provision_delimiters_from_string_deletes_all_provision_delimiters_from_provided_string():
    # Single-digit provision number
    string = '(1) Test [1] test [22] test [a] test [B] test [i] test [V] test [•]'
    expected_string = ' Test  test  test  test  test  test  test '
    actual_string = transformations.delete_provision_delimiters_from_string(string)
    assert expected_string == actual_string

    # Multi-digit provision number
    string = '(99) Test [1] test [22] test [a] test [B] test [i] test [V] test [•]'
    actual_string = transformations.delete_provision_delimiters_from_string(string)
    assert expected_string == actual_string


def test_reduce_whitespace_in_string_to_single_space_between_successive_words_deletes_all_but_single_space():
    string = 'Test  test \ntest \ttest\n\ntest\n\ttest\t\ttest'
    expected_string = 'Test test test test test test test'
    actual_string = transformations.reduce_whitespace_in_string_to_single_space_between_successive_words(string)
    assert expected_string == actual_string


def test_reduce_whitespace_in_string_to_single_space_between_successive_words_deletes_leading_and_trailing_space():
    string = ' \n\tTest  test\t\n '
    expected_string = 'Test test'
    actual_string = transformations.reduce_whitespace_in_string_to_single_space_between_successive_words(string)
    assert expected_string == actual_string
