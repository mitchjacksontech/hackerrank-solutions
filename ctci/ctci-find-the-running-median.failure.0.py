#!/usr/bin/env python3
from sys import stdin

# Hacker Rank ctci-find-the-running-median
#  mitch@mitchjacksontech.com
#  https://www.hackerrank.com/challenges/ctci-find-the-running-median
#
#  Why is this ranked a hard problem?  Oh... heap sorting.

class min_heap(object):
    def __init__(self):
        self.items = []
        self.size  = 0

    def left_idx(self,i):
        return 2 * i + 1

    def right_idx(self,i):
        return 2 * i + 2

    def parent_idx(self,i):
        return int((i-1)/2)

    def has_left(self,i):
        return self.left_idx(i) < self.size-1

    def has_right(self,i):
        return self.right_idx(i) < self.size-1

    def has_parent(self,i):
        return self.parent_idx(i) >= 0

    def left(self,i):
        return self.items[self.left_idx(i)]

    def right(self,i):
        return self.items[self.right_idx(i)]

    def parent(self,i):
        return self.items[self.parent_idx(i)]

    def swap(self,i1,i2):
        self.items[i1],self.items[i2] = self.items[i2],self.items[i1]

    # return the root node
    def peek(self):
        if self.items:
            return self.items[0]
        return None

    # delete and return the root node value
    def poll(self):
        val = self.items[0]
        self.items[0] = self.items[-1]
        self.items.pop[-1]
        self.size = self.size - 1
        self.heapify_down()
        return val

    def add(self,val):
        self.items.append(val)
        self.size = self.size + 1;
        self.heapify_up()

    def heapify_up(self):
        i = len(self.items)-1
        while self.has_parent(i) and self.parent(i) > self.items[i]:
            self.swap(self.parent_idx(i), i)
            i = self.parent_idx(i)

    def heapify_down(self):
        i = 0;
        while (self.has_left(i)):
            smaller_idx = self.left_idx(i)

            if self.has_right(i) and self.right(i) < self.left(i):
                smaller_idx = self.right_idx(i)

            if self.items[i] < self.items[smaller_idx]:
                break
            else:
                self.swap(i,smaller_idx)

            i = smaller_idx

    def heapsort(self):
        while self.size > 1:
            self.swap(self.size-1,0)
            self.size = self.size - 1
            self.heapify_down()
        self.size = len(self.items)

    def median(self):
        self.heapsort()
        mid_idx = int(len(self.items)/2)
        if len(self.items) % 2:
            return self.items[mid_idx]
        m = (self.items[mid_idx-1] + self.items[mid_idx])/2
        return m

heap = min_heap()
first = True
for value in stdin:
    if first:
        first = False
        continue
    value = int(value)
    heap.add(value)
    print("%.1f" % heap.median())
