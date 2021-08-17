import re


COMMA = ','
STATE_AND_PROVISION_LABEL_REGEX = re.compile(r'^([A-Za-z ]+)( [0-9]+)?$')


def contains_comma(string):
    return COMMA in string


def state_and_provision_number_from_label(label):
    match = STATE_AND_PROVISION_LABEL_REGEX.match(label)
    if not match:
        raise ValueError(
            "Label {} does not consist of a state name and optional provision "
            "number.".format(label))
    return match.group(1), match.group(2).lstrip(' ') if match.group(2) else match.group(2)
