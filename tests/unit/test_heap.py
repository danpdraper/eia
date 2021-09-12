import unittest.mock as mock

import pytest

import eia.heap as heap


class TestSetHeapElement(object):
    def test_issubset_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().issubset(heap.SetHeapElement())

    def test_issuperset_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().issuperset(heap.SetHeapElement())

    def test_intersection_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().intersection(heap.SetHeapElement())

    def test_intersects_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().intersects(heap.SetHeapElement())

    def test_has_common_states_but_different_provisions_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().has_common_states_but_different_provisions(
                heap.SetHeapElement())

    def test_has_same_provisions_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().has_same_provisions(heap.SetHeapElement())

    def test_union_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().union(heap.SetHeapElement())

    def test_add_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().add(heap.SetHeapElement())

    def test_copy_raises_not_implemented_error(self):
        with pytest.raises(NotImplementedError):
            heap.SetHeapElement().copy()


class TestProvisionGroupHeapElement(object):
    def setup(self):
        self.heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 1'})

    def test_issubset_returns_true_when_provisions_subset_of_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 1', 'C 1'})
        assert self.heap_element.issubset(other_heap_element) is True

    def test_issubset_returns_false_when_provisions_not_subset_of_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'C 1'})
        assert self.heap_element.issubset(other_heap_element) is False

    def test_issubset_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element.issubset(mock.Mock())

    def test_issuperset_returns_true_when_provisions_superset_of_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', })
        assert self.heap_element.issuperset(other_heap_element) is True

    def test_issuperset_returns_false_when_provisions_not_superset_of_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'C 1', })
        assert self.heap_element.issuperset(other_heap_element) is False

    def test_issuperset_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element.issuperset(mock.Mock())

    def test_intersection_returns_intersection_of_provisions_and_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'C 1'})
        assert {'A 1'} == self.heap_element.intersection(other_heap_element)

    def test_intersection_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element.intersection(mock.Mock())

    def test_intersects_returns_true_when_provisions_intersect_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'C 1'})
        assert self.heap_element.intersects(other_heap_element) is True

    def test_intersects_returns_false_when_provisions_do_not_intersect_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'C 1', 'D 1'})
        assert self.heap_element.intersects(other_heap_element) is False

    def test_intersects_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element.intersects(mock.Mock())

    def test_has_common_states_but_different_provisions_returns_true_when_common_states_but_different_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 2'})
        assert self.heap_element.has_common_states_but_different_provisions(
            other_heap_element) is True

    def test_has_common_states_but_different_provisions_returns_false_when_common_states_and_same_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 1'})
        assert self.heap_element.has_common_states_but_different_provisions(
            other_heap_element) is False

    def test_has_common_states_but_different_provisions_returns_false_when_no_common_states(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'C 1', 'D 1'})
        assert self.heap_element.has_common_states_but_different_provisions(
            other_heap_element) is False

    def test_has_common_states_but_different_provisions_raises_type_error_when_argument_not_expected_type(self):
        with pytest.raises(TypeError):
            self.heap_element.has_common_states_but_different_provisions(mock.Mock())

    def test_has_same_provisions_returns_true_when_provisions_are_same_as_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 1'})
        assert self.heap_element.has_same_provisions(other_heap_element) is True

    def test_has_same_provisions_returns_false_when_provisions_are_not_same_as_other_element_provisions(self):
        # Different provisions
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'C 1', 'D 1'})
        assert self.heap_element.has_same_provisions(other_heap_element) is False
        # Intersection
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'C 1'})
        assert self.heap_element.has_same_provisions(other_heap_element) is False
        # Superset
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 1', 'C 1'})
        assert self.heap_element.has_same_provisions(other_heap_element) is False

    def test_has_same_provisions_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element.has_same_provisions(mock.Mock())

    def test_union_returns_union_of_provisions_and_other_element_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'C 1'})
        assert {'A 1', 'B 1', 'C 1'} == self.heap_element.union(other_heap_element)

    def test_union_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element.union(mock.Mock())

    def test_add_returns_new_element_with_adjusted_average_and_combined_pair_count_and_combined_provisions(self):
        other_heap_element = heap.ProvisionGroupHeapElement(1, 3, {'A 1', 'C 1', 'D 1', 'E 1'})
        new_element = self.heap_element.add(other_heap_element)
        assert 3 == new_element.scaled_average
        assert 4 == new_element.number_of_pairs
        assert {'A 1', 'B 1', 'C 1', 'D 1', 'E 1'} == new_element.provisions
        # Verify that attributes of self.heap_element were not modified
        assert 2 == self.heap_element.scaled_average
        assert 1 == self.heap_element.number_of_pairs
        assert {'A 1', 'B 1'} == self.heap_element.provisions

    def test_add_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element.add(mock.Mock())

    def test_copy_returns_instance_with_same_attributes_as_original(self):
        copy_heap_element = self.heap_element.copy()
        assert 2 == copy_heap_element.scaled_average
        assert 1 == copy_heap_element.number_of_pairs
        assert {'A 1', 'B 1'} == copy_heap_element.provisions

    def test_gt_returns_true_when_scaled_average_greater_than_other_scaled_average(self):
        other_heap_element = heap.ProvisionGroupHeapElement(0, 1, {'A 1', 'B 1'})
        assert self.heap_element > other_heap_element

    def test_gt_returns_false_when_scaled_average_less_than_or_equal_to_other_scaled_average(self):
        # Equal
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 1'})
        assert not self.heap_element > other_heap_element
        # Less than
        other_heap_element = heap.ProvisionGroupHeapElement(3, 1, {'A 1', 'B 1'})
        assert not self.heap_element > other_heap_element

    def test_gt_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element > mock.Mock()

    def test_lt_returns_true_when_scaled_average_less_than_other_scaled_average(self):
        other_heap_element = heap.ProvisionGroupHeapElement(3, 1, {'A 1', 'B 1'})
        assert self.heap_element < other_heap_element

    def test_lt_returns_false_when_scaled_average_greater_than_or_equal_to_other_scaled_average(self):
        # Equal
        other_heap_element = heap.ProvisionGroupHeapElement(1, 1, {'A 1', 'B 1'})
        assert not self.heap_element < other_heap_element
        # Less than
        other_heap_element = heap.ProvisionGroupHeapElement(0, 1, {'A 1', 'B 1'})
        assert not self.heap_element < other_heap_element

    def test_lt_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element < mock.Mock()

    def test_le_returns_true_when_scaled_average_less_than_or_equal_to_other_scaled_average(self):
        # Equal
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 1'})
        assert self.heap_element <= other_heap_element
        # Less than
        other_heap_element = heap.ProvisionGroupHeapElement(3, 1, {'A 1', 'B 1'})
        assert self.heap_element <= other_heap_element

    def test_le_returns_false_when_scaled_average_greater_than_other_scaled_average(self):
        other_heap_element = heap.ProvisionGroupHeapElement(0, 1, {'A 1', 'B 1'})
        assert not self.heap_element <= other_heap_element

    def test_le_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element <= mock.Mock()

    def test_str_returns_string_representation_of_object(self):
        expected_string = "{scaled_average: 2, number_of_pairs: 1, provisions: ['A 1', 'B 1']}"
        assert expected_string == str(self.heap_element)

    def test_repr_returns_string_representation_of_object(self):
        expected_string = "{scaled_average: 2, number_of_pairs: 1, provisions: ['A 1', 'B 1']}"
        assert expected_string == repr(self.heap_element)

    def test_eq_returns_true_when_all_attributes_are_equal(self):
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'B 1'})
        assert self.heap_element == other_heap_element

    def test_eq_returns_false_when_all_attributes_are_not_equal(self):
        # Scaled average
        other_heap_element = heap.ProvisionGroupHeapElement(1, 1, {'A 1', 'B 1'})
        assert not self.heap_element == other_heap_element
        # Number of pairs
        other_heap_element = heap.ProvisionGroupHeapElement(2, 0, {'A 1', 'B 1'})
        assert not self.heap_element == other_heap_element
        # Provisions
        other_heap_element = heap.ProvisionGroupHeapElement(2, 1, {'A 1', 'C 1'})
        assert not self.heap_element == other_heap_element

    def test_eq_raises_type_error_when_argument_not_provision_group_heap_element(self):
        with pytest.raises(TypeError):
            self.heap_element == mock.Mock()

    def test_hash_returns_hash_of_string_representation_of_object(self):
        expected_hash = hash(
            "{scaled_average: 2, number_of_pairs: 1, provisions: ['A 1', 'B 1']}")
        assert expected_hash == hash(self.heap_element)


