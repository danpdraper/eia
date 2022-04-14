import heapq
import logging

import eia.transformations as transformations


LOGGER = logging.getLogger(__name__)


NOT_IMPLEMENTED_ERROR_MESSAGE = 'Subclasses must override this method.'


EPSILON = 0.00001


class SetHeapElement(object):
    def issubset(self, other):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)

    def issuperset(self, other):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)

    def intersection(self, other):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)

    def intersects(self, other):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)

    def has_common_states_but_different_provisions(self, other):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)

    def has_same_provisions(self, other):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)

    def union(self, other):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)

    def add(self, other):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)

    def copy(self):
        raise NotImplementedError(NOT_IMPLEMENTED_ERROR_MESSAGE)


class ProvisionGroupHeapElement(SetHeapElement):
    def __init__(self, scaled_average, number_of_pairs, provisions):
        self.scaled_average = scaled_average
        self.number_of_pairs = number_of_pairs
        self.provisions = provisions

    def verify_argument_type(self, argument):
        if not isinstance(argument, SetHeapElement):
            raise TypeError(
                "Argument must be of type SetHeapElement; received: {}.".format(
                    type(argument)))

    def issubset(self, other):
        self.verify_argument_type(other)
        return self.provisions.issubset(other.provisions)

    def issuperset(self, other):
        self.verify_argument_type(other)
        return self.provisions.issuperset(other.provisions)

    def intersection(self, other):
        self.verify_argument_type(other)
        return self.provisions.intersection(other.provisions)

    def intersects(self, other):
        self.verify_argument_type(other)
        return True if self.intersection(other) else False

    def has_common_states_but_different_provisions(self, other):
        self.verify_argument_type(other)
        symmetric_difference = self.union(other) - self.intersection(other)
        states_in_symmetric_difference = set()
        for provision in symmetric_difference:
            state = transformations.label_to_state_and_provision_identifier(provision)[0]
            if state in states_in_symmetric_difference:
                return True
            states_in_symmetric_difference.add(state)
        return False

    def has_same_provisions(self, other):
        self.verify_argument_type(other)
        return self.provisions == other.provisions

    def union(self, other):
        self.verify_argument_type(other)
        return self.provisions.union(other.provisions)

    def add(self, other):
        self.verify_argument_type(other)
        new_number_of_pairs = self.number_of_pairs + other.number_of_pairs
        new_provisions = self.union(other)
        self_sum = self.scaled_average * self.number_of_pairs / (len(self.provisions) - 1)
        other_sum = other.scaled_average * other.number_of_pairs / (len(other.provisions) - 1)
        new_scaled_average = (self_sum + other_sum) * (len(new_provisions) - 1) / new_number_of_pairs
        return ProvisionGroupHeapElement(
            new_scaled_average, new_number_of_pairs, new_provisions)

    def copy(self):
        return ProvisionGroupHeapElement(
            self.scaled_average, self.number_of_pairs, self.provisions)

    def __gt__(self, other):
        self.verify_argument_type(other)
        return self.scaled_average > other.scaled_average

    def __lt__(self, other):
        self.verify_argument_type(other)
        return self.scaled_average < other.scaled_average

    def __le__(self, other):
        self.verify_argument_type(other)
        return self.scaled_average <= other.scaled_average

    def __str__(self):
        return "{{scaled_average: {}, number_of_pairs: {}, provisions: {}}}".format(
            self.scaled_average, self.number_of_pairs,
            sorted(list(self.provisions)))

    def __repr__(self):
        return self.__str__()

    def __eq__(self, other):
        self.verify_argument_type(other)
        return abs(self.scaled_average - other.scaled_average) < EPSILON and \
            self.number_of_pairs == other.number_of_pairs and \
            self.provisions == other.provisions

    def __hash__(self):
        return hash(str(self))


