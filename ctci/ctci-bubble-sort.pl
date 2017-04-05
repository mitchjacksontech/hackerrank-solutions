#!/usr/bin/perl
use strict;

=head1 Hacker Rank ctci-find-the-running-median

    mitch@mitchjacksontech.com
    https://www.hackerrank.com/challenges/ccti-find-the-running-median

=cut

# Read input from stdin or file
my @in; push @in,$_ for (<>); chomp($in[1]);
my @bs = split / /,$in[1];

# Bad bubble sort
my $total_swaps = 0;
for (1..scalar(@bs)-1 ) {
    my $loop_swaps = 0;
    for my $i ( 0..scalar(@bs)-2 ) {
        if ($bs[$i] > $bs[$i+1]) {
            ($bs[$i], $bs[$i+1]) = ($bs[$i+1], $bs[$i]);
            $loop_swaps++;
            $total_swaps++;
        }
    }
    last unless $loop_swaps;
}

# Output
print "Array is sorted in $total_swaps swaps.\n";
print "First Element: ".$bs[0]."\n";
print "Last Element: ".$bs[@bs-1]."\n";
