import heapq
import logging


LOGGER = logging.getLogger(__name__)


class BoundedMinHeap(object):
    def __init__(self, max_heap_size, reduce_element_data_redundancy=False):
        self.max_heap_size = max_heap_size
        self.reduce_element_data_redundancy = reduce_element_data_redundancy
        self.heap = []

    def subsets_and_supersets(self, element):
        higher_value_subsets, other_subsets = [], []
        lower_value_supersets, other_supersets = [], []
        for heap_index, heap_element in enumerate(self.heap):
            if heap_element[1].issubset(element[1]):
                if heap_element[0] > element[0]:
                    higher_value_subsets.append((heap_index, heap_element))
                else:
                    other_subsets.append((heap_index, heap_element))
            if heap_element[1].issuperset(element[1]):
                if heap_element[0] < element[0]:
                    lower_value_supersets.append((heap_index, heap_element))
                else:
                    other_supersets.append((heap_index, heap_element))
        return higher_value_subsets, other_subsets, lower_value_supersets, other_supersets

    def heapify(self):
        heapq.heapify(self.heap)

    def push_without_redundancy_reduction(self, element):
        if len(self.heap) < self.max_heap_size:
            heapq.heappush(self.heap, element)
        elif element > self.heap[0]:
            heapq.heappushpop(self.heap, element)

    def push_with_redundancy_reduction(self, element):
        if len(self.heap) == self.max_heap_size and element <= self.heap[0]:
            return
        LOGGER.debug("Comparing {} with existing heap elements.".format(element))
        higher_value_subsets, other_subsets, lower_value_supersets, other_supersets = \
            self.subsets_and_supersets(element)
        LOGGER.debug("Higher value subsets: {}.".format(higher_value_subsets))
        LOGGER.debug("Other subsets: {}.".format(other_subsets))
        LOGGER.debug("Lower value supersets: {}.".format(lower_value_supersets))
        LOGGER.debug("Other supersets: {}.".format(other_supersets))

        if other_supersets:
            return

        if lower_value_supersets:
            LOGGER.debug(
                "Removing {} from the heap and adding {}.".format(
                    lower_value_supersets, element))
            for index, superset in enumerate(lower_value_supersets):
                self.heap.pop(superset[0] - index)
            self.heap.append(element)
            self.heapify()
            return

        if other_subsets:
            LOGGER.debug("Removing {} from the heap.".format(other_subsets))
            for index, subset in enumerate(other_subsets):
                self.heap.pop(subset[0] - index)
            if not higher_value_subsets:
                LOGGER.debug("Adding {} to the heap.".format(element))
                self.heap.append(element)
            self.heapify()
            return

        if higher_value_subsets:
            return

        self.push_without_redundancy_reduction(element)

    def push(self, element):
        if self.reduce_element_data_redundancy:
            self.push_with_redundancy_reduction(element)
        else:
            self.push_without_redundancy_reduction(element)

    def to_list(self):
        return list(self.heap)