class SetBoundedMinHeap(object):
    def __init__(self, max_heap_size):
        self.max_heap_size = max_heap_size
        self.heap = []

    def push(self, element):
        if len(self.heap) < self.max_heap_size:
            heapq.heappush(self.heap, element)
        elif element > self.heap[0]:
            heapq.heappushpop(self.heap, element)
        LOGGER.debug("The heap currently contains {} elements.".format(len(self.heap)))

    def to_list(self):
        return list(self.heap)

    def delete_subsets_with_lower_or_equal_scores(self):
        to_delete = []
        for index, outer_element in enumerate(self.heap):
            for inner_element in self.heap:
                if outer_element == inner_element:
                    continue
                if outer_element.issubset(inner_element) and outer_element <= inner_element:
                    LOGGER.debug(
                        "Element {} is a subset of element {} and has a lower "
                        "or equal score.".format(outer_element, inner_element))
                    to_delete.append((index, outer_element))
                    break
        for counter, index_and_element in enumerate(to_delete):
            LOGGER.debug("Deleting element {}.".format(index_and_element[1]))
            self.heap.pop(index_and_element[0] - counter)

    def delete_supersets_with_lower_scores(self):
        to_delete = []
        for index, outer_element in enumerate(self.heap):
            for inner_element in self.heap:
                if outer_element == inner_element:
                    continue
                if outer_element.issuperset(inner_element) and outer_element < inner_element:
                    LOGGER.debug(
                        "Element {} is a superset of element {} and has a "
                        "lower score.".format(outer_element, inner_element))
                    to_delete.append((index, outer_element))
                    break
        for counter, index_and_element in enumerate(to_delete):
            LOGGER.debug("Deleting element {}.".format(index_and_element[1]))
            self.heap.pop(index_and_element[0] - counter)

    def generate_new_elements_from_intersections(
            self, elements_to_process, elements_to_add, elements_to_delete,
            new_elements):
        for outer_index, outer_element in enumerate(elements_to_process):
            if outer_index == len(elements_to_process) - 1:
                continue
            for inner_element in elements_to_process[outer_index + 1:]:
                if outer_element.intersects(inner_element) and not \
                        outer_element.has_common_states_but_different_provisions(inner_element):
                    new_element = outer_element.add(inner_element)
                    LOGGER.debug(
                        "Element {} intersects element {}. Adding {} to "
                        "new_elements.".format(
                            outer_element, inner_element, new_element))
                    elements_to_delete.add(outer_element)
                    elements_to_delete.add(inner_element)
                    new_elements.add(new_element)

    def deduplicate_new_elements(self, new_elements):
        LOGGER.debug("Deduplicating elements {}.".format(new_elements))
        new_elements = list(new_elements)
        deduplicated_new_elements = set()
        duplicate_indices = set()
        for outer_index, outer_element in enumerate(new_elements):
            if outer_index in duplicate_indices:
                continue
            for inner_index in range(outer_index + 1, len(new_elements)):
                if inner_index in duplicate_indices:
                    continue
                inner_element = new_elements[inner_index]
                if outer_element.has_same_provisions(inner_element):
                    LOGGER.debug(
                        "Element {} has the same provisions as element "
                        "{}; combining the two.".format(
                            inner_element, outer_element))
                    duplicate_indices.add(inner_index)
                    outer_element = outer_element.add(inner_element)
            deduplicated_new_elements.add(outer_element)
        return deduplicated_new_elements

    def consolidate_intersections(self):
        elements_to_process = self.heap
        elements_to_add = set()
        elements_to_delete = set()
        new_elements = set()
        while elements_to_process:
            LOGGER.debug("Processing elements {}.".format(elements_to_process))
            self.generate_new_elements_from_intersections(
                elements_to_process, elements_to_add, elements_to_delete,
                new_elements)
            deduplicated_new_elements = self.deduplicate_new_elements(new_elements)
            elements_to_add = elements_to_add.union(deduplicated_new_elements)
            elements_to_process = list(deduplicated_new_elements)
            new_elements = set()
        LOGGER.debug(
            "Adding the following elements to the heap: {}.".format(
                elements_to_add))
        self.heap.extend(elements_to_add)
        for element in elements_to_delete:
            LOGGER.debug("Deleting intersecting element {}.".format(element))
            self.heap.remove(element)

    def heapify(self):
        heapq.heapify(self.heap)

    def consolidate(self):
        self.delete_subsets_with_lower_or_equal_scores()
        self.delete_supersets_with_lower_scores()
        self.consolidate_intersections()
        self.heapify()
