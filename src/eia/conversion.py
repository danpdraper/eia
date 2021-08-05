import re


CAPITALIZED_REGEX = re.compile(r'(^|[a-z])([A-Z])')
COMMA_SEPARATOR = ','
EMPTY_STRING = ''
LEADING_AND_TRAILING_WHITESPACE_REGEX = re.compile(r'^[ \n\t]+|[ \n\t]+$')
PUNCTUATION_REGEX = re.compile(r'[,;:.?\-"\']')
SINGLE_SPACE = ' '
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
    return COMMA_SEPARATOR.join(
        map(lambda value: str(value) if type(value) in [int, float] else value,
            [label_and_row[0]] + label_and_row[1]))


def capitalized_string_to_snake_case(capitalized_string):
    match = CAPITALIZED_REGEX.search(capitalized_string)
    if not match:
        raise ValueError("String {} is not capitalized.".format(capitalized_string))
    return re.sub(
        CAPITALIZED_REGEX, lambda match: r"{}{}{}".format(
            match.group(1), EMPTY_STRING if match.group(1) == EMPTY_STRING else UNDERSCORE,
            match.group(2).lower()),
        capitalized_string)


def delete_all_punctuation_from_string(string):
    return re.sub(PUNCTUATION_REGEX, EMPTY_STRING, string)


def reduce_whitespace_in_string_to_single_space_between_successive_words(string):
    return re.sub(
        LEADING_AND_TRAILING_WHITESPACE_REGEX, EMPTY_STRING,
        re.sub(WHITESPACE_REGEX, SINGLE_SPACE, string))
