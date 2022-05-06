import pytest

import eia.transformations as transformations


def test_file_path_to_state_name_capitalized_strips_leading_path_components_and_language_and_suffix_from_path():
    file_path = '/path/to/state_a_english.txt'
    assert 'State A' == transformations.file_path_to_state_name_capitalized(file_path)


def test_file_path_to_state_name_capitalized_capitalizes_first_letter_in_each_word_and_replaces_underscores():
    file_path = '/path/to/very_long_state_name_english.txt'
    assert 'Very Long State Name' == transformations.file_path_to_state_name_capitalized(file_path)


def test_file_path_to_state_name_capitalized_raises_value_error_if_file_path_does_not_conform_to_expected_format():
    # File name missing extension
    file_path = '/path/to/state_a_english'
    with pytest.raises(ValueError):
        transformations.file_path_to_state_name_capitalized(file_path)
    # File name missing path
    file_path = 'state_a_english.txt'
    with pytest.raises(ValueError):
        transformations.file_path_to_state_name_capitalized(file_path)
    # File name contains uppercase characters
    file_path = '/path/to/State_A_English.txt'
    with pytest.raises(ValueError):
        transformations.file_path_to_state_name_capitalized(file_path)


def test_label_and_row_tuple_to_comma_separated_string_converts_list_containing_integers_to_comma_separated_string():
    label_and_row = ('Test Label', [1, 2, 3])
    expected_string = 'Test Label,1,2,3'
    actual_string = transformations.label_and_row_tuple_to_comma_separated_string(label_and_row)
    assert expected_string == actual_string


def test_label_and_row_tuple_to_comma_separated_string_converts_list_containing_floats_to_comma_separated_string():
    label_and_row = ('Test Label', [0.1, 0.2, 0.3])
    expected_string = 'Test Label,0.10000,0.20000,0.30000'
    actual_string = transformations.label_and_row_tuple_to_comma_separated_string(label_and_row)
    assert expected_string == actual_string


def test_comma_separated_string_to_label_and_row_tuple_converts_string_to_label_and_list_containing_floats():
    comma_separated_string = 'Test Label,0.1,0.2,0.3'
    expected_label_and_row = ('Test Label', [0.1, 0.2, 0.3])
    actual_label_and_row = transformations.comma_separated_string_to_label_and_row_tuple(
        comma_separated_string)
    assert expected_label_and_row == actual_label_and_row


def test_capitalized_string_to_snake_case_converts_capitalized_letters_to_lowercase_and_adds_underscores():
    # No spaces
    capitalized_string = 'TestCapitalizedString'
    expected_string = 'test_capitalized_string'
    actual_string = transformations.capitalized_string_to_snake_case(capitalized_string)
    assert expected_string == actual_string
    # Spaces between words
    capitalized_string = 'Test Capitalized String'
    expected_string = 'test_capitalized_string'
    actual_string = transformations.capitalized_string_to_snake_case(capitalized_string)
    assert expected_string == actual_string


def test_capitalized_string_to_snake_case_raises_value_error_if_string_is_not_capitalized():
    # Snake case string
    string = 'test_capitalized_string'
    with pytest.raises(ValueError):
        transformations.capitalized_string_to_snake_case(string)


def test_snake_case_string_to_capitalized_capitalizes_first_letter_of_each_word_and_removes_underscores():
    snake_case_string = 'test_snake_case_string'
    expected_string = 'Test Snake Case String'
    actual_string = transformations.snake_case_string_to_capitalized(snake_case_string)
    assert expected_string == actual_string


def test_snake_case_string_to_capitalized_raises_value_error_if_string_is_not_snake_case():
    # Capitalized String
    string = 'Test Snake Case String'
    with pytest.raises(ValueError):
        transformations.snake_case_string_to_capitalized(string)
    # Uppercase String
    string = 'TEST SNAKE CASE STRING'
    with pytest.raises(ValueError):
        transformations.snake_case_string_to_capitalized(string)


def test_list_to_occurrences_returns_dict_containing_number_of_occurrences_of_each_item_in_provided_list():
    list_to_transform = ['i', 'like', 'walking', 'the', 'dog', 'while', 'walking', 'the', 'cat']
    expected_occurrences = {
        'i': 1,
        'like': 1,
        'walking': 2,
        'the': 2,
        'dog': 1,
        'while': 1,
        'cat': 1,
    }
    assert expected_occurrences == transformations.list_to_occurrences(list_to_transform)


