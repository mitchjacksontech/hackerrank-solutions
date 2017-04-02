#!/usr/bin/env python3
from sys import stdin
import bisect

# Hacker Rank ctci-find-the-running-median
#  mitch@mitchjacksontech.com
#  https://www.hackerrank.com/challenges/ctci-find-the-running-median
#
#  Why is this ranked a hard problem?  Oh... heap sorting.
#  After hours of banging against time execution limits,
#  let's cheat with the bisect module

first = True
heap  = []
i     = 0
for value in stdin:

    if first:
        first = False
        continue

    bisect.insort(heap, int(value))
    i += 1

    if ( i % 2 ):
        print("%.1f" % heap[int(i/2)])
    else:
        m = (heap[int((i/2)-1)]+heap[int(i/2)])/2
        print("%.1f" % m)
