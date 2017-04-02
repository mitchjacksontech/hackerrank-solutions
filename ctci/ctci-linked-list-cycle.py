# Hacker Rank ctci-linked-list-cycle
#  mitch@mitchjacksontech.com
#  https://www.hackerrank.com/challenges/ctci-linked-list-cycle
#
#  This solution walks the linked list, recording a pointer to each node
#  seen.  If we revisit a node, list contains a cycle.

def has_cycle(head):
    if not head: return False

    seen = [head]
    node = head

    while node.next:
        if node.next in seen: return True
        node = node.next
        seen.append(node)

    return False
    
