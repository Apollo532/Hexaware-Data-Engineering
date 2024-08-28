s1 = {1, 2, 3, 4, 7, 11, 23, 36,86}
s2 = {3, 4, 5, 9, 11, 36, 49, 74}

# add()
s1.add(6)

# remove()
s1.remove(2)

# discard()
s1.discard(3)

# pop()
element = s1.pop()

# clear()
s1.clear()

# copy()
s_copy = s2.copy()


set_a = {1, 2, 3, 4, 5}
set_b = {4, 5, 6, 7, 8}

# Union:
union_set = set_a.union(set_b)
print("Union:", union_set)  # Output: {1, 2, 3, 4, 5, 6, 7, 8}

# Intersection:
intersection_set = set_a.intersection(set_b)
print("Intersection:", intersection_set)  # Output: {4, 5}

# Difference:
difference_set = set_a.difference(set_b)
print("Difference (set_a - set_b):", difference_set)  # Output: {1, 2, 3}

# Symmetric Difference:
symmetric_difference_set = set_a.symmetric_difference(set_b)
print("Symmetric Difference:", symmetric_difference_set)  # Output: {1, 2, 3, 6, 7, 8}

# issubset:
is_subset = set_a.issubset(set_b)
print("Is set_a a subset of set_b?:", is_subset)  # Output: False

# issuperset:
is_superset = set_a.issuperset(set_b)
print("Is set_a a superset of set_b?:", is_superset)  # Output: False

# isdisjoint:
is_disjoint = set_a.isdisjoint(set_b)
print("Are set_a and set_b disjoint?:", is_disjoint)  # Output: False