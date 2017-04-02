#!/usr/bin/env perl
use strict;

=head1 Hacker Rank ransom-note

    mitch@mitchjacksontech.com
    https://www.hackerrank.com/challenges/ccti-ransom-note

=head1 Comments

    The solution creates a hash lookup table counting the words
    needed for the ransom note.  As words are located scanning the
    magazine, entries are removed from the lookup table.  Once
    the lookup table is empty, we can stop reading the magazine and
    declare success.

=cut

my @in; push @in,$_ for <>; chomp for @in;

shift @in;
my @magazine    = split / /, shift @in;
my @ransom_note = split / /, shift @in;
my %w;

$w{$_}++ for @ransom_note;

for (@magazine) {
    if (exists $w{$_}) {
        if ($w{$_} > 1) {
            $w{$_}--;
        } else {
            delete $w{$_};
        }
    }
    last unless keys %w;
}
print keys %w ? "No\n" : "Yes\n";
