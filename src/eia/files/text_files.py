import logging
import os
import re

import eia.files.input_output as input_output
import eia.scopes as scopes
import eia.transformations as transformations


LOGGER = logging.getLogger(__name__)


COMMENT_LINE_PREFIX = '#'
HIGHEST_PROVISION_GROUP_SCORES_FILE_NAME = 'highest_provision_group_scores.txt'
PROVISION_REGEX = re.compile(r'^\(([^)]+)\) (.*)')
PROVISIONS_KEY = 'Provisions'
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

    provision_number = str(provision_number)
    provision_contents = list(map(
        lambda match: match.group(2),
        filter(
            lambda match: match is not None and match.group(1) == provision_number,
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


def full_text_input_text_generator(file_paths, preserve_provision_delimiters, states_to_include):
    for file_path in file_paths:
        LOGGER.debug("Generating input text from file {}".format(file_path))
        yield (
            transformations.file_path_to_state_name_capitalized(file_path),
            apply_transformations_to_input_text(
                input_output.read(file_path),
                preserve_provision_delimiters).lower(),
        )


def provision_input_text_generator(file_paths, preserve_provision_delimiters, states_to_include):
    for file_path in file_paths:
        for line in input_output.line_generator(file_path):
            provision_match = PROVISION_REGEX.match(line)
            if not provision_match:
                continue
            capitalized_state_name = transformations.file_path_to_state_name_capitalized(file_path)
            if capitalized_state_name in states_to_include and \
                    PROVISIONS_KEY in states_to_include[capitalized_state_name] and \
                    provision_match.group(1) not in states_to_include[capitalized_state_name][PROVISIONS_KEY]:
                LOGGER.debug(
                    "Not generating input text from provision {} in file {}".format(
                        provision_match.group(1), file_path))
                continue
            LOGGER.debug(
                "Generating input text from provision {} in file {}".format(
                    provision_match.group(1), file_path))
            yield (
                "{} {}".format(capitalized_state_name, provision_match.group(1)),
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
        preserve_provision_delimiters, states_to_include={}):
    file_paths = filter_file_paths_by_language(
        discover(text_file_directory_path), language)
    if states_to_include:
        file_paths = filter_file_paths_by_state(
            file_paths,
            [
                transformations.capitalized_string_to_snake_case(state_to_include)
                for state_to_include in states_to_include.keys()
            ])
    log_message = "Found {} text files in language {} ".format(
        len(file_paths), language)
    if states_to_include:
        log_message += "from states {} ".format(list(states_to_include.keys()))
    log_message += "in directory {}".format(text_file_directory_path)
    LOGGER.debug(log_message)
    return INPUT_TEXT_GENERATOR_BY_SCOPE[scope](
        file_paths, preserve_provision_delimiters, states_to_include)


def get_highest_provision_group_scores_file_path(
        highest_provision_group_scores_file_directory_path):
    return os.path.join(
        highest_provision_group_scores_file_directory_path,
        HIGHEST_PROVISION_GROUP_SCORES_FILE_NAME)


def write_statistics_header(
        highest_provision_group_scores_file_directory_path, mean,
        standard_deviation, score_threshold):
    highest_provision_group_scores_file_path = get_highest_provision_group_scores_file_path(
        highest_provision_group_scores_file_directory_path)
    input_output.write(
        highest_provision_group_scores_file_path,
        [
            "Mean: {:.3f}".format(mean),
            "Standard deviation: {:.3f}".format(standard_deviation),
            "Mean + {} * standard deviation: {:.3f}".format(
                score_threshold, mean + score_threshold * standard_deviation),
            '',
            '----------',
            '',
        ])


def write_scores_and_provision_groups(
        highest_provision_group_scores_file_directory_path,
        scores_and_provision_groups):
    highest_provision_group_scores_file_path = get_highest_provision_group_scores_file_path(
        highest_provision_group_scores_file_directory_path)
    for index, score_and_provision_group in enumerate(scores_and_provision_groups):
        if index > 0:
            input_output.append(
                highest_provision_group_scores_file_path, ['\n----------\n'])
        provision_group = sorted(score_and_provision_group[1])
        input_output.append(
            highest_provision_group_scores_file_path,
            [provision[0] for provision in provision_group] +
            ["Scaled average: {:.3f}".format(score_and_provision_group[0])])
        provision_group_contents = []
        for provision in provision_group:
            if len(provision) > 1:
                provision_group_contents += ['', "{}: {}".format(provision[0], provision[1])]
        if len(provision_group_contents) > 0:
            input_output.append(
                highest_provision_group_scores_file_path,
                provision_group_contents)
