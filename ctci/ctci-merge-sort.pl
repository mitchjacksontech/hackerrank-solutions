#!/usr/bin/env perl
use strict;
# use 5.2.2;
# use feature 'refaliasing';
# no warnings 'experimental::refaliasing';



#   Hacker Rank ctci-merge-sort
#
#   mitch@mitchjacksontech.com
#   https://www.hackerrank.com/challenges/ctci-merge-sort
#
# Solution implements the mergesort algorithm as presented in the
# Gayle Laakman McDowell video.
#
# The problem asks for a count of number swaps during sorting
# while implementing mergesort.
#
# That was confusing.  The output they actually want is the number
# of swaps that would have occured using a bubblesort, but while
# implementing a mergesort.
#
# Note: The use of global arrays rather than passing around
#       array references decresed execution time on testcase7
#       from 45s to 3.5s
#
# Note: Still timeout on the last few test cases...
#       These arbitrary micro-optimizations are futile and hurt readability

our @list;
our @tmp;
my @tmp2;
my $awsp = 0;

my $first_skip = 1;
my $size_skip  = 1;
while (<>) {
    if ($first_skip) {$first_skip=0;next}
    if ($size_skip) {$size_skip=0;next}
    $size_skip=1;

    chomp;
    @list = split / /,$_;

    my $count = mergesort(0,@list-1);
    print "$count\n";
}

sub mergesort {
    return 0 if $_[0] >= $_[1];
    my $swp_count = 0;
    my $l_end     = int(($_[0]+$_[1])/2);

    # divide list into two sorted lists
    $swp_count += mergesort($_[0],$l_end);
    $swp_count += mergesort($l_end+1,$_[1]);

    # merge the two lists in sorted order
    my $l_idx = my $t_idx = $_[0];
    my $r_idx = $l_end+1;
    while ($l_idx <= $l_end && $r_idx <= $_[1]) {
        if ($list[$r_idx] < $list[$l_idx]) {
            $tmp[$t_idx++] = $list[$r_idx++];
            $swp_count += ($l_end - $l_idx + 1);
        } else {
            $tmp[$t_idx++] = $list[$l_idx++];
        }
    }
    while ($l_idx <= $l_end) {
        $tmp[$t_idx++] = $list[$l_idx++];
    }
    while ($r_idx <= $_[1]) {
        $tmp[$t_idx++] = $list[$r_idx++];
    }

print "\@list ".join(' ',@list)."\n";
print "\@tmp  ".join(' ',@tmp)."\n";

    # Swap @list and @tmp instead of copying over values
    # *tmp2 = \@list;
    # *list = \@tmp;
    # *tmp  = \@tmp2;
    #@list[$_[0]..$_[1]]=@tmp[$_[0]..$_[1]];
    (*list,*tmp) = (\@tmp,\@list);
    # \@tmp2 = \@list;
    # \@list = \@tmp;
    # \@tmp  = \@tmp2;
print "\$list[0]: $list[0]\n";
print "\@list ".join(' ',@list)."\n";
print "\@tmp  ".join(' ',@tmp)."\n";
print "\n";

    return $swp_count;
}
