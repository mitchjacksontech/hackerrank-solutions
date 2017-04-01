#!/usr/bin/perl
use strict;

my @in; push @in, <STDIN>; chomp @in;



package TicTacToe::Board {
    # $board = TicToeBoard->new( board => \@in, next_turn => 'X' );
    #    return a board object.  @in is array from STDIN for the
    #    hackerrank challenge.  Without parameters creates a blank
    #    board.
    sub new {
        my $class  = shift;
        my %params = @_;

        # defaults
        my %self  = (
            board        => [],
            next_turn    => 'X',
            moves_played => 0,
        );
        
        if ( defined $params{board} and ref $params{board} ) {
            push @{$self{board}},[ split //, $_ ] for @{ $params{board} };
            for ( @{$self{board}} ) {
                for ( @{ $_ } ) {
                    $self{next_turn}++ if $_ ne '_';
                }
            }
        }
        
        if ( defined $params{next_turn} ) {
            $self{next_turn} = $params{next_turn};
        }
        
        return bless \%self, $class;
    }
    
    
    sub get_row { return @{ $_[0]->{board}->[ $_[1] ] }}
    sub get_col {
        return (
            $_[0]->{board}->[0]->[ $_[1] ],
            $_[0]->{board}->[1]->[ $_[1] ],
            $_[0]->{board}->[2]->[ $_[1] ],
        )
    }
    sub get_diag {
        return $_[1] ? ( $_[0]->{board}->[0]->[0],
                         $_[0]->{board}->[1]->[1],
                         $_[0]->{board}->[2]->[2] )
                     : ( $_[0]->{board}->[0]->[2],
                         $_[0]->{board}->[1]->[1],
                         $_[0]->{board}->[2]->[0] );
    }
    
    
}
