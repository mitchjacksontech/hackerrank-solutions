#!/usr/bin/perl
use strict;

# Hacker Rank ctci-recursive-staircase
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-recursive-staircase
#
# Count the number of ways to climb the stairs through recursion.
#
# I've generated a lookup table for the last 32 stairs.
# Perhaps this will help with timeouts?





my @in;push @in,$_ for <>;chomp for @in;shift @in;
my %plu = precomputed_lookup_table();
print count_permutations($_)."\n" for @in;

sub count_permutations {
    my $s = $_[0];
    return $plu{$s} if $s <= 32;

    my $p = 0;
    $p += count_permutations($s-1);
    $p += count_permutations($s-2);
    $p += count_permutations($s-3);
    return $p;
}

sub precomputed_lookup_table {
    return (
        0 => 0,
        1 => 1,
        2 => 2,
        3 => 4,
        4 => 7,
        5 => 13,
        6 => 24,
        7 => 44,
        8 => 81,
        9 => 149,
        10 => 274,
        11 => 504,
        12 => 927,
        13 => 1705,
        14 => 3136,
        15 => 5768,
        16 => 10609,
        17 => 19513,
        18 => 35890,
        19 => 66012,
        20 => 121415,
        21 => 223317,
        22 => 410744,
        23 => 755476,
        24 => 1389537,
        25 => 2555757,
        26 => 4700770,
        27 => 8646064,
        28 => 15902591,
        29 => 29249425,
        30 => 53798080,
        31 => 98950096,
        32 => 181997601
    );
}
