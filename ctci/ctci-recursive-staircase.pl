#!/usr/bin/perl
use strict;

# Hacker Rank ctci-recursive-staircase
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-recursive-staircase
#
# Count the number of ways to climb the stairs through recursion.
#
# Throw away the pre-generated lookup table, and memoize
# the recursive function

use Memoize;

my @in;push @in,$_ for <>;chomp for @in;shift @in;
memoize('count_permutations');
my %plu = (1=>1,2=>2,3=>4,4=>7);
print count_permutations($_)."\n" for @in;

sub count_permutations {
    my $s = $_[0];
    return $plu{$s} if $s <= 4;

    my $p = 0;
    $p += count_permutations($s-1);
    $p += count_permutations($s-2);
    $p += count_permutations($s-3);
    return $p;
}
