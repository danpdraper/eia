import re


CAPITALIZED_REGEX = re.compile(r'(^|[a-z])([A-Z])')
COMMA_SEPARATOR = ','
STATE_NAME_SNAKE_CASE_REGEX = re.compile(r'/([a-z_]+)_[a-z]+\.')
TO_CAPITALIZED_REGEX = re.compile(r'(^|_)([a-z])')


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
            ' ' if match.group(1) == '_' else '',
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
            match.group(1), '' if match.group(1) == '' else '_',
            match.group(2).lower()),
        capitalized_string)
