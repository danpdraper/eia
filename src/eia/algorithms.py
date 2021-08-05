import eia.conversion as conversion


SINGLE_SPACE = ' '


class Algorithm(object):
    @staticmethod
    def apply(first_string, second_string):
        raise NotImplementedError('Subclasses must override this method.')

    @classmethod
    def to_string(cls):
        return conversion.capitalized_string_to_snake_case(cls.__name__)


class JaccardIndex(Algorithm):
    @staticmethod
    def apply(first_string, second_string):
        first_word_set = set(first_string.split(SINGLE_SPACE))
        second_word_set = set(second_string.split(SINGLE_SPACE))
        intersection = first_word_set.intersection(second_word_set)
        union = first_word_set.union(second_word_set)
        return len(intersection) / len(union)


JACCARD_INDEX = JaccardIndex


ALGORITHMS = {
    'jaccard_index': JACCARD_INDEX,
}
