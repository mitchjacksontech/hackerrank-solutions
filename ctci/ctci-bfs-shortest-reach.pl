#!/usr/bin/perl
use strict;

# Hacker Rank ctci-bfs-shortest-reach
#
# mitch@mitchjacksontech.com
# https://www.hackerrank.com/challenges/ctci-bfs-shortest-reach
#
# * Build graphs in memory from the given input.
# * Walk the graph with a BFS appraoch to find the distance
#   of each reachable node from the starting node
# * Output the distances of the nodes
#
# While performing a BFS, we must pay special attention to what
# depth each node is searched from.  Let's do this with a recursive
# function that operates one iteration per queue depth

my $q = <>;chomp $q; # number of queues
for (1..$q) {
    # Build the graph into @graph as: $graph[$node]={...}
    # To simplify reading, the @graph array will have an unused
    # element [0]
    my @graph;
    my ($nodes, $edges) = split / /,<>; chomp $edges;
    for (1..$nodes){
        $graph[$_] = {
            edges    => [],
            distance => -1,
            visited  => 0
        };
    }
    for (1..$edges) {
        my $in = <>;chomp $in;
        my ($u, $v) = split / /,$in;
        push @{$graph[$u]{edges}},int($v);
        push @{$graph[$v]{edges}},int($u);
    }
    my $start = <>;chomp $start;

    find_distances_from(\@graph,$start);

    # Print the distance to each node except the starting node
    # (statements like the following are the joy of perl programming)
    print join(' ',grep {$_ != 0} map {@graph[$_]->{distance}} (1..$nodes))."\n";
}


sub find_distances_from {
    my ($graph, $start) = @_;
    my $queue = [$start];
    my $distance = 0;
    while (@$queue) {
        $queue = __bfswalk($graph,$queue,$distance);
        $distance += 6;
    }
}


sub __bfswalk {
    my ($graph,$queue,$distance) = @_;
    my @nqueue;
    for my $i (@$queue) {
        my $n = @$graph[$i];
        next if $n->{visited};

        $n->{distance} = $distance;
        $n->{visited}  = 1;
        push @nqueue,@{$n->{edges}};
    }
    return \@nqueue;
}
