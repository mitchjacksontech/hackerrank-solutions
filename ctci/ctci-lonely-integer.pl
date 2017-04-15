#!/usr/bin/perl
use strict;

# Hacker Rank ctci-lonely-integer
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-lonely-integer

my @in; push @in,$_ for <>; chomp for @in;
shift @in;
my @vals = split / /,shift @in;
my %vals;

 while (@vals) {
     my $n = shift @vals;
     if (defined $vals{$n}) {
         delete $vals{$n};
     } else {
         $vals{$n} = 1;
     }
 }

 print keys %vals;
 print "\n";
