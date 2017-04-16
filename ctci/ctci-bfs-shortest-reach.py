#!/usr/bin/env python3

# Hacker Rank ctci-bfs-shortest-reach
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-bfs-shortest-reach
#
# Had to start this one from scratch.  First attempt passed most test
# cases, but horribly wrong results for a few test cases! Switching
# programming languages for a fresh POV
#
# In my first attempt, I was prematurely incrementing the
# distance value.  I'm not sure how that version managed to
# pass any test cases at all!  A little worried this might
# be too slow

class Node:
    def __init__(self):
        self.edges    = []
        self.visited  = False
        self.distance = -1

    def add_edge(self,e):
        self.edges.append(e)

class Graph:
    def __init__(self,size):
        self.size  = size
        self.nodes = [None]
        self.start = None
        for i in range(1,size+1):
            self.nodes.append(Node())

    def add_edge(self,u,v):
        self.nodes[u].add_edge(v);
        self.nodes[v].add_edge(u);

    def find_distances_from(self,start):
        self.start = start
        queue      = [start]
        distance   = 0
        while queue:
            queue = self.__bfs_walk__(queue,distance)
            distance += 6

    def __bfs_walk__(self,queue,distance):
        # Visit each node listed in the queue
        # On the node, set the distance given and mark as visited
        # Return a list of all node edges found on nodes in the queue
        next_queue = []
        while queue:
            node = self.nodes[queue.pop(0)]
            if node.visited is True:
                continue
            node.distance = distance
            node.visited = True
            next_queue.extend(node.edges)
        return next_queue

    def print_distances(self):
        output = []
        for i in range(1,self.size+1):
            if i != self.start:
                output.append(self.nodes[i].distance)
        print(*output)

# Read input from stdin
# Build an undirected graph from input
# Calculate the distance to each node in the graph from the starting node
# Display the distances calculated
q = int(input())
for qi in range(q):
    nodes,edges = [int(value) for value in input().split()]
    graph = Graph(nodes)
    for ei in range(edges):
        u,v = [int(value) for value in input().split()]
        graph.add_edge(u,v)
    start = int(input())
    graph.find_distances_from(start)
    graph.print_distances()