def test_delete_punctuation_from_string_deletes_all_punctuation_from_provided_string():
    string = 'Test, test; test: test. test-test "Test" , \'test\' ; tes\'t . ' \
        'test : test ? test - test test\\test test/test test \\ test test / test'
    expected_string = 'Test test test test testtest Test  test  tes\'t  test  ' \
        'test  test  test test test test test test   test test   test'
    actual_string = transformations.delete_punctuation_from_string(string)
    assert expected_string == actual_string


def test_delete_punctuation_from_string_preserves_parentheses_and_brackets_around_provision_delimiters():
    string = '(1) [1] Test [2] test [i] test'
    expected_string = '(1) [1] Test [2] test [i] test'
    actual_string = transformations.delete_punctuation_from_string(string)
    assert expected_string == actual_string


def test_delete_punctuation_from_string_deletes_parentheses_not_associated_with_provision_delimiters():
    string = "I like walking to the park (but not when it's raining)"
    expected_string = "I like walking to the park but not when it's raining"
    actual_string = transformations.delete_punctuation_from_string(string)
    assert expected_string == actual_string


def test_delete_punctuation_from_string_preserves_apostrophes():
    string = "It's going to be difficult for the country's population to grow"
    expected_string = "It's going to be difficult for the country's population to grow"
    actual_string = transformations.delete_punctuation_from_string(string)
    assert expected_string == actual_string


def test_delete_provision_delimiters_from_string_deletes_all_provision_delimiters_from_provided_string():
    # Single-digit provision number
    string = '(1) Test [1] test [22] test [a] test [B] test [i] test [V] test [•]'
    expected_string = ' Test  test  test  test  test  test  test '
    actual_string = transformations.delete_provision_delimiters_from_string(string)
    assert expected_string == actual_string

    # Multi-digit provision number
    string = '(99) Test [1] test [22] test [a] test [B] test [i] test [V] test [•]'
    actual_string = transformations.delete_provision_delimiters_from_string(string)
    assert expected_string == actual_string


def test_reduce_whitespace_in_string_to_single_space_between_successive_words_deletes_all_but_single_space():
    string = 'Test  test \ntest \ttest\n\ntest\n\ttest\t\ttest'
    expected_string = 'Test test test test test test test'
    actual_string = transformations.reduce_whitespace_in_string_to_single_space_between_successive_words(string)
    assert expected_string == actual_string


def test_reduce_whitespace_in_string_to_single_space_between_successive_words_deletes_leading_and_trailing_space():
    string = ' \n\tTest  test\t\n '
    expected_string = 'Test test'
    actual_string = transformations.reduce_whitespace_in_string_to_single_space_between_successive_words(string)
    assert expected_string == actual_string


def test_label_to_state_and_provision_identifier_extracts_state_name_and_provision_number_from_label():
    # Single-word state name
    label = 'A'
    actual_label_and_provision = transformations.label_to_state_and_provision_identifier(label)
    assert 'A' == actual_label_and_provision[0]
    assert actual_label_and_provision[1] is None
    # Multi-word state name
    label = 'State A'
    actual_label_and_provision = transformations.label_to_state_and_provision_identifier(label)
    assert 'State A' == actual_label_and_provision[0]
    assert actual_label_and_provision[1] is None
    # Single-word state name and single-digit provision number
    label = 'A 1'
    assert 'A', '1' == transformations.label_to_state_and_provision_identifier(label)
    # Single-word state name and multi-digit provision number
    label = 'A 22'
    assert 'A', '22' == transformations.label_to_state_and_provision_identifier(label)
    # Single-word state name and provision identifier that is not strictly numeric
    label = 'A L-100.1'
    assert 'A', 'L-100.1' == transformations.label_to_state_and_provision_identifier(label)
    label = 'A 1A'
    assert 'A', '1A' == transformations.label_to_state_and_provision_identifier(label)
    label = 'A 11A'
    assert 'A', '11A' == transformations.label_to_state_and_provision_identifier(label)
    # Multi-word state name and single-digit provision number
    label = 'State A 1'
    assert 'State A', '1' == transformations.label_to_state_and_provision_identifier(label)
    # Multi-word state name and multi-digit provision number
    label = 'State A 22'
    assert 'State A', '22' == transformations.label_to_state_and_provision_identifier(label)
    # Multi-word state name and provision identifier that is not strictly numeric
    label = 'State A L-200.2'
    assert 'State A', 'L-200.2' == transformations.label_to_state_and_provision_identifier(label)
    label = 'State A 1A'
    assert 'State A', '1A' == transformations.label_to_state_and_provision_identifier(label)
    label = 'State A 11A'
    assert 'State A', '11A' == transformations.label_to_state_and_provision_identifier(label)


