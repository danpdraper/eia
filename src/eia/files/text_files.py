import os
import re


def discover(text_file_directory_path):
    text_file_paths = []
    for root_directory_path, directory_names, file_names in \
            os.walk(text_file_directory_path):
        for file_name in file_names:
            if file_name.endswith('.txt'):
                text_file_paths.append(
                    os.path.join(root_directory_path, file_name))
    return text_file_paths


def filter_file_paths_by_language(file_paths, language):
    file_name_suffix_regex = re.compile(r"{}\.txt".format(language))
    return list(filter(
        lambda file_path : file_name_suffix_regex.search(file_path),
        file_paths))
