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


def generate_frequency_vector(occurrences, all_items):
    return [occurrences.get(item, 0) for item in all_items]


def calculate_dot_product(first_vector, second_vector):
    if len(first_vector) != len(second_vector):
        raise ValueError(
            "The two vector arguments must be of equal length. First vector: "
            "{}, second vector: {}.".format(first_vector, second_vector))
    return sum([
        first_vector[index] * second_vector[index] for index in range(len(first_vector))
    ])


def calculate_euclidean_length(vector):
    return math.sqrt(sum([item ** 2 for item in vector]))


class BigramFrequency(Algorithm):
    @staticmethod
    def generate_bigrams(string):
        words = string.split(SINGLE_SPACE)
        bigrams = []
        for index, _ in enumerate(words):
            if index == len(words) - 1:
                continue
            bigrams.append((words[index], words[index + 1]))
        return bigrams

    @staticmethod
    def apply(first_string, second_string):
        LOGGER.debug("First string: {}".format(first_string))
        LOGGER.debug("Second string: {}".format(second_string))

        first_string_bigram_list = BigramFrequency.generate_bigrams(first_string)
        second_string_bigram_list = BigramFrequency.generate_bigrams(second_string)
        # Convert the set to a list to fix the order.
        bigram_list = list(set(first_string_bigram_list + second_string_bigram_list))
        LOGGER.debug("Bigram list: {}".format(bigram_list))

        first_string_bigram_occurrences = transformations.list_to_occurrences(
            first_string_bigram_list)
        second_string_bigram_occurrences = transformations.list_to_occurrences(
            second_string_bigram_list)

        first_string_bigram_frequency_vector = generate_frequency_vector(
            first_string_bigram_occurrences, bigram_list)
        LOGGER.debug(
            "First string bigram frequency vector: {}".format(
                first_string_bigram_frequency_vector))

        second_string_bigram_frequency_vector = generate_frequency_vector(
            second_string_bigram_occurrences, bigram_list)
        LOGGER.debug(
            "Second string bigram frequency vector: {}".format(
                second_string_bigram_frequency_vector))

        dot_product = calculate_dot_product(
            first_string_bigram_frequency_vector,
            second_string_bigram_frequency_vector)
        LOGGER.debug("Dot product: {}".format(dot_product))

        first_string_bigram_frequency_vector_euclidean_length = \
            calculate_euclidean_length(first_string_bigram_frequency_vector)
        LOGGER.debug(
            "Euclidean length of first string bigram frequency vector: {}".format(
                first_string_bigram_frequency_vector_euclidean_length))

        second_string_bigram_frequency_vector_euclidean_length = \
            calculate_euclidean_length(second_string_bigram_frequency_vector)
        LOGGER.debug(
            "Euclidean length of second string bigram frequency vector: {}".format(
                second_string_bigram_frequency_vector_euclidean_length))

        cosine = dot_product / \
            first_string_bigram_frequency_vector_euclidean_length / \
            second_string_bigram_frequency_vector_euclidean_length
        LOGGER.debug(
            "The cosine of the angle between the two bigram frequency vectors is "
            "equal to the dot product of the two bigram frequency vectors divided "
            "by the product of the Euclidean length of each vector, or {} / ({} "
            "* {}) = {}".format(
                dot_product,
                first_string_bigram_frequency_vector_euclidean_length,
                second_string_bigram_frequency_vector_euclidean_length, cosine))

        return cosine


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
    def apply(first_string, second_string):
        LOGGER.debug("First string: {}".format(first_string))
        LOGGER.debug("Second string: {}".format(second_string))

        first_string_word_list = first_string.split(SINGLE_SPACE)
        second_string_word_list = second_string.split(SINGLE_SPACE)
        # Convert the set to a list to fix the order.
        word_list = list(set(first_string_word_list + second_string_word_list))
        LOGGER.debug("Word list: {}".format(word_list))

        first_string_word_occurrences = transformations.list_to_occurrences(
            first_string_word_list)
        second_string_word_occurrences = transformations.list_to_occurrences(
            second_string_word_list)

        first_string_term_frequency_vector = generate_frequency_vector(
            first_string_word_occurrences, word_list)
        LOGGER.debug(
            "First string term frequency vector: {}".format(
                first_string_term_frequency_vector))

        second_string_term_frequency_vector = generate_frequency_vector(
            second_string_word_occurrences, word_list)
        LOGGER.debug(
            "Second string term frequency vector: {}".format(
                second_string_term_frequency_vector))

        dot_product = calculate_dot_product(
            first_string_term_frequency_vector,
            second_string_term_frequency_vector)
        LOGGER.debug("Dot product: {}".format(dot_product))

        first_string_term_frequency_vector_euclidean_length = \
            calculate_euclidean_length(first_string_term_frequency_vector)
        LOGGER.debug(
            "Euclidean length of first string term frequency vector: {}".format(
                first_string_term_frequency_vector_euclidean_length))

        second_string_term_frequency_vector_euclidean_length = \
            calculate_euclidean_length(second_string_term_frequency_vector)
        LOGGER.debug(
            "Euclidean length of second string term frequency vector: {}".format(
                second_string_term_frequency_vector_euclidean_length))

        cosine = dot_product / \
            first_string_term_frequency_vector_euclidean_length / \
            second_string_term_frequency_vector_euclidean_length
        LOGGER.debug(
            "The cosine of the angle between the two term frequency vectors is "
            "equal to the dot product of the two term frequency vectors divided "
            "by the product of the Euclidean length of each vector, or {} / ({} "
            "* {}) = {}".format(
                dot_product,
                first_string_term_frequency_vector_euclidean_length,
                second_string_term_frequency_vector_euclidean_length, cosine))

        return cosine


BIGRAM_FREQUENCY = BigramFrequency
JACCARD_INDEX = JaccardIndex
TERM_FREQUENCY = TermFrequency


ALGORITHMS = {
    'bigram_frequency': BIGRAM_FREQUENCY,
    'jaccard_index': JACCARD_INDEX,
    'term_frequency': TERM_FREQUENCY,
}
