import pytest

import eia.files.csv_files as csv_files


def test_contains_comma_returns_true_when_string_contains_comma():
    assert csv_files.contains_comma('test, string') is True


def test_contains_comma_returns_false_when_string_does_not_contain_comma():
    assert csv_files.contains_comma('test string') is False


def test_state_and_provision_number_from_label_extracts_state_name_and_provision_number_from_label():
    # Single-word state name
    label = 'A'
    actual_label_and_provision = csv_files.state_and_provision_number_from_label(label)
    assert 'A' == actual_label_and_provision[0]
    assert actual_label_and_provision[1] is None
    # Multi-word state name
    label = 'State A'
    actual_label_and_provision = csv_files.state_and_provision_number_from_label(label)
    assert 'State A' == actual_label_and_provision[0]
    assert actual_label_and_provision[1] is None
    # Single-word state name and single-digit provision number
    label = 'A 1'
    assert 'A', '1' == csv_files.state_and_provision_number_from_label(label)
    # Single-word state name and multi-digit provision number
    label = 'A 22'
    assert 'A', '22' == csv_files.state_and_provision_number_from_label(label)
    # Multi-word state name and single-digit provision number
    label = 'State A 1'
    assert 'State A', '1' == csv_files.state_and_provision_number_from_label(label)
    # Multi-word state name and multi-digit provision number
    label = 'State A 22'
    assert 'State A', '22' == csv_files.state_and_provision_number_from_label(label)


def test_state_and_provision_number_from_label_raises_value_error_when_provided_string_does_not_match_expected_format():
    # Provision number without state name
    label = '1'
    with pytest.raises(ValueError):
        csv_files.state_and_provision_number_from_label(label)
