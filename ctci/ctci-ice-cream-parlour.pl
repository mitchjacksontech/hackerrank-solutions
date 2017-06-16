#!/usr/bin/env perl

# Hacker Rank ctci-ice-cream-parlour
#  https://www.hackerrank.com/challenges/ctci-ice-cream-parlor
#
# mitch@mitchjacksontech.com
#
# Find the purchasable pair of ice cream flavors by implementing a
# binary search through the costs of all flavors
#
# First Attempt:
#   I'm not sure this will be fast enough.


use strict;
my @in; push @in,$_ for <>; chomp for @in;
VISIT: for (1..shift @in) {
    my $money = shift @in;

    my $flavor_count = shift @in;
    my $id = 1;

    # Build a sorted list of ID and COST for each flavor whose
    # cost does not exceed $money
    my @flavors = sort{$a->{cost} <=> $b->{cost}}
                  grep{ $_->{cost} < $money }
                  map{ {id=>$id++, cost=>$_} }
                  split(/ /,shift @in);

    # use Data::Dumper qw(Dumper);
    # print Dumper(\@flavors);
    #
    # print "There are ".scalar(@flavors)." flavors\n";

    my @pair = find_purchasable_pair(\@flavors,$money);
    print join ' ',@pair;
    print "\n";
}



sub find_purchasable_pair {
    # return a sorted list of two id values whose costs together
    # sum to $money

    my $flavors = $_[0];
    my $money   = $_[1];

    for my $i (0..@{$flavors}-1) {
        my $target = $money - $flavors->[$i]->{cost};
        # print "=========\n";
        # print "\$i: $i\n";
        # print "\$money: $money\n";
        # print "\$target: $target\n";
        my $t_id = bfsearch($flavors,$target,$i+1,scalar(@{$flavors})-1);
        if ($t_id) {
            return sort{$a<=>$b}($flavors->[$i]->{id}, $t_id);
        }
    }
}



sub bfsearch {
    # Recursive binary search through the flavors data structure
    # Return the id value of the flavor whose cost matches $target

    my $flavors = $_[0];
    my $target  = $_[1];
    my $left    = $_[2];
    my $right   = $_[3];

    return undef if $left > $right;

    my $mid = int(($left+$right)/2);

    # print "\$left:   $left\n";
    # print "\$right:  $right\n";
    # print "\$mid:    $mid\n";
    # print "\$target: $target\n";
    # print "\n";

    my $mid_val = $flavors->[$mid]->{cost};
    if ($mid_val < $target) {
        return bfsearch($flavors,$target,$mid+1,$right);
    } elsif ($mid_val > $target) {
        return bfsearch($flavors,$target,$left,$mid-1);1
    } else {
        # print "Found value: $mid\n";
        # print "Found value id: $flavors->[$mid]->{id}\n";
        return $flavors->[$mid]->{id};
    }
}
