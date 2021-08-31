import eia.application as application


def test_calculate_mean_and_standard_deviation_only_incorporates_unique_interstate_elements():
    '''
    Similarity matrix:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [ 1.00 0.02 0.03 0.04 0.05 0.06 ]
        [ A 2 ] [ 0.02 1.00 0.09 0.10 0.11 0.12 ]
        [ B 1 ] [ 0.03 0.09 1.00 0.16 0.17 0.18 ]
        [ B 2 ] [ 0.04 0.10 0.16 1.00 0.23 0.24 ]
        [ C 1 ] [ 0.05 0.11 0.17 0.23 1.00 0.30 ]
        [ C 2 ] [ 0.06 0.12 0.18 0.24 0.30 1.00 ]

    Removing intra-state similarity scores and duplicates leaves:
                [ A 1  A 2  B 1  B 2  C 1  C 2  ]
        [ A 1 ] [                               ]
        [ A 2 ] [                               ]
        [ B 1 ] [ 0.03 0.09                     ]
        [ B 2 ] [ 0.04 0.10                     ]
        [ C 1 ] [ 0.05 0.11 0.17 0.23           ]
        [ C 2 ] [ 0.06 0.12 0.18 0.24           ]

    Mean = (0.03 + 0.09 + 0.04 + 0.10 + 0.05 + 0.11 + 0.17 + 0.23 + 0.06 + 0.12
            + 0.18 + 0.24) / 12
    Mean ~= 0.118

    Standard deviation = sqrt(((0.03 - 0.118) ^ 2 + (0.09 - 0.118) ^ 2 +
                               (0.04 - 0.118) ^ 2 + (0.10 - 0.118) ^ 2 +
                               (0.05 - 0.118) ^ 2 + (0.11 - 0.118) ^ 2 +
                               (0.17 - 0.118) ^ 2 + (0.23 - 0.118) ^ 2 +
                               (0.06 - 0.118) ^ 2 + (0.12 - 0.118) ^ 2 +
                               (0.18 - 0.118) ^ 2 + (0.24 - 0.118) ^ 2) / 12)
    Standard deviation ~= sqrt(0.057 / 12) ~= 0.069
    '''

    labels = [
        'State A 1',
        'State A 2',
        'State B 1',
        'State B 2',
        'State C 1',
        'State C 2',
    ]
    matrix = [
        [1.00, 0.02, 0.03, 0.04, 0.05, 0.06],
        [0.02, 1.00, 0.09, 0.10, 0.11, 0.12],
        [0.03, 0.09, 1.00, 0.16, 0.17, 0.18],
        [0.04, 0.10, 0.16, 1.00, 0.23, 0.24],
        [0.05, 0.11, 0.17, 0.23, 1.00, 0.30],
        [0.06, 0.12, 0.18, 0.24, 0.30, 1.00],
    ]

    epsilon = 0.0005
    expected_mean, expected_standard_deviation = 0.118, 0.069
    actual_mean, actual_standard_deviation = \
        application.calculate_mean_and_standard_deviation(labels, matrix)
    assert abs(expected_mean - actual_mean) < epsilon
    assert abs(expected_standard_deviation - actual_standard_deviation) < epsilon


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
    provision_pairs = [(1, 2), (1, 4), (1, 6), (1, 8)]
    row = [0.01, 1.00, 0.03, 0.04, 0.05, 0.06, 0.07, 0.08, 0.09]
    provisions_in_group = [2, 4, 6, 8]
    # The expected mean is the mean of the provision pair similarity scores,
    # i.e. mean(0.03, 0.05, 0.07, 0.09) = 0.06. The expected group scaling
    # factor is the number of provisions in the group minus one, i.e. 4 - 1 = 3.
    # The expected scaled average is thus 0.06 * 3 = 0.18.
    epsilon = 0.00001
    expected_scaled_average = 0.18
    actual_scaled_average = application.calculate_scaled_average(
        provision_pairs, row, provisions_in_group)
    assert abs(expected_scaled_average - actual_scaled_average) < epsilon
