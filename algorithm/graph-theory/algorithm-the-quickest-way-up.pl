#!/usr/bin/perl
use strict;

# mkjacksontech@gmail.com
# https://www.hackerrank.com/challenges/the-quickest-way-up
#
# My first time playing with Graph Theory.
# Approaching with the Breadth First Search BFS algorithm

my $t;         # Number of test cases
my @test_case; # collect test case data

my @in; push @in, $_ for (<STDIN>); chomp(@in);
$t = shift @in;
while ( @in ) {
    my %case;
    for ( 1..shift(@in)) {
        my ( $src, $dst ) = split / /, shift @in;
        $case{$src} = $dst;
    }
    for ( 1..shift(@in)) {
        my ( $src, $dst ) = split / /, shift @in;
        $case{$src} = $dst;
    }
    push @test_case, \%case;
}


# Solve test cases
#   %square
#     id
#     next
#     parent
#     level
#   )
for my $case (@test_case) {
    my %case = %{$case};
    my @v = ({  # pad element 0, so arr index and square number match
        level => undef,
        parent => undef,
        edges => [],
        square => 0,
    });
    for my $i (1..100) {
        my $v =  {
            level  => undef,
            parent => undef,
            edges  => [],
            square => $i,
        };
        if ( $i < 94 ) {
            push  (@{$v->{edges}}, ($i+$_)) for (1..6);
        }
        elsif ( $i < 100 ) {
            push @{$v->{edges}}, $i+$_ for (1..100-$i);
        }
        push @v, $v;
    }
    for my $k ( keys %case ) {
        for my $v ( @v ) {
            for my $e ( @{$v->{edges}} ) {
                if ($k == $e) {
                    $e = $case{$k};
                }
            }
        }
    }
    
    $v[1]->{level} = 0;
    my $level = 0;
    while ( !$v[100]->{parent} ) {
        for my $square ( @v ) {
            next unless $square->{level} eq $level;
            for my $e ( @{$square->{edges}} ) {
                next if $v[$e]->{parent};
                $v[$e]->{parent} = $square->{square};
                $v[$e]->{level}  = $level+1;
            }
        }
        $level++;
        last if $level > 10000;
    }
    
    if ($v[100]->{parent}) {
        my $moves  = 0;
        my $square = 100;
        while ($square ne 1) {
            $moves++;
            $square = $v[$square]->{parent};
        }
        
        print "$moves\n";
    }
    else {
        print "-1\n";
    }
    
        
}

