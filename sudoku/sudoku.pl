#!/usr/bin/env perl

=head1 Suduko Challenge
https://www.hackerrank.com/challenges/sudoku
mkjacksontech@gmail.com
=cut

use strict;

my @in; push @in,$_ for <STDIN>; chomp @in;
my $n = shift @in;

for (1..$n) {
    my $board = new Sudoku(@in[0..8]);
    shift @in for 0..8;
    sudoku_solve($board);
    #$board->solve;
    #print $board->as_txt;
}

sub sudoku_solve {
    my $board=shift;
    $board->solve;
    print $board->as_txt;
}

package Sudoku {
    sub new {
        my $class = shift @_;
        my ( %self, @b);
        push @b, [split/ /,$_] for @_;
        $self{b} = \@b;
        return  bless \%self, $class;
    }
    
    sub solve {
        my $self = shift;
        my @sq;
        my $b = $self->{b};
        
        # create an array of all squares without values
        for my $r ( 0..8 ) {
            for my $c (0..8) {
                push @sq,Square->new(
                    row   => $r,
                    col   => $c,
                    value => 0,
                    b     => $b,
                ) if $b->[$r]->[$c] eq 0;
            }
        }
        
        my $sq_sz = scalar @sq;
        my $i     = 0;
        
        SLV: while ( $i < $sq_sz ) {
            my $sq   = $sq[$i];
            my $sq_v = $sq->{value};
            
            if ( $sq_v eq 9 ) {
                $sq->value(0);
                $i--;
                next SLV;
            }
            
            TV: for my $tv (($sq_v+1)..9 ) {
                if ($sq->test_value($tv)) {
                    $sq->value($tv);
                    $i++;
                    next SLV;
                }
            }
            
            $sq->value(0);
            $i--;
        }
        
    }
    
    
    sub as_txt {
        my $t;
        $t .= join(' ',@{$_})."\n" for @{$_[0]->{b}};
        return $t;
    }
}

package Square {
    
    sub value {
        my $self=shift;
        if ( defined $_[0] ) {
            $self->{b}->[$self->{row}]->[$self->{col}] = $_[0];
            $self->{value} = $_[0];
        }
        return $self->{value};
    }
    sub new {
        my $class = shift;
        my %self = @_;
        return bless \%self, $class;
    }
    
    sub test_value {
        my $self = shift;
        my $v    = shift;

        for ( $self->row_values ) { return 0 if $_ eq $v };
        for ( $self->col_values ) { return 0 if $_ eq $v };
        return 1;
    }
    
    sub row_values {
        my $self = shift;
        return @{ $self->{b}->[$self->{row}] }
    }
    sub col_values {
        my $self = shift;
        my $col  = $self->{col};
        return map { $self->{b}->[$_]->[$col] } 0..8;
    }
}

