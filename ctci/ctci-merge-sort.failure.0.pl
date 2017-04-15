#!/usr/bin/env perl
use strict;

# Hacker Rank ctci-merge-sort
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-merge-sort
#
# Solution implements the mergesort algorithm as presented in the
# Gayle Laakman McDowell video.
#
# The problem asks for a count of number swaps during sorting.
# Rather than the actual swaps of the mergesort algorithm,
# it seems to want the number of swaps that would have occured
# had we used a bubblesort.
#
# Instead of recording a count when a swap occurs during the array merge,
# we count the number of positions a digit would have moved in the original
# array when it's position is changed.
#
# Use of globals isn't elegant, but reduced runtime by avoiding
# lots of dereferencing

my $first_skip = 1;
my $asize_skip = 1;
my $swp_count  = 0;

my @arr;
my @tmp;

while (<>) {
    if ($first_skip) {$first_skip=0;next}
    if ($asize_skip) {$asize_skip=0;next}
    chomp;

    $asize_skip = 1;
    $swp_count  = 0;

    @arr = split / /,$_;
    my @arr_cpy = @arr;
#print "Unsorted: ".join(' ',@arr)."\n";
    merge_sort(0,@arr-1);
#print "Sorted:   ".join(' ',@arr)."\n";
    print "$swp_count\n";
    @arr_cpy = sort { $a <=> $b } @arr_cpy;

    for my $i ( 0..@arr_cpy-1 ) {
        print "Wrong: $arr[$i] != $arr_cpy[$i] at $i\n"
            unless $arr[$i] == $arr_cpy[$i];
    }

    print "$arr[0] $arr_cpy[0]\n";

    print "\n";
    print "\@arr: ".join(' ',@arr)."\n";
    print "\@cpy: ".join(' ',@arr_cpy)."\n";
}

sub merge_sort {
    my ($start,$end) = @_;
    return if $start >= $end;

    my $left_start  = $start;
    my $left_end    = int(($start+$end)/2);
    my $right_start = $left_end+1;
    my $right_end   = $end;

    merge_sort($left_start,  $left_end);
    merge_sort($right_start, $right_end);

    my $left_idx  = $left_start;
    my $right_idx = $right_start;
    my $tmp_idx   = $left_start;

    while ($left_idx <= $left_end && $right_idx <= $right_end) {
        if ($arr[$right_idx] < $arr[$left_idx]) {
            $tmp[$tmp_idx] = $arr[$right_idx];
            $swp_count += ($left_end - $tmp_idx + 1);
            $right_idx++;
        } else {
            $tmp[$tmp_idx] = $arr[$left_idx];
            $left_idx++;
        }
        $tmp_idx++;
    }

    if ($left_idx <= $left_end) {
        @tmp[$left_idx..$left_end] = @arr[$left_idx..$left_end];
    } else {
        @tmp[$right_idx..$right_end] = @arr[$right_idx..$right_end];
    }

    @arr[$start..$end] = @tmp[$start..$end];
}
