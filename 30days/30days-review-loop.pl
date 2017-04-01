#!/usr/bin/perl
use strict;

my @in; push @in,$_ for <STDIN>; chomp(@in);
my $t = shift @in;
for my $phrase ( @in ) {
    my @p = split //, $phrase;
    my @even;
    my @odd;
    for my $i ( 0..scalar(@p-1)) {
        if ( $i % 2 ) {
            push(@even,$p[$i]);
        } else {
            push(@odd,$p[$i]);
        }
        
    }
    print join( '', @odd)." ".join('', @even)."\n";
}

