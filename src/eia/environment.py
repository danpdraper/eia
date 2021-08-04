import os

import eia.exceptions as exceptions


def get_environment_variable_value(environment_variable_key):
    return os.environ.get(environment_variable_key)


def get_environment_root_path():
    virtual_environment_root_path = get_environment_variable_value('VIRTUAL_ENV')
    if not virtual_environment_root_path:
        raise exceptions.FatalError('Please activate the virtual environment '
            'before starting the application.')
    return os.path.join(os.path.sep, *virtual_environment_root_path.split(os.path.sep)[:-1])


ENVIRONMENT_ROOT_PATH = get_environment_root_path()
