import logging
import os
import re

import eia.files.input_output as input_output
import eia.files.text_files as text_files
import eia.scopes as scopes
import eia.transformations as transformations


LOGGER = logging.getLogger(__name__)


PROVISION_REGEX = re.compile(r'^\(([0-9]+)\) (.*)')


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


TRANSFORMATIONS = [
    transformations.delete_provision_delimiters_from_string,
    transformations.delete_punctuation_from_string,
    transformations.reduce_whitespace_in_string_to_single_space_between_successive_words,
]
TRANSFORMATIONS_PRESERVE_PROVISION_DELIMITERS = [
    transformations.delete_punctuation_from_string,
    transformations.reduce_whitespace_in_string_to_single_space_between_successive_words,
]


def apply_transformations_to_input_text(
        input_text, preserve_provision_delimiters):
    transformations = TRANSFORMATIONS_PRESERVE_PROVISION_DELIMITERS if \
        preserve_provision_delimiters else TRANSFORMATIONS
    for transformation in transformations:
        input_text = transformation(input_text)
    return input_text


def full_text_input_text_generator(file_paths, preserve_provision_delimiters):
    for file_path in file_paths:
        LOGGER.info("Generating input text from file {}".format(file_path))
        yield (
            transformations.file_path_to_state_name_capitalized(file_path),
            apply_transformations_to_input_text(
                input_output.read(file_path),
                preserve_provision_delimiters).lower(),
        )


def provision_input_text_generator(file_paths, preserve_provision_delimiters):
    for file_path in file_paths:
        for line in input_output.line_generator(file_path):
            provision_match = PROVISION_REGEX.match(line)
            if not provision_match:
                continue
            LOGGER.info(
                "Generating input text from provision {} in file {}".format(
                    provision_match.group(1), file_path))
            yield (
                "{} {}".format(
                    transformations.file_path_to_state_name_capitalized(file_path),
                    provision_match.group(1)),
                apply_transformations_to_input_text(
                    provision_match.group(2),
                    preserve_provision_delimiters).lower(),
            )


INPUT_TEXT_GENERATORS_BY_SCOPE = {
    scopes.FULL_TEXT: full_text_input_text_generator,
    scopes.PROVISION: provision_input_text_generator,
}


def input_text_generator(
        scope, language, text_file_directory_path,
        preserve_provision_delimiters):
    file_paths = text_files.filter_file_paths_by_language(
        text_files.discover(text_file_directory_path), language)
    LOGGER.info(
        "Found {} text files in language {} in directory {}".format(
            len(file_paths), language, text_file_directory_path))
    return INPUT_TEXT_GENERATORS_BY_SCOPE[scope](
        file_paths, preserve_provision_delimiters)
