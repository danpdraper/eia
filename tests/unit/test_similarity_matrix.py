import pytest

import eia.similarity_matrix as similarity_matrix


def test_generator_yields_comma_separated_lines_consisting_of_label_followed_by_matrix_row():
    labels = ['State A', 'State B', 'State C']
    values = [
        [1, 2, 3],
        [4, 5, 6],
        [7, 8, 9],
    ]
    generator = similarity_matrix.generator(labels, values)
    assert ['State A', 1, 2, 3] == next(generator)
    assert ['State B', 4, 5, 6] == next(generator)
    assert ['State C', 7, 8, 9] == next(generator)
    with pytest.raises(StopIteration):
        next(generator)


def test_generator_raises_value_error_if_labels_contains_less_or_more_elements_than_values_contains_rows():
    labels = ['State A', 'State B', 'State C']
    # values contains less rows than labels contains elements
    values = [
        [1, 2],
        [3, 4],
    ]
    with pytest.raises(ValueError):
        next(similarity_matrix.generator(labels, values))
    # values contains more rows than labels contains elements
    values = [
        [1, 2, 3, 4],
        [5, 6, 7, 8],
        [9, 10, 11, 12],
        [13, 14, 15, 16],
    ]
    with pytest.raises(ValueError):
        next(similarity_matrix.generator(labels, values))


def test_generator_raises_value_error_if_values_is_not_square():
    labels = ['State A', 'State B', 'State C']
    # values contains less rows than columns
    values = [
        [1, 2, 3],
        [4, 5, 6],
    ]
    with pytest.raises(ValueError):
        next(similarity_matrix.generator(labels, values))
    # values contains more rows than columns
    values = [
        [1, 2],
        [3, 4],
        [5, 6],
    ]
    with pytest.raises(ValueError):
        next(similarity_matrix.generator(labels, values))
