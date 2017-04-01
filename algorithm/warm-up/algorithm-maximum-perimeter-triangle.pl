#!/usr/bin/perl
use strict;

my $n      = <STDIN>;
my $sticks = <STDIN>;
chomp($sticks, $n);

my @sticks = sort { $b <=> $a } split / /,$sticks;
my @triangle;

my @tri;
TRI: for my $x ( 0..$n-3 ) {
        for my $y ( $x+1..$n-2 ) {
            for my $z ( $x+2..$n-1 ) {
                if ( $sticks[$x] + $sticks[$y] > $sticks[$z] and
                     $sticks[$x] + $sticks[$z] > $sticks[$y] and
                     $sticks[$y] + $sticks[$z] > $sticks[$x]
                ) {
                    @tri = ($sticks[$x], $sticks[$y], $sticks[$z]);
                    last TRI;
                }
            }
        }
     }


scalar(@tri) > 0 ? print(join(' ',sort(@tri))) : print '-1';
print "\n";

