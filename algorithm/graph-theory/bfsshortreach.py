#!/usr/bin/env python3

# Hacker Rank: bfsshortreach
# https://www.hackerrank.com/challenges/bfsshortreach
#
# mitch@mitchjacksontech.com
#
# For as many inputs as we're given:
# * Build an undirected graph from input
# * Calculate the distance to each node in the graph from the starting point
# * Display the distances
#
# The graph represented in this problem is very simple.  For speed's
# sake, the Graph object reprsents the graph internally as two arrays:
# edges and distances.  Also for speed's sake, the internal data
# structure of the Graph object is broken after the output is read.

def bfsshortreach():
    n, m = map(int, input().strip().split(' '))
    g = Graph(n)
    for i in range(m):
        u, v = map(int, input().strip().split(' '))
        g.add_edge(u,v)
    s = int(input())
    return g.bfs_compute_shortest_distances_from(s)



class Graph:
    def __init__(self,size):
        self.size = size
        self.edges = [[] for i in range(size)]
        self.distances = [-1 for i in range(size)]

    def add_edge(self,v,u):
        self.edges[v-1].append(u-1)
        self.edges[u-1].append(v-1)

    def bfs_compute_shortest_distances_from(self,start):
        queue = [start-1]
        current_distance = 0;
        while queue:
            next_queue = []
            for node in queue:
                if self.distances[node] < 0:
                    self.distances[node] = current_distance
                    next_queue.extend(self.edges[node])
            current_distance += 6
            queue = next_queue
        self.distances.pop(start-1)
        return ' '.join(str(d) for d in self.distances)

    def showme(self):
        print(self.size)
        print(self.edges)
        print(self.distances)

q = int(input())
for i in range(q):
    print(bfsshortreach())
