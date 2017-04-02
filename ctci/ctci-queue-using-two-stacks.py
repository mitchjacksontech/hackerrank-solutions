#!/usr/bin/env python3
from sys import stdin

# Hacker Rank Queues: A Tale of Two Stacks
#  mitch@mitchjacksontech.com
#  https://www.hackerrank.com/challenges/ctci-queue-using-two-stacks
#
# The solution calls for implementing a queue object interacting with it.

class my_queue(object):
    def __init__(self):
        self.stack = []

    def peek(self):
        if len(self.stack):
            return self.stack[0]
        return None

    def pop(self):
        if len(self.stack):
            return self.stack.pop(0)
        return None

    def put(self, val):
        return self.stack.append(val)

queue = my_queue();

for line in stdin:
    vals = list(map(int,line.split()))

    # Enqueue
    if vals[0] == 1:
        queue.put(vals[1])

    # Dequeue
    elif vals[0] == 2:
        queue.pop()

    # Peek
    elif vals[0] == 3:
        print(queue.peek())
