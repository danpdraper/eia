import math

import pytest

import eia.algorithms as algorithms


EPSILON = 0.00001


class TestAlgorithm(object):
    def test_apply_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            algorithms.Algorithm.apply('first_string', 'second_string')


class TestJaccardIndex(object):
    def test_apply_returns_quotient_of_intersection_and_union(self):
        first_string = 'I love walking in the park'
        second_string = 'My dog also loves walking in the park'
        # Intersection = (walking, in, the, park)
        # Union = (I, love, walking, in, the, park, My, dog, also, loves)
        # The intersection contains four words and the union contains ten words.
        # The Jaccard index should thus be 4 / 10 = 0.4.
        expected_jaccard_index = 0.4
        actual_jaccard_index = algorithms.JACCARD_INDEX.apply(
            first_string, second_string)
        assert abs(expected_jaccard_index - actual_jaccard_index) < EPSILON

    def test_to_string_returns_class_name_in_snake_case(self):
        assert 'jaccard_index' == algorithms.JaccardIndex.to_string()


class TestTermFrequency(object):
    def test_apply_returns_cosine_of_angle_between_term_vectors(self):
        first_string = 'I love walking in the park with the dog'
        second_string = 'My dog also loves walking in the park'
        # Union = (also, dog, I, in, love, loves, My, park, the, walking, with)
        # First string term frequency vector = [0, 1, 1, 1, 1, 0, 0, 1, 2, 1, 1]
        # Second string term frequency vector = [1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0]
        #
        # cosine(theta) = (TF1•TF2)/(|TF1||TF2|) where TF1•TF2 is the dot
        # product of TF1 and TF2, and |TFn| is the Euclidean length of TFn.
        #
        # Dot product = sum([i * j for i in TF1, j in TF2])
        # Dot product = sum([0 * 1, 1 * 1, 1 * 0, 1 * 1, 1 * 0, 0 * 1, 0 * 1,
        #                    1 * 1, 2 * 1, 1 * 1, 1 * 0])
        # Dot product = sum([0, 1, 0, 1, 0, 0, 0, 1, 2, 1, 0]) = 6
        #
        # Euclidean length = sqrt(sum([i ^ 2 for i in TFn]))
        # TF1 Euclidean length = sqrt(sum([0 ^ 2, 1 ^ 2, 1 ^ 2, 1 ^ 2, 1 ^ 2,
        #                                  0 ^ 2, 0 ^ 2, 1 ^ 2, 2 ^ 2, 1 ^ 2,
        #                                  1 ^ 2]))
        # TF1 Euclidean length = sqrt(sum([0, 1, 1, 1, 1, 0, 0, 1, 4, 1, 1]))
        # TF1 Euclidean length = sqrt(11)
        # TF2 Euclidean length = sqrt(sum([1 ^ 2, 1 ^ 2, 0 ^ 2, 1 ^ 2, 0 ^ 2,
        #                                  1 ^ 2, 1 ^ 2, 1 ^ 2, 1 ^ 2, 1 ^ 2,
        #                                  0 ^ 2]))
        # TF2 Euclidean length = sqrt(sum([1, 1, 0, 1, 0, 1, 1, 1, 1, 1, 0]))
        # TF2 Euclidean length = sqrt(8)
        #
        # cosine(theta) = 6 / (sqrt(11) * sqrt(8)) ~= 0.640
        expected_cosine = 6 / math.sqrt(11) / math.sqrt(8)
        actual_cosine = algorithms.TERM_FREQUENCY.apply(
            first_string, second_string)
        assert abs(expected_cosine - actual_cosine) < EPSILON
