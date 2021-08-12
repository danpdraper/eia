import eia.plots as plots


def test_trim_data_for_full_text_trims_and_masks_all_but_lower_triangle_elements():
    data = [
        [1, 2, 3, 4, 5],
        [6, 7, 8, 9, 10],
        [11, 12, 13, 14, 15],
        [16, 17, 18, 19, 20],
        [21, 22, 23, 24, 25],
    ]
    row_labels = [
        'State A',
        'State B',
        'State C',
        'State D',
        'State E',
    ]
    column_labels = [
        'State A',
        'State B',
        'State C',
        'State D',
        'State E',
    ]
    expected_trimmed_data = [
        [6, -1, -1, -1],
        [11, 12, -1, -1],
        [16, 17, 18, -1],
        [21, 22, 23, 24],
    ]
    expected_mask = [
        [False, True, True, True],
        [False, False, True, True],
        [False, False, False, True],
        [False, False, False, False],
    ]
    expected_trimmed_row_labels = [
        'State B',
        'State C',
        'State D',
        'State E',
    ]
    expected_trimmed_column_labels = [
        'State A',
        'State B',
        'State C',
        'State D',
    ]
    actual_masked_trimmed_data, actual_trimmed_row_labels, actual_trimmed_column_labels = \
        plots.trim_data_for_full_text(data, row_labels, column_labels)
    assert expected_trimmed_data == actual_masked_trimmed_data.data.tolist()
    assert expected_mask == actual_masked_trimmed_data.mask.tolist()
    assert expected_trimmed_row_labels == actual_trimmed_row_labels
    assert expected_trimmed_column_labels == actual_trimmed_column_labels


def test_trim_data_for_provisions_trims_and_masks_all_but_lower_triangle_inter_state_elements():
    data = [
        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10],
        [11, 12, 13, 14, 15, 16, 17, 18, 19, 20],
        [21, 22, 23, 24, 25, 26, 27, 28, 29, 30],
        [31, 32, 33, 34, 35, 36, 37, 38, 39, 40],
        [41, 42, 43, 44, 45, 46, 47, 48, 49, 50],
        [51, 52, 53, 54, 55, 56, 57, 58, 59, 60],
        [61, 62, 63, 64, 65, 66, 67, 68, 69, 70],
        [71, 72, 73, 74, 75, 76, 77, 78, 79, 80],
        [81, 82, 83, 84, 85, 86, 87, 88, 89, 90],
        [91, 92, 93, 94, 95, 96, 97, 98, 99, 100],
    ]
    row_labels = [
        'State A 1',
        'State A 2',
        'State B 1',
        'State B 2',
        'State C 1',
        'State C 2',
        'State D 1',
        'State D 2',
        'State E 1',
        'State E 2',
    ]
    column_labels = [
        'State A 1',
        'State A 2',
        'State B 1',
        'State B 2',
        'State C 1',
        'State C 2',
        'State D 1',
        'State D 2',
        'State E 1',
        'State E 2',
    ]
    expected_trimmed_data = [
        [21, 22, -1, -1, -1, -1, -1, -1],
        [31, 32, -1, -1, -1, -1, -1, -1],
        [41, 42, 43, 44, -1, -1, -1, -1],
        [51, 52, 53, 54, -1, -1, -1, -1],
        [61, 62, 63, 64, 65, 66, -1, -1],
        [71, 72, 73, 74, 75, 76, -1, -1],
        [81, 82, 83, 84, 85, 86, 87, 88],
        [91, 92, 93, 94, 95, 96, 97, 98],
    ]
    expected_mask = [
        [False, False, True, True, True, True, True, True],
        [False, False, True, True, True, True, True, True],
        [False, False, False, False, True, True, True, True],
        [False, False, False, False, True, True, True, True],
        [False, False, False, False, False, False, True, True],
        [False, False, False, False, False, False, True, True],
        [False, False, False, False, False, False, False, False],
        [False, False, False, False, False, False, False, False],
    ]
    expected_trimmed_row_labels = [
        'State B 1',
        'State B 2',
        'State C 1',
        'State C 2',
        'State D 1',
        'State D 2',
        'State E 1',
        'State E 2',
    ]
    expected_trimmed_column_labels = [
        'State A 1',
        'State A 2',
        'State B 1',
        'State B 2',
        'State C 1',
        'State C 2',
        'State D 1',
        'State D 2',
    ]
    actual_masked_trimmed_data, actual_trimmed_row_labels, actual_trimmed_column_labels = \
        plots.trim_data_for_provisions(data, row_labels, column_labels)
    assert expected_trimmed_data == actual_masked_trimmed_data.data.tolist()
    assert expected_mask == actual_masked_trimmed_data.mask.tolist()
    assert expected_trimmed_row_labels == actual_trimmed_row_labels
    assert expected_trimmed_column_labels == actual_trimmed_column_labels
