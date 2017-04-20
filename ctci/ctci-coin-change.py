#!/usr/bin/env python3

# Hacker Rank ctci-coin-change
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-coin-change
#
# https://www.youtube.com/watch?v=jaNZ83Q3QGc
# Thanks for helping me understand a useful approach

import sys

def make_change(coins, n):
    counts = [0] * (n+1);
    counts[0] = 1;

    for c in coins:
        for i in range(1,n+1):
            if i >= c:
                counts[i] += counts[i-c]

    return counts[n]

n,m = input().strip().split(' ')
n,m = [int(n),int(m)]
coins = [int(coins_temp) for coins_temp in input().strip().split(' ')]
print(make_change(coins, n))
