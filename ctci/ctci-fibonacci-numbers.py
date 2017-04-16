#!/usr/bin/env python3;

# Hacker Rank ctci-fibonacci-numbers
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-fibonacci-numbers
#
# Recursion with python was too slow for the solution, but a
# for loop works just fine
def fibonacci(n):
    if n < 1: return 0
    if n == 1: return 1
    if n == 2: return 1

    a = 0
    b = 1
    c = 1
    for i in range(n-2):
        a = b
        b = c
        c = a+b
    return c

n = int(input())
print(fibonacci(n))