def test_label_to_state_and_provision_identifier_raises_value_error_when_string_does_not_match_expected_format():
    # Provision number without state name
    label = '1'
    with pytest.raises(ValueError):
        transformations.label_to_state_and_provision_identifier(label)


def test_provision_groups_to_nodes_and_edges_converts_list_of_provision_groups_to_lists_of_nodes_and_edges():
    provision_groups = [
        ('A 1', 'B 1'),
        ('A 1', 'B 2'),
        ('A 1', 'C 1'),
        ('A 1', 'C 2'),
        ('A 2', 'B 1'),
        ('A 2', 'B 2'),
        ('A 2', 'C 1'),
        ('A 2', 'C 2'),
        ('B 1', 'C 1'),
        ('B 1', 'C 2'),
        ('B 2', 'C 1'),
        ('B 2', 'C 2'),
        ('A 1', 'B 1', 'C 1'),
        ('A 1', 'B 1', 'C 2'),
        ('A 1', 'B 2', 'C 1'),
        ('A 1', 'B 2', 'C 2'),
        ('A 2', 'B 1', 'C 1'),
        ('A 2', 'B 1', 'C 2'),
        ('A 2', 'B 2', 'C 1'),
        ('A 2', 'B 2', 'C 2'),
    ]
    # The nodes should be states rather than combinations of state and provision
    # identifier.
    expected_nodes = {'A', 'B', 'C'}
    # Each unique provision pair should only be counted once in the weight of
    # the edge between the connected nodes. The list above contains sixteen
    # groups consisting of a total of six provisions. Each provision shares
    # three groups with each of the four provisions from the other two states.
    # For example, provision 'A 1' shares three groups with each of 'B 1',
    # 'B 2', 'C 1' and 'C 2'. The influence of a given provision pair on edge
    # weight, however, is binary: if the provision pair does not feature in any
    # provision groups, then the provision pair does not affect the
    # corresponding edge weight; if the provision pair features in one or more
    # provision groups, then the pair contributes one to the corresponding edge
    # weight. As such, the contribution of the provision pair 'A 1,B 1' to the
    # weight of the edge 'A,B', for example, is only one, even though that
    # provision pair features in three provision groups.
    expected_edges = [
        ('A', 'B', 4),
        ('A', 'C', 4),
        ('B', 'C', 4),
    ]
    actual_nodes, actual_edges = transformations.provision_groups_to_nodes_and_edges(provision_groups)
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_provision_groups_to_nodes_and_edges_produces_undirectional_edges():
    # The following groups strictly adhere to the following provision orders:
    # 'A 1','B 1'
    # 'B 2','A 1'
    # 'A 1','C 1'
    # 'C 2','A 1'
    # 'A 2','B 1'
    # 'B 2','A 2'
    # 'A 2','C 1'
    # 'C 2','A 2'
    # 'B 1','C 1'
    # 'C 2','B 1'
    # 'B 2','C 1'
    # 'C 2','B 2'
    #
    # These groups should be consolidated into edges with nodes ordered
    # according to the first appearance of the nodes in the list of provision
    # groups. For example, the node pair A,B first appears in 'A 1','B 1' so
    # all subsequent groups involving provisions of that node pair should be
    # consolidated into an edge with first node A and second node B, regardless
    # of the order in which those two nodes appear in the provision group. As
    # such, the provision group 'B 2','A 1' should be consolidated into the edge
    # with first node A and second node B, rather than into a new edge with
    # first node B and second node A.
    provision_groups = [
        ('A 1', 'B 1'),
        ('B 2', 'A 1'),
        ('A 1', 'C 1'),
        ('C 2', 'A 1'),
        ('A 2', 'B 1'),
        ('B 2', 'A 2'),
        ('A 2', 'C 1'),
        ('C 2', 'A 2'),
        ('B 1', 'C 1'),
        ('C 2', 'B 1'),
        ('B 2', 'C 1'),
        ('C 2', 'B 2'),
        ('A 1', 'B 1', 'C 1'),
        ('C 2', 'A 1', 'B 1'),
        ('B 2', 'A 1', 'C 1'),
        ('C 2', 'B 2', 'A 1'),
        ('A 2', 'B 1', 'C 1'),
        ('C 2', 'A 2', 'B 1'),
        ('B 2', 'A 2', 'C 1'),
        ('C 2', 'B 2', 'A 2'),
    ]
    expected_nodes = {'A', 'B', 'C'}
    expected_edges = [
        ('A', 'B', 4),
        ('A', 'C', 4),
        ('B', 'C', 4),
    ]
    actual_nodes, actual_edges = transformations.provision_groups_to_nodes_and_edges(provision_groups)
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_provision_groups_to_transitively_deduplicated_nodes_and_edges_only_includes_edges_involving_earliest_state():
    provision_groups = [
        ('A 1', 'B 1', 'C 1'),
        ('A 1', 'B 1', 'C 2'),
        ('A 1', 'B 2', 'C 1'),
        ('A 1', 'B 2', 'C 2'),
        ('A 2', 'B 1', 'C 1'),
        ('A 2', 'B 1', 'C 2'),
        ('A 2', 'B 2', 'C 1'),
        ('A 2', 'B 2', 'C 2'),
    ]
    enactment_years = {
        'A': 1995,
        'B': 2000,
        'C': 2005,
    }
    # The nodes should be states rather than combinations of state and provision
    # identifier.
    expected_nodes = {'A', 'B', 'C'}
    # To begin with, each unique provision pair should only be counted once in
    # the weight of the edge between the connected nodes. Furthermore,
    # transitive deduplication should exclude contributions to edge weights from
    # the constituent provision pairs of a given provision group that do not
    # include the node with the earliest enactment year in the provision group.
    # The list of provision groups above contains eight groups consisting of a
    # total of six provisions. Each of those provision groups contains
    # provisions from all three nodes. As node A's enactment year is the
    # earliest of the three, the only edges to which each provision group should
    # contribute are 'A,B' and 'A,C'. Each of the six provisions shares two
    # groups with each of the four provisions from the other two nodes. As
    # stated above, however, a given provision pair should only be counted in
    # the corresponding edge's weight once, regardless of the number of times
    # that provision pair appears in a provision group. Consequently, the four
    # unique provision pairs involving provisions of A and B should only
    # contribute four to the weight of the 'A,B' edge. The same is true of the
    # four unique provision pairs involving provisions of A and C. The expected
    # edges and weights are thus as follows:
    expected_edges = [
        ('A', 'B', 4),
        ('A', 'C', 4),
    ]
    actual_nodes, actual_edges = \
        transformations.provision_groups_to_transitively_deduplicated_nodes_and_edges(
            provision_groups, enactment_years)
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_provision_groups_to_transitively_deduplicated_nodes_and_edges_includes_earliest_states_when_multiple():
    provision_groups = [
        ('A 1', 'B 1', 'C 1'),
        ('A 1', 'B 1', 'C 2'),
        ('A 1', 'B 2', 'C 1'),
        ('A 1', 'B 2', 'C 2'),
        ('A 2', 'B 1', 'C 1'),
        ('A 2', 'B 1', 'C 2'),
        ('A 2', 'B 2', 'C 1'),
        ('A 2', 'B 2', 'C 2'),
    ]
    enactment_years = {
        'A': 1995,
        'B': 1995,
        'C': 2000,
    }
    # The nodes should be states rather than combinations of state and provision
    # identifier.
    expected_nodes = {'A', 'B', 'C'}
    # To begin with, each unique provision pair should only be counted once in
    # the weight of the edge between the connected nodes. Furthermore,
    # transitive deduplication should exclude contributions to edge weights from
    # the constituent provision pairs of a given provision group that do not
    # include the node with the earliest enactment year in the provision group.
    # When multiple nodes share the earliest enactment year in a provision
    # group, constituent provision pairs involving any of the nodes with the
    # earliest enactment year should contribute to edge weights. The list of
    # provision groups above contains eight groups consisting of a total of six
    # provisions. Each of those provision groups contains provisions from all
    # three nodes. As node A and node B share the earliest enactment year
    # (1995), each provision group should contribute to the 'A,B', 'A,C' and
    # 'B,C' edges. Each of the six provisions shares two groups with each of the
    # four provisions from the other two nodes. As stated above, however, a
    # given provision pair should only be counted in the corresponding edge's
    # weight once, regardless of the number of times that provision pair appears
    # in a provision group. Consequently, the four unique provision pairs
    # involving provisions of A and B should only contribute four to the weight
    # of the 'A,B' edge. The same is true of the four unique provision pairs
    # involving provisions of A and C, and the four unique provision pairs
    # involving provisions of B and C. The expected edges and weights are thus
    # as follows:
    expected_edges = [
        ('A', 'B', 4),
        ('A', 'C', 4),
        ('B', 'C', 4),
    ]
    actual_nodes, actual_edges = \
        transformations.provision_groups_to_transitively_deduplicated_nodes_and_edges(
            provision_groups, enactment_years)
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_provision_groups_to_transitively_deduplicated_nodes_and_edges_produces_undirectional_edges():
    # The following groups strictly adhere to the following provision orders:
    # 'A 1','B 1'
    # 'B 2','A 1'
    # 'A 1','C 1'
    # 'C 2','A 1'
    # 'A 2','B 1'
    # 'B 2','A 2'
    # 'A 2','C 1'
    # 'C 2','A 2'
    # 'B 1','C 1'
    # 'C 2','B 1'
    # 'B 2','C 1'
    # 'C 2','B 2'
    #
    # These groups should be consolidated into edges with nodes ordered
    # according to the first appearance of the nodes in the list of provision
    # groups. For example, the node pair A,B first appears in 'A 1','B 1','C 1'
    # so all subsequent groups involving provisions of that node pair should be
    # consolidated into an edge with first node A and second node B, regardless
    # of the order in which those two nodes appear in the provision group. As
    # such, the provision group 'B 2','A 1','C 1' should be consolidated into
    # the edge with first node A and second node B, rather than into a new edge
    # with first node B and second node A.
    provision_groups = [
        ('A 1', 'B 1', 'C 1'),
        ('C 2', 'A 1', 'B 1'),
        ('B 2', 'A 1', 'C 1'),
        ('C 2', 'B 2', 'A 1'),
        ('A 2', 'B 1', 'C 1'),
        ('C 2', 'A 2', 'B 1'),
        ('B 2', 'A 2', 'C 1'),
        ('C 2', 'B 2', 'A 2'),
    ]
    enactment_years = {
        'A': 1995,
        'B': 2000,
        'C': 2005,
    }
    expected_nodes = {'A', 'B', 'C'}
    expected_edges = [
        ('A', 'B', 4),
        ('A', 'C', 4),
    ]
    actual_nodes, actual_edges = \
        transformations.provision_groups_to_transitively_deduplicated_nodes_and_edges(
            provision_groups, enactment_years)
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges


