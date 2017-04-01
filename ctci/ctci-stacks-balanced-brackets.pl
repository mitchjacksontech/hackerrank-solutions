#!/usr/bin/env perl
use strict;

=head1 hackerrank Stacks: Balanced Brackets

    mitch@mitchjacksontech.com
        https://www.hackerrank.com/challenges/ctci-contacts

=head2 Comments

    Can I say here that my first solution was wrecklessly naive?
    I'm using a recursive function is_valid(@str) to validate the input.

    Not directly a stack/queue implementation.  But I'd defend the exercise thus
    The stack is the collapsing of the recursive function.
    The queue is the order the recursive function is called.

    is_valid() recursive function
    1. find the matching closing bracket for the next opening bracket
    2. pass all characters inside the brackets to is_valid()
    3. pass all the characters after the brackets to is_valid()

    Visualize verification procedure:

    ex:          {[]({[][]})}([])
      find match {          }
      queue       []({[][]})
      match       []
      match         (      )
      queue          {[][]}
      match           []
      match             []
      match                  (  )
      match                   []
=cut

my %match_tbl = (
    '(' => ')',
    '{' => '}',
    '[' => ']',
);
my $first_line = 1;

while (<>) {
    if ( $first_line ) {
        $first_line = 0;
        next;
    }

    chomp;
    my @in = split //,$_;

    #print "$_\n";
    print is_valid(@in) ? "YES\n" : "NO\n";
}

sub is_valid {
    my @in = @_;

    # return valid if list is empty
    return 1 if !scalar(@in);

    # not valid if character count is odd
    return 0 if scalar(@in) % 2;

    my $open_chr  = shift @in;
    my $close_chr = $match_tbl{$open_chr};
    my $closed    = 0;
    my $skip      = 0;
    my @inner;
    while (@in) {
        my $chr = shift @in;
        if ( $chr eq $open_chr ) {
            $skip++;
        } elsif ( $chr eq $close_chr ) {
            if ($skip) {
                $skip--;
            } else {
                $closed = 1;
                last;
            }
        } else {
            push @inner,$chr;
        }
    }

    # not valid if we can't close this bracket
    return 0 unless $closed;

    # not valid if inner set of characters isn't valid
    if (@inner and !is_valid(@inner)) {
        return 0;
    }

    # not valid if characters outside current brace set aren't valid
    if (@in and !is_valid(@in)) {
        return 0;
    }

    # valid
    return 1;
}
