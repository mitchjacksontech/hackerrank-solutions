#
# Stub code added here to build a testing node
# Actual test node code is hidden during exercise
class node:
    def __init__(self, data, left=None, right=None):
        self.data = data
        self.left = left
        self.right = right

root=node(
    data=3,
    left=node(
        data=2,
        left=node(
            data=1
        ),
        right=node(
            data=4
        ),
    ),
    right=node(
        data=6,
        left=node(
            data=5,
        ),
        right=node(
            data=7
        )
    )
)


# mitch@mitchjacksontech.com
#  https://www.hackerrank.com/challenges/ctci-is-binary-search-tree?h_r=next-challenge&h_v=zen
#
# Comments:
#  Not the most efficient solution.  I walk the entire tree with in-order traversal,
#  building an ordered list of values.  Then I check the list is in ascending order.
#  A more efficient solution would fail immediately when reaching an invalid node,
#  and stop walking the tree.
#
#  Thanks to https://en.wikipedia.org/wiki/Tree_traversal

""" Node is defined as
class node:
    def __init__(self, data):
        self.data = data
        self.left = None
        self.right = None
"""

def walk_inorder(node):
    if node:
        values = []
        if node.left: values = values + walk_inorder(node.left)
        values.append(node.data)
        if node.right: values = values + walk_inorder(node.right)
        return values

def check_binary_search_tree_(root):
    values = walk_inorder(root)
    pv = 0
    for x in values:
        if x <= pv:
            return False
        pv = x

print check_binary_search_tree_(root)
