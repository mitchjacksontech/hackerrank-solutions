#!/usr/bin/perl
use strict;

use Algorithm::Combinatorics qw/variations variations_with_repetition/;

=head1 String Transmission

    mitch@mitchjacksontech.com

    Hacker Rank Programming Exercise
    https://www.hackerrank.com/challenges/string-transmission

    Solution Breakdown:
    - [part1]Acquire test cases from input data
    - [part2]For each test case:
      - [part2a]Generate a list of all possible corrupted variations
      - [part2b]Remove periodics from the list of possibles
      - [part2c]Count the remaining possibilities
    - [parb3]Return output formatted as specified

=cut

my @input; # stdin. one line of stdin per array element
my $t;     # number of test cases
my @t;     # $t[0]->{k}, $t[0]->{n}, $t[0]->{bstring} for each test case

# [part1]
# Acquire test cases from input data
while (<STDIN>) {
    chomp;
    push @input, $_;
}
while (@input) {
    $t = shift @input
        unless $t;
    
    # [part2] Examine each test case
    my $n;      # length of binary string
    my $k;      # number of possibly corrupted bits
    my $b_str;  # binary string as binary

    my %c_str = ($b_str => 1);  # all possibly transmitted strings,
                                # starting with the actually recieved string,
                                # stored in a hash for easy filtering

    my @bit_pos;
    my %bit_flip;
    
    ( $n, $k ) = split / /,shift @input;
    $b_str = oct('0b'.shift(@input));

    # [part2a] Generate a list of all possible corrupted variations
    # Using Algorith::Combinatorics, generate a list of binary strings
    # into @bit_pos where each active bit represents a bit position to
    # flip in the original string. Then store a list of possible
    # non corrupted strings into @c_str.
    for my $kx ( 1..$k ) {
        @bit_pos = variations([0..($n-1)], $kx);
        for ( @bit_pos ) {
            my @flips = @{$_};
            my $binflip = '0'x$n;
            substr($binflip, $_, 1, '1') for @flips;
            $bit_flip{$binflip}++;
        }
    }
    # apply the flip mask
    for my $flip_mask ( keys %bit_flip ) {
        $c_str{($b_str ^ oct("0b$flip_mask"))}++;
    }
    
    # [part2b] Remove periodics from the list of possibles
    # - cannot be periodic if $n is odd
    # - cannot be periodic if $n is 1
    # - size of periodics could be from 1 to .5$n
    # - for each size, generate all possible char combos, then
    #   create a list of full strings formed by those periodics
    # - remove periodics from the list of possibles
    if ( !($n%2) && ($n>1) ) {
        
        # generate periodics into hash keys, to ease ignoring dupes
        my %periodics;
        for my $plen ( 1..($n/2)) {
            for my $p ( variations_with_repetition([0,1],$plen) ) {
                $p = join('',@{$p});
                my $repeats = $n/length($p);
                $p = "$p"x$repeats;
                $periodics{$p}++;
            }
        }
        
        # remove periodics from possible transmissions
        for my $p ( keys %periodics ) {
            delete $c_str{$p} if exists $c_str{$p};
        }
    }

    # [part3b] Return output in the format specified
    # Output T lines, one for each test case.
    # Since the answers can be really big, output the numbers modulo 1000000007.
    print((keys %c_str)."\r\n");
    
} # end while(@input)