class TestSetBoundedMinHeap(object):
    def setup(self):
        self.heap_size = 5
        self.min_heap = heap.SetBoundedMinHeap(self.heap_size)

    def new_element(self, *args):
        return heap.ProvisionGroupHeapElement(*args)

    def test_push_adds_item_to_heap_and_moves_smallest_element_to_top_of_heap(self):
        self.min_heap.push(self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}))
        self.min_heap.push(self.new_element(3, 2, {'D 1', 'E 1', 'F 1'}))
        self.min_heap.push(self.new_element(5, 2, {'G 1', 'H 1', 'I 1'}))
        assert self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}) == self.min_heap.heap[0]

    def test_push_discards_smallest_item_in_heap_when_min_heap_size_exceeded(self):
        self.min_heap.push(self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}))
        self.min_heap.push(self.new_element(3, 2, {'D 1', 'E 1', 'F 1'}))
        self.min_heap.push(self.new_element(5, 2, {'G 1', 'H 1', 'I 1'}))
        self.min_heap.push(self.new_element(7, 2, {'J 1', 'K 1', 'L 1'}))
        self.min_heap.push(self.new_element(9, 2, {'M 1', 'N 1', 'O 1'}))
        # The next push will exceed the min heap size and the element's value is
        # larger than the smallest element value in the heap, so the element
        # with the smallest value (i.e. (1, 2, {'A 1', 'B 1', 'C 1'}) with value
        # 1) should be removed from the heap.
        self.min_heap.push(self.new_element(11, 2, {'P 1', 'Q 1', 'R 1'}))
        expected_heap = [
            self.new_element(3, 2, {'D 1', 'E 1', 'F 1'}),
            self.new_element(5, 2, {'G 1', 'H 1', 'I 1'}),
            self.new_element(7, 2, {'J 1', 'K 1', 'L 1'}),
            self.new_element(9, 2, {'M 1', 'N 1', 'O 1'}),
            self.new_element(11, 2, {'P 1', 'Q 1', 'R 1'}),
        ]
        assert expected_heap == sorted(self.min_heap.heap)

    def test_push_discards_pushed_element_when_min_heap_size_exceeded_and_pushed_element_smallest(self):
        self.min_heap.push(self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}))
        self.min_heap.push(self.new_element(3, 2, {'D 1', 'E 1', 'F 1'}))
        self.min_heap.push(self.new_element(5, 2, {'G 1', 'H 1', 'I 1'}))
        self.min_heap.push(self.new_element(7, 2, {'J 1', 'K 1', 'L 1'}))
        self.min_heap.push(self.new_element(9, 2, {'M 1', 'N 1', 'O 1'}))
        # The next push will exceed the min heap size and the element's value is
        # smaller than the smallest element value in the heap, so the heap
        # should not be altered.
        self.min_heap.push(self.new_element(0, 2, {'P 1', 'Q 1', 'R 1'}))
        expected_heap = [
            self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}),
            self.new_element(3, 2, {'D 1', 'E 1', 'F 1'}),
            self.new_element(5, 2, {'G 1', 'H 1', 'I 1'}),
            self.new_element(7, 2, {'J 1', 'K 1', 'L 1'}),
            self.new_element(9, 2, {'M 1', 'N 1', 'O 1'}),
        ]
        assert expected_heap == sorted(self.min_heap.heap)

    def test_to_list_returns_copy_of_list_underlying_heap(self):
        self.min_heap.push(self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}))
        self.min_heap.push(self.new_element(3, 2, {'D 1', 'E 1', 'F 1'}))
        self.min_heap.push(self.new_element(5, 2, {'G 1', 'H 1', 'I 1'}))
        expected_list = [
            self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}),
            self.new_element(3, 2, {'D 1', 'E 1', 'F 1'}),
            self.new_element(5, 2, {'G 1', 'H 1', 'I 1'}),
        ]
        copy_of_heap_list = sorted(self.min_heap.to_list())
        assert expected_list == copy_of_heap_list
        # Verify that pushing a new element does not result in an alteration of
        # the previously-returned list.
        self.min_heap.push(self.new_element(7, 2, {'J 1', 'K 1', 'L 1'}))
        assert expected_list == copy_of_heap_list

    def test_consolidate_deletes_redundant_subsets_and_supersets_and_consolidates_intersections(self):
        min_heap = heap.SetBoundedMinHeap(20)
        min_heap.push(self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}))
        min_heap.push(self.new_element(1, 2, {'A 1', 'B 2', 'C 2'}))
        min_heap.push(self.new_element(1, 2, {'A 1', 'B 3', 'C 3'}))
        min_heap.push(self.new_element(3, 2, {'D 1', 'E 1', 'F 1', 'G 1'}))

        # Superset of D 1,E 1,F 1,G 1 with lower score
        min_heap.push(self.new_element(2, 3, {'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}))
        # Superset of D 1,E 1,F 1,G 1,H 1 with lower score
        min_heap.push(self.new_element(1, 3, {'D 1', 'E 1', 'F 1', 'G 1', 'H 1', 'I 1'}))
        # Superset of A 1,B 1,C 1 with equal score
        min_heap.push(self.new_element(1, 3, {'A 1', 'B 1', 'C 1', 'D 1'}))
        # Superset of A 1,B 1,C 1,D 1 with higher score
        min_heap.push(self.new_element(2, 4, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1'}))
        # Superset of A 1,B 1,C 1,D 1,E 1 with higher score
        min_heap.push(self.new_element(3, 5, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1'}))

        # Subset of D 1,E 1,F 1,G 1 with lower score
        min_heap.push(self.new_element(2, 2, {'D 1', 'E 1', 'F 1'}))
        # Subset of D 1,E 1,F 1 with lower score
        min_heap.push(self.new_element(1, 1, {'D 1', 'E 1'}))
        # Subset of D 1,E 1,F 1,G 1 with equal score
        min_heap.push(self.new_element(3, 2, {'E 1', 'F 1', 'G 1'}))
        # Subset of D 1,E 1,F 1,G 1 with higher score
        min_heap.push(self.new_element(4, 2, {'D 1', 'F 1', 'G 1'}))
        # Subset of D 1,F 1,G 1 with higher score
        min_heap.push(self.new_element(5, 1, {'F 1', 'G 1'}))

        # Intersections with common states and same provisions
        min_heap.push(self.new_element(7, 2, {'A 1', 'G 1', 'H 1'}))
        min_heap.push(self.new_element(9, 1, {'G 1', 'I 1'}))
        min_heap.push(self.new_element(9, 1, {'G 1', 'I 2'}))
        # Intersections with common states but different provision in one case
        min_heap.push(self.new_element(7, 2, {'A 1', 'G 2', 'H 1'}))
        min_heap.push(self.new_element(7, 2, {'A 2', 'G 1', 'H 1'}))

        '''
        After deleting redundant subsets and supersets, the following elements
        should remain:

        1, 2, {'A 1', 'B 2', 'C 2'}
        1, 2, {'A 1', 'B 3', 'C 3'}
        3, 5, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1'}
        5, 1, {'F 1', 'G 1'}
        7, 2, {'A 1', 'G 1', 'H 1'}
        7, 2, {'A 1', 'G 2', 'H 1'}
        7, 2, {'A 2', 'G 1', 'H 1'}
        9, 1, {'G 1', 'I 1'}
        9, 1, {'G 1', 'I 2'}

        The first round of intersection consolidation should produce the
        following new elements:

        8, 4, {'A 1', 'B 2', 'C 2', 'G 1', 'H 1'}
        8, 4, {'A 1', 'B 2', 'C 2', 'G 2', 'H 1'}
        8, 4, {'A 1', 'B 3', 'C 3', 'G 1', 'H 1'}
        8, 4, {'A 1', 'B 3', 'C 3', 'G 2', 'H 1'}
        8, 6, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1'}
        10, 7, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}
        10, 7, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 2', 'H 1'}
        12, 3, {'A 1', 'F 1', 'G 1', 'H 1'}
        12, 3, {'A 2', 'F 1', 'G 1', 'H 1'}
        14, 2, {'F 1', 'G 1', 'I 1'}
        14, 2, {'F 1', 'G 1', 'I 2'}
        16, 3, {'A 1', 'G 1', 'H 1', 'I 1'}
        16, 3, {'A 1', 'G 1', 'H 1', 'I 2'}
        16, 3, {'A 2', 'G 1', 'H 1', 'I 1'}
        16, 3, {'A 2', 'G 1', 'H 1', 'I 2'}

        The first round of intersection consolidation should mark the following
        elements for deletion:

        1, 2, {'A 1', 'B 2', 'C 2'}
        1, 2, {'A 1', 'B 3', 'C 3'}
        3, 5, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1'}
        5, 1, {'F 1', 'G 1'}
        7, 2, {'A 1', 'G 1', 'H 1'}
        7, 2, {'A 1', 'G 2', 'H 1'}
        7, 2, {'A 2', 'G 1', 'H 1'}
        9, 1, {'G 1', 'I 1'}
        9, 1, {'G 1', 'I 2'}

        The second round of intersection consolidation should produce the
        following new elements:

        100 / 7, 7, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1'}
        132 / 6, 6, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        132 / 6, 6, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        120 / 7, 7, {'A 1', 'B 2', 'C 2', 'G 1', 'H 1', 'I 1'}
        120 / 7, 7, {'A 1', 'B 2', 'C 2', 'G 1', 'H 1', 'I 2'}
        100 / 7, 7, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1'}
        132 / 6, 6, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        132 / 6, 6, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        120 / 7, 7, {'A 1', 'B 3', 'C 3', 'G 1', 'H 1', 'I 1'}
        120 / 7, 7, {'A 1', 'B 3', 'C 3', 'G 1', 'H 1', 'I 2'}
        126 / 13, 13, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}
        140 / 9, 9, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}
        154 / 8, 8, {'A 1' 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'I 1'}
        154 / 8, 8, {'A 1' 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'I 2'}
        192 / 9, 9, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        192 / 9, 9, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        154 / 10, 10, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}
        192 / 9, 9, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        192 / 9, 9, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        208 / 10, 10, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H
        1', 'I 1'}
        208 / 10, 10, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H
        1', 'I 2'}
        104 / 5, 5, {'A 1', 'F 1', 'G 1', 'H 1', 'I 1'}
        104 / 5, 5, {'A 1', 'F 1', 'G 1', 'H 1', 'I 2'}
        112 / 6, 6, {'A 1', 'F 1', 'G 1', 'H 1', 'I 1'}
        112 / 6, 6, {'A 1', 'F 1', 'G 1', 'H 1', 'I 2'}
        104 / 5, 5, {'A 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        104 / 5, 5, {'A 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        112 / 6, 6, {'A 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        112 / 6, 6, {'A 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        120 / 5, 5, {'A 1', 'F 1', 'G 1', 'H 1', 'I 1'}
        120 / 5, 5, {'A 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        120 / 5, 5, {'A 1', 'F 1', 'G 1', 'H 1', 'I 2'}
        120 / 5, 5, {'A 2', 'F 1', 'G 1', 'H 1', 'I 2'}

        These elements should be deduplicated to produce:

        420 / 32, 32, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}
        154 / 8, 8, {'A 1' 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'I 1'}
        154 / 8, 8, {'A 1' 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'I 2'}
        400 / 19, 19, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        400 / 19, 19, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        100 / 7, 7, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1'}
        132 / 6, 6, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        132 / 6, 6, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        120 / 7, 7, {'A 1', 'B 2', 'C 2', 'G 1', 'H 1', 'I 1'}
        120 / 7, 7, {'A 1', 'B 2', 'C 2', 'G 1', 'H 1', 'I 2'}
        100 / 7, 7, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1'}
        132 / 6, 6, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        132 / 6, 6, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        120 / 7, 7, {'A 1', 'B 3', 'C 3', 'G 1', 'H 1', 'I 1'}
        120 / 7, 7, {'A 1', 'B 3', 'C 3', 'G 1', 'H 1', 'I 2'}
        336 / 16, 16, {'A 1', 'F 1', 'G 1', 'H 1', 'I 1'}
        336 / 16, 16, {'A 1', 'F 1', 'G 1', 'H 1', 'I 2'}
        336 / 16, 16, {'A 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        336 / 16, 16, {'A 2', 'F 1', 'G 1', 'H 1', 'I 2'}

        The second round of intersection consolidation should mark the following
        elements for deletion:

        8, 4, {'A 1', 'B 2', 'C 2', 'G 1', 'H 1'}
        8, 4, {'A 1', 'B 3', 'C 3', 'G 1', 'H 1'}
        8, 6, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1'}
        10, 7, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}
        12, 3, {'A 1', 'F 1', 'G 1', 'H 1'}
        12, 3, {'A 2', 'F 1', 'G 1', 'H 1'}
        14, 2, {'F 1', 'G 1', 'I 1'}
        14, 2, {'F 1', 'G 1', 'I 2'}
        16, 3, {'A 1', 'G 1', 'H 1', 'I 1'}
        16, 3, {'A 1', 'G 1', 'H 1', 'I 2'}
        16, 3, {'A 2', 'G 1', 'H 1', 'I 1'}
        16, 3, {'A 2', 'G 1', 'H 1', 'I 2'}

        The third round of intersection consolidation should produce the
        following new elements:

        656 / 40, 40, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        656 / 40, 40, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        880 / 51, 51, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        880 / 51, 51, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        1152 / 48, 48, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        1152 / 48, 48, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        576 / 27, 27, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        848 / 24, 24, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        576 / 27, 27, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        848 / 24, 24, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        1072 / 35, 35, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        1072 / 35, 35, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        252 / 13, 13, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        252 / 13, 13, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        264 / 14, 14, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        264 / 14, 14, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        624 / 23, 23, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        624 / 23, 23, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        276 / 13, 13, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        636 / 22, 22, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        276 / 13, 13, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        636 / 22, 22, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        648 / 23, 23, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        648 / 23, 23, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        252 / 13, 13, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        252 / 13, 13, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        264 / 14, 14, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        264 / 14, 14, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        624 / 23, 23, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        624 / 23, 23, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        276 / 13, 13, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        636 / 22, 22, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        276 / 13, 13, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        636 / 22, 22, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        648 / 23, 23, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        648 / 23, 23, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}

        These elements should be deduplicated to produce:

        5184 / 225, 225, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H
        1', 'I 1'}
        5184 / 225, 225, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H
        1', 'I 2'}
        2700 / 108, 108, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        2700 / 108, 108, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        2700 / 108, 108, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        2700 / 108, 108, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}

        The third round of intersection consolidation should mark the following
        elements for deletion:

        420 / 32, 32, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}
        154 / 8, 8, {'A 1' 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'I 1'}
        154 / 8, 8, {'A 1' 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'I 2'}
        400 / 19, 19, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 1'}
        400 / 19, 19, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1',
        'I 2'}
        100 / 7, 7, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1'}
        132 / 6, 6, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        132 / 6, 6, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        120 / 7, 7, {'A 1', 'B 2', 'C 2', 'G 1', 'H 1', 'I 1'}
        120 / 7, 7, {'A 1', 'B 2', 'C 2', 'G 1', 'H 1', 'I 2'}
        100 / 7, 7, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1'}
        132 / 6, 6, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        132 / 6, 6, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        120 / 7, 7, {'A 1', 'B 3', 'C 3', 'G 1', 'H 1', 'I 1'}
        120 / 7, 7, {'A 1', 'B 3', 'C 3', 'G 1', 'H 1', 'I 2'}
        336 / 16, 16, {'A 1', 'F 1', 'G 1', 'H 1', 'I 1'}
        336 / 16, 16, {'A 1', 'F 1', 'G 1', 'H 1', 'I 2'}

        The fourth round of intersection consolidation should not produce any
        new elements. Combining the remaining (post-deletion) initial elements
        and the remaining new elements from the four rounds of intersection
        consolidation yields the following:

        8, 4, {'A 1', 'B 2', 'C 2', 'G 2', 'H 1'}
        8, 4, {'A 1', 'B 3', 'C 3', 'G 2', 'H 1'}
        10, 7, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 2', 'H 1'}
        21, 16, {'A 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        21, 16, {'A 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        5184 / 225, 225, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H
        1', 'I 1'}
        5184 / 225, 225, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H
        1', 'I 2'}
        25, 108, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}
        25, 108, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}
        25, 108, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}
        25, 108, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}
        '''

        expected_heap = [
            self.new_element(1, 1, {'D 1', 'E 1'}),
            self.new_element(1, 2, {'A 1', 'B 1', 'C 1'}),
            self.new_element(1, 2, {'A 1', 'B 2', 'C 2'}),
            self.new_element(1, 2, {'A 1', 'B 3', 'C 3'}),
            self.new_element(1, 3, {'A 1', 'B 1', 'C 1', 'D 1'}),
            self.new_element(1, 3, {'D 1', 'E 1', 'F 1', 'G 1', 'H 1', 'I 1'}),
            self.new_element(2, 2, {'D 1', 'E 1', 'F 1'}),
            self.new_element(2, 3, {'D 1', 'E 1', 'F 1', 'G 1', 'H 1'}),
            self.new_element(2, 4, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1'}),
            self.new_element(3, 2, {'D 1', 'E 1', 'F 1', 'G 1'}),
            self.new_element(3, 2, {'E 1', 'F 1', 'G 1'}),
            self.new_element(3, 5, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1'}),
            self.new_element(4, 2, {'D 1', 'F 1', 'G 1'}),
            self.new_element(5, 1, {'F 1', 'G 1'}),
            self.new_element(7, 2, {'A 1', 'G 1', 'H 1'}),
            self.new_element(7, 2, {'A 1', 'G 2', 'H 1'}),
            self.new_element(7, 2, {'A 2', 'G 1', 'H 1'}),
            self.new_element(9, 1, {'G 1', 'I 1'}),
            self.new_element(9, 1, {'G 1', 'I 2'}),
        ]

        assert expected_heap == sorted(min_heap.heap, key=lambda element: str(element))

        min_heap.consolidate()

        expected_heap = [
            self.new_element(10, 7, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 2', 'H 1'}),
            self.new_element(21, 16, {'A 2', 'F 1', 'G 1', 'H 1', 'I 1'}),
            self.new_element(21, 16, {'A 2', 'F 1', 'G 1', 'H 1', 'I 2'}),
            self.new_element(5184 / 225, 225, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1', 'I 1'}),
            self.new_element(5184 / 225, 225, {'A 1', 'B 1', 'C 1', 'D 1', 'E 1', 'F 1', 'G 1', 'H 1', 'I 2'}),
            self.new_element(25, 108, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 1'}),
            self.new_element(25, 108, {'A 1', 'B 2', 'C 2', 'F 1', 'G 1', 'H 1', 'I 2'}),
            self.new_element(25, 108, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 1'}),
            self.new_element(25, 108, {'A 1', 'B 3', 'C 3', 'F 1', 'G 1', 'H 1', 'I 2'}),
            self.new_element(8, 4, {'A 1', 'B 2', 'C 2', 'G 2', 'H 1'}),
            self.new_element(8, 4, {'A 1', 'B 3', 'C 3', 'G 2', 'H 1'}),
        ]

        assert expected_heap == sorted(min_heap.heap, key=lambda element: str(element))
