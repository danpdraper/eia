import logging

import eia.transformations as transformations


LOGGER = logging.getLogger(__name__)


SINGLE_SPACE = ' '


class Algorithm(object):
    @staticmethod
    def apply(first_string, second_string):
        raise NotImplementedError('Subclasses must override this method.')

    @classmethod
    def to_string(cls):
        return transformations.capitalized_string_to_snake_case(cls.__name__)


class JaccardIndex(Algorithm):
    @staticmethod
    def apply(first_string, second_string):
        LOGGER.debug("First string: {}".format(first_string))
        LOGGER.debug("Second string: {}".format(second_string))

        first_word_set = set(first_string.split(SINGLE_SPACE))
        LOGGER.debug("First word set: {}".format(first_word_set))
        LOGGER.debug(
            "The first word set contains {} words.".format(len(first_word_set)))

        second_word_set = set(second_string.split(SINGLE_SPACE))
        LOGGER.debug("Second word set: {}".format(second_word_set))
        LOGGER.debug(
            "The second word set contains {} words.".format(len(second_word_set)))

        intersection = first_word_set.intersection(second_word_set)
        LOGGER.debug(
            "The intersection of the first word set and the second word set "
            "contains {} words.".format(len(intersection)))

        union = first_word_set.union(second_word_set)
        LOGGER.debug(
            "The union of the first word set and the second word set contains "
            "{} words.".format(len(union)))

        jaccard_index = len(intersection) / len(union)
        LOGGER.debug(
            "The Jaccard index is equal to |intersection| / |union| = {} / {} "
            "= {}".format(len(intersection), len(union), jaccard_index))

        return jaccard_index


JACCARD_INDEX = JaccardIndex


ALGORITHMS = {
    'jaccard_index': JACCARD_INDEX,
}
