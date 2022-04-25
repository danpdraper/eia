import logging
import re


LOGGER = logging.getLogger(__name__)


CAPITALIZED_REGEX = re.compile(r'(^|[a-z]| )([A-Z])')
COMMA = ','
EMPTY_STRING = ''
LEADING_AND_TRAILING_WHITESPACE_REGEX = re.compile(r'^[ \n\t]+|[ \n\t]+$')
PARENTHESES_REGEX = re.compile(r'\(|\)')
PROVISION_DELIMITER_REGEX = re.compile(
    r'(^)\([0-9]+\)|(\n)\([0-9]+\)|(.)\[[A-Za-z0-9]+\]|(.)\[•\]')
PUNCTUATION_REGEX = re.compile(r'[,;:.?\-"]| \'|\' ')
SINGLE_SPACE = ' '
SLASH_REGEX = re.compile(r'\\|/')
SNAKE_CASE_REGEX = re.compile(r'(^|_)([a-z])')
STATE_AND_PROVISION_LABEL_REGEX = re.compile(r'^([A-Za-z ]+)( [0-9L\.-]+)?$')
STATE_NAME_SNAKE_CASE_REGEX = re.compile(r'/([a-z_]+)_[a-z]+\.')
TO_CAPITALIZED_REGEX = re.compile(r'(^|_)([a-z])')
UNDERSCORE = '_'
WHITESPACE_REGEX = re.compile(r'[ \n\t]+')


def file_path_to_state_name_capitalized(file_path):
    match = STATE_NAME_SNAKE_CASE_REGEX.search(file_path)
    if not match:
        raise ValueError(
            "File path {} does not conform to expectation of leading path, "
            "trailing extension and snakecase file name.".format(file_path))
    state_name_snake_case = match.group(1)
    return re.sub(
        TO_CAPITALIZED_REGEX,
        lambda match: r"{}{}".format(
            SINGLE_SPACE if match.group(1) == UNDERSCORE else EMPTY_STRING,
            match.group(2).upper()),
        state_name_snake_case)


def label_and_row_tuple_to_comma_separated_string(label_and_row):
    return COMMA.join(map(
        lambda value: "{:.5f}".format(value) if type(value) is float else str(value),
        [label_and_row[0]] + label_and_row[1]))


def comma_separated_string_to_label_and_row_tuple(comma_separated_string):
    string_components = comma_separated_string.split(COMMA)
    return string_components[0], [float(value) for value in string_components[1:]]


def capitalized_string_to_snake_case(capitalized_string):
    match = CAPITALIZED_REGEX.search(capitalized_string)
    if not match:
        raise ValueError("String {} is not capitalized.".format(capitalized_string))
    return re.sub(
        CAPITALIZED_REGEX,
        lambda match: r"{}{}{}".format(
            EMPTY_STRING if match.group(1) == SINGLE_SPACE else match.group(1),
            EMPTY_STRING if match.group(1) == EMPTY_STRING else UNDERSCORE,
            match.group(2).lower()),
        capitalized_string)


def snake_case_string_to_capitalized(snake_case_string):
    match = SNAKE_CASE_REGEX.search(snake_case_string)
    if not match:
        raise ValueError("String {} is not snake case.".format(snake_case_string))
    return re.sub(
        SNAKE_CASE_REGEX,
        lambda match: r"{}{}".format(
            EMPTY_STRING if match.group(1) == EMPTY_STRING else SINGLE_SPACE,
            match.group(2).upper()),
        snake_case_string)


def list_to_occurrences(list_to_transform):
    occurrences = {}
    for item in list_to_transform:
        if item in occurrences:
            occurrences[item] += 1
        else:
            occurrences[item] = 1
    return occurrences


def is_parenthesis_part_of_provision_delimiter(
        provision_delimiter_character_ranges, parenthesis_match):
    LOGGER.debug(
        "Checking whether parenthesis at {} is in one of the following "
        "character ranges: {}.".format(
            parenthesis_match.start(),
            COMMA.join(
                "{}-{}".format(character_range[0], character_range[-1])
                for character_range in provision_delimiter_character_ranges)))
    return len(list(filter(
        lambda character_range: parenthesis_match.start() in character_range,
        provision_delimiter_character_ranges))) > 0


