import logging
import math

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


class TermFrequency(Algorithm):
    @staticmethod
    def convert_word_list_to_counts(word_list):
        word_counts = {}
        for word in word_list:
            if word in word_counts:
                word_counts[word] += 1
            else:
                word_counts[word] = 1
        return word_counts

    @staticmethod
    def apply(first_string, second_string):
        LOGGER.debug("First string: {}".format(first_string))
        LOGGER.debug("Second string: {}".format(second_string))

        first_word_list = first_string.split(SINGLE_SPACE)
        second_word_list = second_string.split(SINGLE_SPACE)
        # Convert the set to a list to fix the order.
        word_list = list(set(first_word_list).union(set(second_word_list)))
        LOGGER.debug("Word list: {}".format(word_list))

        first_word_counts = TermFrequency.convert_word_list_to_counts(
            first_word_list)
        second_word_counts = TermFrequency.convert_word_list_to_counts(
            second_word_list)

        first_term_frequency_vector = [first_word_counts.get(word, 0) for word in word_list]
        LOGGER.debug("First term frequency vector: {}".format(first_term_frequency_vector))

        second_term_frequency_vector = [second_word_counts.get(word, 0) for word in word_list]
        LOGGER.debug("Second term frequency vector: {}".format(second_term_frequency_vector))

        dot_product = sum([
            first_term_frequency_vector[index] * second_term_frequency_vector[index]
            for index in range(len(word_list))
        ])
        LOGGER.debug("Dot product: {}".format(dot_product))

        first_euclidean_length = math.sqrt(sum([
            frequency ** 2 for frequency in first_term_frequency_vector
        ]))
        LOGGER.debug(
            "Euclidean length of first term frequency vector: {}".format(
                first_euclidean_length))

        second_euclidean_length = math.sqrt(sum([
            frequency ** 2 for frequency in second_term_frequency_vector
        ]))
        LOGGER.debug(
            "Euclidean length of second term frequency vector: {}".format(
                second_euclidean_length))

        cosine = dot_product / first_euclidean_length / second_euclidean_length
        LOGGER.debug(
            "The cosine of the angle between the two term frequency vectors is "
            "equal to the dot product of the two term frequency vectors divided "
            "by the product of the Euclidean length of each vector, or {} / ({} "
            "* {}) = {}".format(
                dot_product, first_euclidean_length, second_euclidean_length,
                cosine))

        return cosine


JACCARD_INDEX = JaccardIndex
TERM_FREQUENCY = TermFrequency


ALGORITHMS = {
    'jaccard_index': JACCARD_INDEX,
    'term_frequency': TERM_FREQUENCY,
}
