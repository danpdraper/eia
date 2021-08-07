import logging
import os
import shutil


LOGGER = logging.getLogger(__name__)


def silently_delete_directory_tree(directory_path):
    shutil.rmtree(directory_path, ignore_errors=True)


def create_test_directory(directory_name):
    test_directory_path = os.path.join(os.path.sep, 'tmp', directory_name)
    silently_delete_directory_tree(test_directory_path)
    os.makedirs(test_directory_path)
    LOGGER.info("Created directory {}".format(test_directory_path))
    return test_directory_path


def populate_test_directory(test_directory_path, file_content_by_relative_path):
    for relative_path, file_content in file_content_by_relative_path.items():
        if os.path.sep in relative_path:
            file_directory_path = os.path.join(
                test_directory_path, os.path.split(relative_path)[0])
            if not os.path.isdir(file_directory_path):
                os.makedirs(file_directory_path)
                LOGGER.info("Created directory {}".format(file_directory_path))
        file_path = os.path.join(test_directory_path, relative_path)
        LOGGER.info("Writing the following to {}: {}".format(file_path, file_content))
        with open(file_path, 'w') as file_object:
            file_object.write(file_content)
        LOGGER.info(
            "Wrote the following to {}: {}".format(file_path, file_content))


def delete_test_directory(test_directory_path):
    silently_delete_directory_tree(test_directory_path)
    LOGGER.info("Deleted directory {}".format(test_directory_path))
