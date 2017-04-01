#/usr/bin/perl
use strict;

=head1 Apple and Orange
https://www.hackerrank.com/contests/w24/challenges/apple-and-orange

mkjacksontech@gmail.com

A very simple line geometry problem.

=cut

my $s;  # house left boundry
my $t;  # house right boundry
my $m;  # number of pears
my $n;  # number of oranges
my $aa; # pear tree     #$a and $b can be internally resrverd for sorts
my $bb; # orange tree
my @aa; # fallen apples
my @bb; # fallen oranges
my $aa_c; # pears fallen on house
my $bb_c; # oranges fallen on house
# gather input from STDIN
my @in; push @in,$_ for (<STDIN>);chomp @in;
( $s, $t )   = split / /, shift @in;
( $aa, $bb ) = split / /, shift @in;
( $m, $n )   = split / /, shift @in;
@aa          = split / /, shift @in;
@bb          = split / /, shift @in;
#
## Count the number of fruits that cross the house boundry line
#$aa_c =  scalar( grep{ $_ >= $s } map { $_ + $aa } @aa );
#$bb_c =  scalar( grep{ $_ <= $t } map { $_ + $bb } @bb );
#$aa_c = 0 unless $aa_c > 0;
#$bb_c = 0 unless $bb_c > 0;

$_ += $aa for @aa;
$_ += $bb for @bb;

@aa = grep { $_ >= $s } @aa;
@bb = grep { $_ <= $t } @bb;

#print "a: $_\n" for @aa;
#print "b: $_\n" for @bb;

$aa_c = @aa;
$bb_c = @bb;


print "$aa_c\n";
print "$bb_c\n";
