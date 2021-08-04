import os

import pytest

import eia.environment as environment
import eia.exceptions as exceptions


def test_get_environment_variable_value_returns_value_when_environment_variable_set():
    environment_variable_key = 'TEST_ENVIRONMENT_VARIABLE_KEY'
    expected_environment_variable_value = 'test_environment_variable_value'
    previous_environment_variable_value = os.environ.get(environment_variable_key)
    os.environ[environment_variable_key] = expected_environment_variable_value
    try:
        actual_environment_variable_value = environment.get_environment_variable_value(
            environment_variable_key)
    finally:
        if previous_environment_variable_value:
            os.environ[environment_variable_key] = previous_environment_variable_value
        else:
            del os.environ[environment_variable_key]
    assert expected_environment_variable_value == actual_environment_variable_value

def test_get_environment_variable_value_returns_none_when_environment_variable_not_set():
    environment_variable_key = 'TEST_ENVIRONMENT_VARIABLE_KEY'
    previous_environment_variable_value = os.environ.get(environment_variable_key)
    if previous_environment_variable_value:
        del os.environ[environment_variable_key]
    try:
        actual_environment_variable_value = environment.get_environment_variable_value(
            environment_variable_key)
    finally:
        if previous_environment_variable_value:
            os.environ[environment_variable_key] = previous_environment_variable_value
    assert None == actual_environment_variable_value


def test_get_environment_root_path_raises_fatal_error_when_virtual_env_environment_variable_not_set():
    environment_variable_key = 'VIRTUAL_ENV'
    previous_environment_variable_value = os.environ.get(environment_variable_key)
    if previous_environment_variable_value:
        del os.environ[environment_variable_key]
    try:
        with pytest.raises(exceptions.FatalError):
            environment.get_environment_root_path()
    finally:
        if previous_environment_variable_value:
            os.environ[environment_variable_key] = previous_environment_variable_value


def test_get_environment_root_path_returns_parent_directory_of_directory_assigned_to_virtual_env_environment_variable():
    environment_variable_key = 'VIRTUAL_ENV'
    previous_environment_variable_value = os.environ.get(environment_variable_key)
    environment_variable_value = '/path/to/environment/root/env'
    expected_environment_root = '/path/to/environment/root'
    os.environ[environment_variable_key] = environment_variable_value
    try:
        actual_environment_root = environment.get_environment_root_path()
    finally:
        if previous_environment_variable_value:
            os.environ[environment_variable_key] = previous_environment_variable_value
        else:
            del os.environ[environment_variable_key]
    assert expected_environment_root == actual_environment_root
