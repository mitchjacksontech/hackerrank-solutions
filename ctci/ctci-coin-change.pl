#!/usr/bin/env perl
use strict;

# Hacker Rank ctci-coin-change
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-coin-change
#
# https://www.youtube.com/watch?v=jaNZ83Q3QGc
# Thanks for helping me understand a useful approach

my @in;push @in,$_ for <>;chomp for @in;
my ($change_amt,undef) = split / /,shift @in;
my @coins = sort{$a <=> $b} split / /,shift @in;
my @count = (1);

#print "Coins: ".join (' ',@coins)."\n";
#print "Amt: $change_amt\n";

for my $c (@coins) {
    for my $i (1..$change_amt) {
        #print "\$c:$c \$i:$i ";
        if ($i >= $c) {
            $count[$i] += $count[$i-$c];
        }
        #print join(" ",@count)."\n";
    }
}

print $count[$change_amt] || 0;
print "\n";
