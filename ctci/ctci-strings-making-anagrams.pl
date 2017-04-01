#!/usr/bin/env perl
use strict;

=head1 hackerrank Strings: Making Anagrams

    mitch@mitchjacksontech.com
        https://www.hackerrank.com/challenges/ctci-contacts

=head2 Comments

    Solved by building a hash table counting the number of occurences
    of each character in each string.  The sum of the differences
    between those counts is the number of required deletions.

    Below we add a character count for each character in the first string.
    We subtractract a character count for each character in the second string.
    Finally we sum the abs value of what's left in the count hash.

=cut

# read input
my @in; push @in,$_ for <>; chomp for @in;
my ( $str_a, $str_b ) = @in;
my $deletions = 0;
my %count;

for my $chr ( split //, $str_a ) {
    $count{$chr} = 0 unless defined $count{$chr};
    $count{$chr}++;
}
for my $chr ( split //, $str_b ) {
    $count{$chr} = 0 unless defined $count{$chr};
    $count{$chr}--;
}
for ( keys %count ) {
    $deletions += abs($count{$_});
}
print "$deletions\n";
