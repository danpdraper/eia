SINGLE_SPACE = ' '


class Algorithm(object):
    @staticmethod
    def apply(first_string, second_string):
        raise NotImplementedError('Subclasses must override this method.')


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
