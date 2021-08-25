import eia.application as application


def test_is_same_state_labels_without_provision_returns_true_when_states_same():
    first_label = 'State A'
    second_label = 'State A'
    assert application.is_same_state(first_label, second_label) is True


def test_is_same_state_labels_without_provision_returns_false_when_states_not_same():
    first_label = 'State A'
    second_label = 'State B'
    assert application.is_same_state(first_label, second_label) is False


def test_is_same_state_labels_with_provision_returns_true_when_states_same():
    first_label = 'State A 1'
    second_label = 'State A 2'
    assert application.is_same_state(first_label, second_label) is True


def test_is_same_state_labels_with_provision_returns_false_when_states_not_same():
    first_label = 'State A 1'
    second_label = 'State B 1'
    assert application.is_same_state(first_label, second_label) is False


def test_calculate_scaled_average_returns_the_mean_similarity_score_multiplied_by_the_group_scaling_factor():
    provision_group = [0, 2, 4, 6]
    provision_pairs = [(0, 2), (0, 4), (0, 6), (2, 4), (2, 6), (4, 6)]
    matrix = [
        [],
        [0.01],
        [0.02, 0.03],
        [0.04, 0.05, 0.06],
        [0.07, 0.08, 0.09, 0.1],
        [0.11, 0.12, 0.13, 0.14, 0.15],
        [0.16, 0.17, 0.18, 0.19, 0.2, 0.21],
        [0.22, 0.23, 0.24, 0.25, 0.26, 0.27, 0.28],
    ]
    # The expected mean is the mean of the provision pair similarity scores,
    # i.e. mean(0.02, 0.07, 0.16, 0.09, 0.18, 0.2) = 0.12. The expected group
    # scaling factor is the number of provisions in the group minus one, i.e. 4
    # - 1 = 3. The expected scaled average is thus 0.12 * 3 = 0.36. Note that
    # the function must be able to swap provision pair coordinates to
    # accommodate the dimensions of the matrix.
    epsilon = 0.00001
    expected_scaled_average = 0.36
    actual_scaled_average = application.calculate_scaled_average(
        provision_group, provision_pairs, matrix)
    assert abs(expected_scaled_average - actual_scaled_average) < epsilon
    # Swapped provision pair coordinates
    provision_pairs = [(2, 0), (4, 0), (6, 0), (4, 2), (6, 2), (6, 4)]
    actual_scaled_average = application.calculate_scaled_average(
        provision_group, provision_pairs, matrix)
    assert abs(expected_scaled_average - actual_scaled_average) < epsilon
