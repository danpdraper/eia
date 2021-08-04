import eia.algorithms as algorithms


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
        epsilon = 0.00001
        assert abs(expected_jaccard_index - actual_jaccard_index) < epsilon
