#!/usr/bin/env perl
use strict;

=head1 Hacker Rank ctci-queue-using-two-stacks

    mitch@mitchjacksontech.com
    https://www.hackerrank.com/challenges/ccti-queue-using-two-stacks

=head1 Comments

    Since OO is very slow on hackerrank, because hr refuses to
    allow perl's OO libraries, let's implement as a simple array

=cut

my $first_line = 1;
my @q;

while (<>) {
    if ($first_line) { $first_line = 0; next; }
    chomp;
    my ($cmd,$val) = split / /,$_;

    if    ( $cmd == 1 ) { push @q, $val; } # Enqueue
    elsif ( $cmd == 2 ) { shift(@q); }     # Dequeue
    elsif ( $cmd == 3 ) { print scalar(@q) ? $q[0] : undef; print "\n"; } # peek
}
