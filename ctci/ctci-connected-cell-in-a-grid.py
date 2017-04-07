#!/usr/bin/env python3

# Hacker Rank ctci-connected-cell-in-a-grid
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-connected-cell-in-a-grid
#
# comments:
#
# This challenge is ranked hard.  Therefore, I assume it's going to try
# bumping us up against execution time limits or memory usage limits.
#
# The input game board is stored in a two dimentional array. The solution
# will walk the board, building regions with a DFS search pattern

class Board(object):
    def __init__(self,rows,cols,board):
        self.rows      = rows-1
        self.cols      = cols-1
        self.board     = board
        self.region    = []
        self.region_sz = [0]

        for i in range(rows): self.region.append([0 for j in range(cols)])

    def largest_region_size(self):
        return max(self.region_sz)

    def find_regions(self):
        # Walk the board, square by square.  If the selected square is a
        # member of an unexplored region, explore it
        region_id = 0;
        for ir in range(self.rows+1):
            for ic in range(self.cols+1):
                if self.board[ir][ic] and not self.region[ir][ic]:
                    region_id += 1
                    self.region_sz.append(0)
                    self.explore_region(region_id,ir,ic)

    def explore_region(self,region_id,r,c):
        # in a dfs pattern, map the squres in the given region
        stack = [[r,c]]
        while stack:
            # 0) skip cell if it's already processed
            # 1) flag cell as member of current region
            # 2) increment the region size counter
            # 3) Add adacent cells which should be in region to the
            #    stack
            (er,ec) = stack.pop(0)
            if self.region[er][ec]: continue
            self.region[er][ec] = region_id
            self.region_sz[region_id] += 1
            for rc in self.edges_of(er,ec):
                if self.board[rc[0]][rc[1]] and not self.region[rc[0]][rc[1]]:
                    stack.append([rc[0],rc[1]])

    def edges_of(self,r,c):
        # to reduce conditionals, only 4 tests are needed if square
        # is inside the board.  If it's on an edge, 18 tests are needed
        edges = []
        if r > 0 and c > 0 and r < self.rows and c < self.cols:
            edges = [
                [r-1,c-1],[r-1,c],[r-1,c+1],
                [r,c-1],          [r,c+1],
                [r+1,c-1],[r+1,c],[r+1,c+1],
            ]
        else:
            for mod_r in (-1,0,1):
                for mod_c in (-1,0,1):
                    if mod_r==0 and mod_c == 0: continue
                    adj_r = r + mod_r
                    adj_c = c + mod_c
                    if     adj_r >= 0 and adj_r <= self.rows \
                       and adj_c >= 0 and adj_c <= self.cols:
                        edges.append([adj_r,adj_c])
        return edges


n = int(input().strip())
m = int(input().strip())
grid = []
for grid_i in range(n):
    grid_t = list(map(int, input().strip().split(' ')))
    grid.append(grid_t)

b = Board(n,m,grid)
b.find_regions()
print(b.largest_region_size())
