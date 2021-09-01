import eia.heap as heap


class TestBoundedMinHeap(object):
    def setup(self):
        self.heap_size = 5

    def test_push_adds_item_to_heap_and_moves_smallest_element_to_top_of_heap(self):
        min_heap = heap.BoundedMinHeap(self.heap_size)
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {3, 5, 7}))
        min_heap.push((5, {4, 6, 8}))
        assert (1, {2, 4, 6}) == min_heap.heap[0]

    def test_push_discards_smallest_item_in_heap_when_min_heap_size_exceeded(self):
        min_heap = heap.BoundedMinHeap(self.heap_size)
        for value in range(self.heap_size):
            min_heap.push((value, {value * 2, value * 3}))
        # The next push will exceed the min heap size and the element's value is
        # larger than the smallest element value in the heap, so the element
        # with the smallest value (i.e. (0, {0, 0}) with value 0) should be
        # removed from the heap.
        min_heap.push((5, {10, 15}))
        expected_heap = [
            (1, {2, 3}),
            (2, {4, 6}),
            (3, {6, 9}),
            (4, {8, 12}),
            (5, {10, 15}),
        ]
        assert expected_heap == sorted(min_heap.heap)

    def test_push_discards_pushed_element_when_min_heap_size_exceeded_and_pushed_element_smallest(self):
        min_heap = heap.BoundedMinHeap(self.heap_size)
        for value in range(self.heap_size):
            min_heap.push((value, {value * 2, value * 3}))
        # The next push will exceed the min heap size and the element's value is
        # smaller than the smallest element value in the heap, so the heap
        # should not be altered.
        min_heap.push((-1, {-2, -3}))
        expected_heap = [
            (0, {0, 0}),
            (1, {2, 3}),
            (2, {4, 6}),
            (3, {6, 9}),
            (4, {8, 12}),
        ]
        assert expected_heap == sorted(min_heap.heap)

    def test_push_subsets_and_supersets_when_min_heap_size_not_exceeded(self):
        # Pushed data subset of existing data
        min_heap = heap.BoundedMinHeap(self.heap_size, reduce_element_data_redundancy=True)
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {3, 5, 7}))
        min_heap.push((5, {4, 6, 8}))

        # Smaller value
        min_heap.push((0, {4, 6}))
        expected_heap = [
            (1, {2, 4, 6}),
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Equal value
        min_heap.push((1, {2, 4}))
        assert expected_heap == sorted(min_heap.heap)

        # Both smaller and equal value
        min_heap.push((1, {4, 6}))
        assert expected_heap == sorted(min_heap.heap)

        # Both smaller and larger value
        min_heap.push((3, {4, 6}))
        assert expected_heap == sorted(min_heap.heap)

        # Both equal and larger value
        min_heap.push((5, {4, 6}))
        assert expected_heap == sorted(min_heap.heap)

        # Larger value
        min_heap.push((6, {4, 6}))
        expected_heap = [
            (3, {3, 5, 7}),
            (6, {4, 6}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Pushed data superset of existing data
        min_heap = heap.BoundedMinHeap(self.heap_size, reduce_element_data_redundancy=True)
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {3, 5, 7}))
        min_heap.push((5, {4, 6, 8}))

        # Smaller value
        min_heap.push((0, {2, 4, 6, 8}))
        expected_heap = [
            (1, {2, 4, 6}),
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Equal value
        min_heap.push((1, {0, 2, 4, 6}))
        expected_heap = [
            (1, {0, 2, 4, 6}),
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Both smaller and equal value
        min_heap.push((1, {0, 2, 4, 6, 8}))
        expected_heap = [
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Both smaller and larger value
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {2, 4, 6, 8}))
        expected_heap = [
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Both equal and larger value
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((5, {2, 4, 6, 8}))
        expected_heap = [
            (3, {3, 5, 7}),
            (5, {2, 4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Larger value
        min_heap = heap.BoundedMinHeap(self.heap_size, reduce_element_data_redundancy=True)
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {3, 5, 7}))
        min_heap.push((5, {4, 6, 8}))
        min_heap.push((6, {2, 4, 6, 8}))
        expected_heap = [
            (3, {3, 5, 7}),
            (6, {2, 4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

    def test_push_subsets_and_supersets_when_min_heap_size_exceeded(self):
        # Pushed data subset of existing data
        min_heap = heap.BoundedMinHeap(3, reduce_element_data_redundancy=True)
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {3, 5, 7}))
        min_heap.push((5, {4, 6, 8}))

        # Smaller value
        min_heap.push((0, {4, 6}))
        expected_heap = [
            (1, {2, 4, 6}),
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Equal value
        min_heap.push((1, {2, 4}))
        assert expected_heap == sorted(min_heap.heap)

        # Both smaller and equal value
        min_heap.push((1, {4, 6}))
        assert expected_heap == sorted(min_heap.heap)

        # Both smaller and larger value
        min_heap.push((3, {4, 6}))
        assert expected_heap == sorted(min_heap.heap)

        # Both equal and larger value
        min_heap.push((5, {4, 6}))
        assert expected_heap == sorted(min_heap.heap)

        # Larger value
        min_heap.push((6, {4, 6}))
        expected_heap = [
            (3, {3, 5, 7}),
            (6, {4, 6}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Pushed data superset of existing data
        min_heap = heap.BoundedMinHeap(3, reduce_element_data_redundancy=True)
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {3, 5, 7}))
        min_heap.push((5, {4, 6, 8}))

        # Smaller value
        min_heap.push((0, {2, 4, 6, 8}))
        expected_heap = [
            (1, {2, 4, 6}),
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Equal value
        min_heap.push((1, {0, 2, 4, 6}))
        expected_heap = [
            (1, {0, 2, 4, 6}),
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Both smaller and equal value
        min_heap.push((1, {0, 2, 4, 6, 8}))
        expected_heap = [
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Both smaller and larger value
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {2, 4, 6, 8}))
        expected_heap = [
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Both equal and larger value
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((5, {2, 4, 6, 8}))
        expected_heap = [
            (3, {3, 5, 7}),
            (5, {2, 4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

        # Larger value
        min_heap = heap.BoundedMinHeap(3, reduce_element_data_redundancy=True)
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {3, 5, 7}))
        min_heap.push((5, {4, 6, 8}))
        min_heap.push((6, {2, 4, 6, 8}))
        expected_heap = [
            (3, {3, 5, 7}),
            (6, {2, 4, 6, 8}),
        ]
        assert expected_heap == sorted(min_heap.heap)

    def test_to_list_returns_copy_of_list_underlying_heap(self):
        min_heap = heap.BoundedMinHeap(self.heap_size)
        min_heap.push((1, {2, 4, 6}))
        min_heap.push((3, {3, 5, 7}))
        min_heap.push((5, {4, 6, 8}))
        expected_list = [
            (1, {2, 4, 6}),
            (3, {3, 5, 7}),
            (5, {4, 6, 8}),
        ]
        copy_of_heap_list = sorted(min_heap.to_list())
        assert expected_list == copy_of_heap_list
        # Verify that pushing a new element does not result in an alteration of
        # the previously-returned list.
        min_heap.push((7, {5, 7, 9}))
        assert expected_list == copy_of_heap_list
