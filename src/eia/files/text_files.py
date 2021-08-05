import os
import re

import eia.conversion as conversion
import eia.files.file_input_output as file_input_output
import eia.files.text_files as text_files


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
        lambda file_path: file_name_suffix_regex.search(file_path),
        file_paths))


def input_text_generator(scope, language, text_file_directory_path):
    file_paths = text_files.filter_file_paths_by_language(
        text_files.discover(text_file_directory_path), language)
    for file_path in file_paths:
        yield (
            conversion.file_path_to_state_name_capitalized(file_path),
            file_input_output.FileReader(file_path).read_text_unbroken()
        )
