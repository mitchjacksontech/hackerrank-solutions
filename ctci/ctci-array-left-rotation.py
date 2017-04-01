#!/usr/bin/env python3
#
# mitch@mitchjacksontech.com
#  https://www.hackerrank.com/challenges/ctci-array-left-rotation
#  Cracking the Coding Interview: Array Left Rotation
#
# Comments:
# The lazy slow approach here would be to perform an array shift operation
# inside a for loop.  Unnecessarily expensive.  Instead, let's build a new
# array out of two slices of the original array.  The operation's cost is
# the same regardless of the values provided.



def array_left_rotation(arr, size, rotations):
    # trim excess full rotations
    if rotations > size:
        rotations = rotations % size

    # rebuild the array from two slices
    if rotations:
        arr = (arr[rotations:] + arr[:(rotations)])

    return(arr)



size, rotations = map(int, input().strip().split(' '))
arr = list(map(int, input().strip().split(' ')))
answer = array_left_rotation(arr, size, rotations);
print(*answer, sep=' ')
