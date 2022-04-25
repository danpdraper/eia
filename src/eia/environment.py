import os

import eia.exceptions as exceptions


def get_environment_variable_value(environment_variable_key):
    return os.environ.get(environment_variable_key)


def get_environment_root_path():
    virtual_environment_root_path = get_environment_variable_value('VIRTUAL_ENV')
    if not virtual_environment_root_path:
        raise exceptions.FatalError(
            'Please activate the virtual environment before starting the application.')
    return os.path.join(os.path.sep, *virtual_environment_root_path.split(os.path.sep)[:-1])


ENVIRONMENT_ROOT_PATH = get_environment_root_path()


ENACTMENT_YEARS_DEFAULT_FILE_PATH = os.path.join(
    ENVIRONMENT_ROOT_PATH, 'configuration', 'enactment_years.csv')


LEGISLATION_DIRECTORY_PATH = os.path.join(
    ENVIRONMENT_ROOT_PATH, 'raw_data', 'preprocessed')


LOG_DIRECTORY_PATH = os.path.join(ENVIRONMENT_ROOT_PATH, 'logs')


STATES_TO_INCLUDE_DEFAULT_FILE_PATH = os.path.join(
    ENVIRONMENT_ROOT_PATH, 'configuration', 'states_to_include.txt')
