#!/usr/bin/env python3

# Hacker Rank ctci-contacts
#
# mitch@mitchjacksontech.com
#  https://www.hackerrank.com/challenges/ctci-contacts
#
# Feeling sluggish today, but I want to do some practice
# coding.  Solving this problem again in pythin, without
# consulting my perl solution.
#
# Solve by implementing a Trie data structure
#
# I'm not going to use objects for each node of the trie.
# Considering we just need to store three values per node,
# and each node doesn't implement any login, it's overkill
# and a hash table will do
#
# My first attempt generated a runtime error on data sets
# 3, 4 and 12... 100,000 entry data sets.  These must be
# out of memory errors.
#
# I try to reduce memory usage two ways:
# 1) A Tuple isn't necessary to represent a node, we'll use
#    an array instead
# 2) The 'data' field in the node is redundant.  It's eliminated.
#
# e.g.:
#      node = {            replaced     node = [1,{}]
#          'data':chr,     with
#          'hits':1,
#          'leaves':{},
#      }
#
# These data structure changes improve execution time by 33%

class contacts_trie(object):
    def __init__(self):
        self.root = [0,{}]

    def add(self,contact):
        node = self.root
        for chr in contact:
            if chr in node[1]:
                node = node[1][chr]
                node[0] += 1
            else:
                node[1][chr] = [1,{}]
                node = node[1][chr]

    def count_matches_for(self,search_str):
        node = self.root
        for chr in search_str:
            if chr in node[1]:
                node = node[1][chr]
            else:
                return 0
        return node[0]

n = int(input().strip())
trie = contacts_trie()
for a0 in range(n):
    op, contact = input().strip().split(' ')
    if op == 'add':
        trie.add(contact)
    else:
        print(trie.count_matches_for(contact))