def delete_punctuation_from_string(string):
    string = re.sub(
        SLASH_REGEX, SINGLE_SPACE,
        re.sub(
            PUNCTUATION_REGEX,
            lambda match: SINGLE_SPACE if len(match.group(0)) == 2 else EMPTY_STRING,
            string))

    provision_delimiter_character_ranges = [
        range(match.start(), match.start() + len(match.group()))
        for match in PROVISION_DELIMITER_REGEX.finditer(string)]
    LOGGER.debug(
        "Identified the following provision delimiters and associated "
        "character ranges: {}.".format(
            COMMA.join(
                map(
                    lambda character_range: str((
                        ''.join(string[character_range[0]:character_range[-1] + 1]),
                        character_range[0],
                        character_range[-1],
                    )),
                    provision_delimiter_character_ranges))))

    return re.sub(
        PARENTHESES_REGEX,
        lambda match: match.group() if is_parenthesis_part_of_provision_delimiter(
            provision_delimiter_character_ranges, match) else EMPTY_STRING,
        string)


def delete_provision_delimiters_from_string(string):
    return re.sub(
        PROVISION_DELIMITER_REGEX,
        lambda match: next(
            filter(
                lambda group: group is not None,
                [
                    match.group(1),
                    match.group(2),
                    match.group(3),
                    match.group(4),
                ])),
        string)


def reduce_whitespace_in_string_to_single_space_between_successive_words(string):
    return re.sub(
        LEADING_AND_TRAILING_WHITESPACE_REGEX, EMPTY_STRING,
        re.sub(WHITESPACE_REGEX, SINGLE_SPACE, string))


def label_to_state_and_provision_identifier(label):
    match = STATE_AND_PROVISION_LABEL_REGEX.match(label)
    if not match:
        raise ValueError(
            "Label {} does not consist of a state name and optional provision "
            "number.".format(label))
    return match.group(1), match.group(2).lstrip(' ') if match.group(2) else match.group(2)


def get_earliest_enactment_states(provision_group, enactment_years):
    earliest_enactment_year = -1
    earliest_enactment_states = set()
    for provision in provision_group:
        state = label_to_state_and_provision_identifier(provision)[0]
        if earliest_enactment_year == -1 or enactment_years[state] < earliest_enactment_year:
            earliest_enactment_year = enactment_years[state]
            earliest_enactment_states = {state}
        elif enactment_years[state] == earliest_enactment_year:
            earliest_enactment_states.add(state)
    return earliest_enactment_states


def provision_groups_to_nodes_and_edges(provision_groups, enactment_years=None):
    nodes = set()
    edges = {}
    for provision_group in provision_groups:
        LOGGER.debug("Processing provision group {}.".format(provision_group))
        earliest_enactment_states = None
        if enactment_years:
            earliest_enactment_states = get_earliest_enactment_states(
                provision_group, enactment_years)
            LOGGER.debug("Earliest enactment state(s): {}.".format(earliest_enactment_states))
        for anchor_index, anchor_provision in enumerate(provision_group):
            anchor_state, anchor_provision_identifier = \
                label_to_state_and_provision_identifier(anchor_provision)
            nodes.add(anchor_state)
            for floating_provision in provision_group[anchor_index + 1:]:
                floating_state, floating_provision_identifier = \
                    label_to_state_and_provision_identifier(floating_provision)
                if earliest_enactment_states:
                    if anchor_state not in earliest_enactment_states and \
                            floating_state not in earliest_enactment_states:
                        LOGGER.debug(
                            "Excluding contribution of provision pair {},{} to "
                            "edge {}-{} because neither state is in {}.".format(
                                anchor_provision, floating_provision,
                                anchor_state, floating_state,
                                earliest_enactment_states))
                        continue
                nodes.add(floating_state)
                forward_state_pair = (anchor_state, floating_state)
                reverse_state_pair = (floating_state, anchor_state)
                forward_provision_identifier_pair = \
                    (anchor_provision_identifier, floating_provision_identifier)
                reverse_provision_identifier_pair = \
                    (floating_provision_identifier, anchor_provision_identifier)
                if forward_state_pair not in edges and reverse_state_pair not in edges:
                    state_pair = forward_state_pair
                    edges[state_pair] = set()
                    provision_identifier_pair = forward_provision_identifier_pair
                elif forward_state_pair not in edges:
                    state_pair = reverse_state_pair
                    provision_identifier_pair = reverse_provision_identifier_pair
                else:
                    state_pair = forward_state_pair
                    provision_identifier_pair = forward_provision_identifier_pair
                LOGGER.debug(
                    "Adding provision identifier pair {} to edge {}.".format(
                        provision_identifier_pair, state_pair))
                edges[state_pair].add(provision_identifier_pair)
    return nodes, [
        (state_pair[0], state_pair[1], len(provision_identifier_pairs))
        for state_pair, provision_identifier_pairs in edges.items()
    ]


def provision_groups_to_transitively_deduplicated_nodes_and_edges(
        provision_groups, enactment_years):
    return provision_groups_to_nodes_and_edges(provision_groups, enactment_years)
