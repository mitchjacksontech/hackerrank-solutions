#!/usr/bin/perl
use strict;

my @input;
#push(@input,$_) while (<STDIN>);
chomp(@input);

my $n;   # number of int in @car
my $k;   # number of times to rotate the array
my $q;   # number of queries in @q
my @q;   # array index queries to be returned
my @car; # array to be rotated and queried

#( $n, $k, $q ) = split ' ', shift @input;
#@car           = split ' ', shift @input;
#@q             = @input;


$n = 3;
$k = 2;
$q = 3;
@car = qw/1 2 3/;
@q   = qw/0 1 2/;

unshift( @car, pop @car ) for (1..$k);
print "$car[$_]\n" for @q;
