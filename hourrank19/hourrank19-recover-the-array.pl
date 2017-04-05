#!/usr/bin/perl
=head1 Hacker Rank recover-the-array

    mitch@mitchjacksontech.com
      https://www.hackerrank.com/contests/hourrank-19/challenges/recover-the-array
    
    Display a basic understanding of the array
 
=cut

use strict;
my @in; push @in,$_ for (<>);chomp for @in;
shift @in;

my @data= split / /,shift @in;
my $i = 0;
my $c = 0;
while ($i < scalar @data) {
    $i += $data[$i]+1;
    $c++;
}
print "$c\n";