def test_similarity_matrix_to_nodes_and_edges_consolidates_forward_and_reverse_edges_into_single_edge():
    labels = [
        'State A 1',
        'State A 2',
        'State A 3',
        'State B 1',
        'State B 2',
        'State B 3',
        'State C 1',
        'State C 2',
        'State C 3',
    ]
    matrix = [
        [],
        [0.01],
        [0.02, 0.09],
        [0.03, 0.10, 0.16],
        [0.04, 0.11, 0.17, 0.22],
        [0.05, 0.12, 0.18, 0.23, 0.27],
        [0.06, 0.13, 0.19, 0.24, 0.28, 0.31],
        [0.07, 0.14, 0.20, 0.25, 0.29, 0.32, 0.34],
        [0.08, 0.15, 0.21, 0.26, 0.30, 0.33, 0.35, 0.36],
    ]
    expected_nodes = {'State A', 'State B', 'State C'}
    expected_edges = {
        ('State B', 'State A'): [0.03, 0.10, 0.16, 0.04, 0.11, 0.17, 0.05, 0.12, 0.18],
        ('State C', 'State A'): [0.06, 0.13, 0.19, 0.07, 0.14, 0.20, 0.08, 0.15, 0.21],
        ('State C', 'State B'): [0.24, 0.28, 0.31, 0.25, 0.29, 0.32, 0.26, 0.30, 0.33],
    }
    actual_nodes, actual_edges = transformations.similarity_matrix_to_nodes_and_edges(labels, matrix)
    assert expected_nodes == actual_nodes
    assert expected_edges == actual_edges
