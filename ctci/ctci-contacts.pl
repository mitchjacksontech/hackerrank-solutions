#!/usr/bin/env perl

=head1 Hacker Rank ctci-contacts

    mitch@mitchjacksontech.com
    https://www.hackerrank.com/challenges/ctci-contacts

=head1 Comments

    This solution implements a Trie node search variant.
      Re: https://en.wikipedia.org/wiki/Trie

     I'm struck by how fast this approach is.  I've never implemented a node-tree
     algorithm in a work project.  I wanted to find out just how much faster this
     approach is than a brute-force implementation of building and search an array.

     time() reults for both approaches with a 100,000 entry sample data set

     Trie search:
         real	0m1.643s
         user	0m1.425s
         sys	0m0.183s

     Brute borce search:
        real	12m5.011s
        user	11m47.268s
        sys	    0m4.371s

    Trie solution is ~442x faster

=head1 Challenge

    My first attempt failed test case 12 because of memory usage at 541MB.
    I altered the way leaves are stored in the data structure:
    before: $node->{leaves}->{$character}
    after:  $node->{$character}

    Removing the unnecessary hash reference on every node brought memory
    usage down to 339MB.  This also sped up the processing time by 25%.

=cut

use strict;

my $trie = {
    data   => undef,
    wc     => 0,
};

inloop: while (<>) {
    chomp;
    ( my $cmd, my $val ) = split / /, $_;
    if ( $cmd eq 'add' ) {
        my $node = $trie;
        for my $ch ( split //,$val ) {
            if ( exists $node->{$ch} ) {
                $node = $node->{$ch};
                $node->{wc}++;
            } else {
                $node->{$ch} = {
                    data   => $ch,
                    wc     => 1,
                };
                $node = $node->{$ch};
            }
        }
    } elsif ( $val ) {
        my $node = $trie;
        for my $ch ( split //,$val ) {
            if ( exists $node->{$ch} ) {
                $node = $node->{$ch};
            } else {
                print "0\n";
                next inloop;
            }
        }
        print "$node->{wc}\n";
    }
}


# Find size of data structure in memory:

# test1: 541,372,528
# test2: 339,470,080
#

# use Devel::Size qw/size total_size/;
# print "Total Size \$trie: ".total_size($trie)."\n";


# Quite slow regex brute-force solution
# my @contacts;
# while (<>) {
#     chomp;
#     my ( $cmd, $val ) = split / /,$_;
#     if ( $cmd eq 'add' ) {
#         push @contacts,$val;
#     }
#     elsif ( $val ) {
#         my $found = 0;
#         for my $c ( @contacts ) {
#             if ( $c =~ /^$val/ ) {
#                 $found++;
#             }
#         }
#         print "$found\n";
#     }
# }
