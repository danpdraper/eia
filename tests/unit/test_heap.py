import eia.heap as heap


class TestBoundedMinHeap(object):
    def setup(self):
        self.heap_size = 5

    def test_push_adds_item_to_heap_and_moves_smallest_element_to_top_of_heap(self):
        # Integers
        min_heap = heap.BoundedMinHeap(self.heap_size)
        min_heap.push(1)
        min_heap.push(3)
        min_heap.push(5)
        assert 1 == min_heap.heap[0]

        # Tuples
        min_heap = heap.BoundedMinHeap(self.heap_size)
        min_heap.push((1, 'first element'))
        min_heap.push((3, 'second element'))
        min_heap.push((5, 'third element'))
        assert (1, 'first element') == min_heap.heap[0]

    def test_push_discards_smallest_item_in_heap_when_min_heap_size_exceeded(self):
        # Integers
        min_heap = heap.BoundedMinHeap(self.heap_size)
        for value in range(self.heap_size):
            min_heap.push(value)
        # The next push will exceed the min heap size and the value is larger
        # than the smallest value in the heap, so the smallest value (i.e. 0)
        # should be removed from the heap.
        min_heap.push(5)
        assert [1, 2, 3, 4, 5] == sorted(min_heap.heap)

        # Tuples
        min_heap = heap.BoundedMinHeap(self.heap_size)
        for value in range(self.heap_size):
            min_heap.push((value, "element {}".format(value)))
        # The next push will exceed the min heap size and the element's value is
        # larger than the smallest element value in the heap, so the element
        # with the smallest value (i.e. (0, 'element 0') with value 0) should be
        # removed from the heap.
        min_heap.push((5, 'element 5'))
        expected_heap = [
            (1, 'element 1'),
            (2, 'element 2'),
            (3, 'element 3'),
            (4, 'element 4'),
            (5, 'element 5'),
        ]
        assert expected_heap == sorted(min_heap.heap)

    def test_push_discards_pushed_element_when_min_heap_size_exceeded_and_pushed_element_smallest(self):
        # Integers
        min_heap = heap.BoundedMinHeap(self.heap_size)
        for value in range(self.heap_size):
            min_heap.push(value)
        # The next push will exceed the min heap size and the value is smaller
        # than the smallest value in the heap, so the heap should not be
        # altered.
        min_heap.push(-1)
        assert [0, 1, 2, 3, 4] == sorted(min_heap.heap)

        # Tuples
        min_heap = heap.BoundedMinHeap(self.heap_size)
        for value in range(self.heap_size):
            min_heap.push((value, "element {}".format(value)))
        # The next push will exceed the min heap size and the element's value is
        # smaller than the smallest element value in the heap, so the heap
        # should not be altered.
        min_heap.push((-1, 'element -1'))
        expected_heap = [
            (0, 'element 0'),
            (1, 'element 1'),
            (2, 'element 2'),
            (3, 'element 3'),
            (4, 'element 4'),
        ]
        assert expected_heap == sorted(min_heap.heap)

    def test_to_list_returns_copy_of_list_underlying_heap(self):
        # Integers
        min_heap = heap.BoundedMinHeap(self.heap_size)
        min_heap.push(1)
        min_heap.push(3)
        min_heap.push(5)
        expected_list = [1, 3, 5]
        copy_of_heap_list = sorted(min_heap.to_list())
        assert expected_list == copy_of_heap_list
        # Very that pushing a new element does not result in an alteration of
        # the previously-returned list.
        min_heap.push(7)
        assert expected_list == copy_of_heap_list

        # Tuples
        min_heap = heap.BoundedMinHeap(self.heap_size)
        min_heap.push((1, 'first element'))
        min_heap.push((3, 'second element'))
        min_heap.push((5, 'third element'))
        expected_list = [
            (1, 'first element'),
            (3, 'second element'),
            (5, 'third element'),
        ]
        copy_of_heap_list = sorted(min_heap.to_list())
        assert expected_list == copy_of_heap_list
        # Verify that pushing a new element does not result in an alteration of
        # the previously-returned list.
        min_heap.push((7, 'fourth element'))
        assert expected_list == copy_of_heap_list
