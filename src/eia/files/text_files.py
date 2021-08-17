import logging
import os
import re

import eia.files.input_output as input_output
import eia.scopes as scopes
import eia.transformations as transformations


LOGGER = logging.getLogger(__name__)


COMMENT_LINE_PREFIX = '#'
PROVISION_REGEX = re.compile(r'^\(([0-9]+)\) (.*)')
STATE_REGEX = re.compile(r'^.*\/([a-z_]+)_[a-z]+\.txt$')


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


def filter_file_paths_by_state(file_paths, states):
    return list(map(
        lambda match: match.group(0),
        filter(
            lambda match: match.group(1) in states,
            map(
                lambda file_path: STATE_REGEX.search(file_path),
                file_paths))))


def find_provision_contents(
        text_file_directory_path, language, state_name, provision_number):
    file_paths = filter_file_paths_by_state(
        filter_file_paths_by_language(
            discover(text_file_directory_path), language),
        [transformations.capitalized_string_to_snake_case(state_name)])
    if len(file_paths) != 1:
        raise RuntimeError(
            "Expected to find one file corresponding to state {} and language "
            "{}, found: {}.".format(state_name, language, file_paths))

    provision_number = int(provision_number)
    provision_contents = list(map(
        lambda match: match.group(2),
        filter(
            lambda match: match is not None and int(match.group(1)) == provision_number,
            map(
                lambda line: re.match(PROVISION_REGEX, line),
                input_output.line_generator(file_paths[0])))))
    if len(provision_contents) != 1:
        raise RuntimeError(
            "Expected to find one provision numbered {} in file {}, found: "
            "{}.".format(provision_number, file_paths[0], provision_contents))

    return provision_contents[0]


def is_not_comment(line):
    return not line.startswith(COMMENT_LINE_PREFIX)


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
        LOGGER.debug("Generating input text from file {}".format(file_path))
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
            LOGGER.debug(
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


INPUT_TEXT_GENERATOR_BY_SCOPE = {
    scopes.FULL_TEXT: full_text_input_text_generator,
    scopes.PROVISION: provision_input_text_generator,
}


def input_text_generator(
        scope, language, text_file_directory_path,
        preserve_provision_delimiters, states_to_include=[]):
    file_paths = filter_file_paths_by_language(
        discover(text_file_directory_path), language)
    if states_to_include:
        file_paths = filter_file_paths_by_state(file_paths, states_to_include)
    log_message = "Found {} text files in language {} ".format(
        len(file_paths), language)
    if states_to_include:
        log_message += "from states {} ".format(states_to_include)
    log_message += "in directory {}".format(text_file_directory_path)
    LOGGER.debug(log_message)
    return INPUT_TEXT_GENERATOR_BY_SCOPE[scope](
        file_paths, preserve_provision_delimiters)
