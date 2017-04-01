#!/usr/bin/perl
use strict;
my @in;
push @in,$_ for (<STDIN>);
chomp(@in);

my $n;     # size of board
my @b;     # board
my $x_dir; # LEFT or RIGHT
my $y_dir; # UP   or DOWN

$n = shift @in;
push @b, [ split //, $_ ] for @in;

if ( $b[0]->[0] eq 'p' ) {
    $x_dir = 'LEFT';
    $y_dir = 'UP';
} elsif ( $b[0]->[$n-1] eq 'p') {
    $x_dir = 'RIGHT';
    $y_dir = 'UP';    
} elsif ( $b[$n-1]->[0] eq 'p') {
    $x_dir = 'LEFT';
    $y_dir = 'DOWN';    
} elsif ( $b[$n-1]->[$n-1] eq 'p') {
    $x_dir = 'RIGHT';
    $y_dir = 'DOWN';    
}

for ( 1..int($n/2)) {
    print "$x_dir\n";
    print "$y_dir\n";
}



