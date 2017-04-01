#!/usr/bin/perl
use strict;
my $scores_A = <STDIN>;
my $scores_B = <STDIN>;
chomp( $scores_A, $scores_B );

my @sA = split / /, $scores_A;
my @sB = split / /, $scores_B;

my $pA = 0;
my $pB = 0;

for (0..2) {
    next if $sA[$_] eq $sB[$_];
    $sA[$_] > $sB[$_] ? $pA++ : $pB++;
}

print "$pA $pB";



