import os
import shutil


def silently_unlink_file(file_path):
    try:
        os.unlink(file_path)
    except OSError:
        pass


def silently_delete_directory_tree(directory_path):
    shutil.rmtree(directory_path, ignore_errors=True)
