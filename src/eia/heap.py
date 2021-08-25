import heapq


class BoundedMinHeap(object):
    def __init__(self, max_heap_size):
        self.max_heap_size = max_heap_size
        self.heap = []

    def push(self, element):
        if len(self.heap) < self.max_heap_size:
            heapq.heappush(self.heap, element)
        elif element > self.heap[0]:
            heapq.heappushpop(self.heap, element)

    def to_list(self):
        return list(self.heap)
