#!/usr/bin/perl
use strict;
use Storable 'dclone';

=head Click-o-Mania
https://www.hackerrank.com/challenges/click-o-mania

mkjacksontech@gmail.com

This is really just a puzzle about data structures.  
There's two challenges here:

First, Model the board in a usable way
Second, Implement an algorithm to find a solution 

The Board, Squares and Pieces are modeled as perl objects

I fumbled with several convoluted procedures and data
structures in attempts to solve large boards within the
execution time limit.  When my dumb brain was ready, and
distracted with the season premier of the walking dead,
the recursive algorithm nearly wrote itself.  It was a
tenth the lines of code, and much faster.

Pieces to pull have been 'first in, first pulled.' Let's get
a little more choosy, and order the pieces as larger gets
pulled first.

=cut

my @in; push @in,$_ for <STDIN>; chomp @in;

my $board = new Board(@in);
recur_try_board($board, $board->moves_available);


sub recur_try_board {
    my $board = shift;
    my @moves = @_;
    for my $m ( @moves ) {
        my $iboard = dclone($board);
                
        $iboard->remove_piece(@{$m});
        condition_met( $iboard->first_move ) if $iboard->is_solved;
        recur_try_board( $iboard, $iboard->moves_available );
    }
}
exit;




# condition_met(row,col)
# THE SHORTED PATH THE SOLUTION IS FOUND
# print the NEXT move on this path to STDOUT and terminate program
sub condition_met {
    my $row = shift;
    my $col = shift;
    print "$row $col\n";
    exit;
}

=head2 Board object

RANT:
 Since NONE of the perl built-ins for object oriented perl programming
 are avaialble on hackerrank, we'll go old-school here for object properties.
 Why must you pretend perl isn't an OO language hackerrank? Don't be Dorks.
 
Accesors:

Methods:
  board_as_stdin(@in): array of chomped STDIN lines as specified
 
=cut
package Board {
    use parent -norequire, 'PerimusGetSet';
    
    sub row_count    { my $self=shift; $self->_getset('row_count', @_) }
    sub column_count { my $self=shift; $self->_getset('column_count', @_) }
    sub color_count  { my $self=shift; $self->_getset('color_count', @_) }
    sub dfs_parent   { my $self=shift; $self->_getset('dfs_parent', @_) }
    sub dfs_level    { my $self=shift; $self->_getset('dfs_level', @_) }
    sub _board       { my $self=shift; $self->_getset('board', @_) }
    sub _pieces      { my $self=shift; $self->_getset('_pieces', @_) }
    sub _moves_available { my $self=shift; $self->_getset('_moves_available', @_) }
    sub _move_history    { my $self=shift; $self->_getset('_move_history', @_) }
    sub new {
        my $class = shift;
        my @in    = @_;
        
        my %obj = (
            row_count    => 0,
            column_count => 0,
            color_count  => 0,
            dfs_parent   => undef,
            dfs_level    => 0,
            
            _squares     => [],
            _pieces      => [],
            
            _moves_available => [],
            _move_history    => [],
        );
        
        my $self = bless \%obj;
        
        $self->board_from_stdin(@in) if @in;
        return $self;
    }
    
    
    sub board_from_stdin {
        my $self = shift;
        my @in = @_;
        
        # unpack first row of STDIN
        my @c = split / /, shift @in;
        $self->row_count(shift @c);
        $self->column_count(shift @c);
        $self->color_count(shift @c);
        
        # create 2d array of board txt values
        my @b;
        for my $row ( 0..$self->row_count()-1 ) {
            push @b,[split //,shift @in];
        }
    
        # create 2d array of Square objects
        my @b_sq;
        for my $row ( 0..$self->row_count()-1) {
            push @b_sq,[];
            for my $col ( 0..$self->column_count()-1) {
                my $sq = Square->new(
                    col => $col,
                    row => $row,
                    color => $b[$row]->[$col],
                    board => $self,
                );
                push @{$b_sq[$row]},$sq;
            }
        }
        $self->_board(\@b_sq);
        
        # create list of pieces objects
        $self->reset_pieces();

    }
    
    
    # board->remove_piece(row,col)
    #
    # Remove a piece from the board,
    # sink remaining peices to the bottom and left as described
    # reanalize new boad configuration
    sub remove_piece {
        my $self = shift;
        my $row  = shift;
        my $col  = shift;

        my $p = $self->piece_at($row,$col);
        
        # Record this move of the board
        $self->add_move_history( $row,$col );
        
        # set each square in the piece as empty
        $_->color('-') for $p->squares;
        
        # walk through the columns and sink pieces
        for my $col ( 0..$self->column_count()-1 ) {
            my @colors;
            
            # read colors before drop
            for my $row ( 0..$self->row_count()-1 ) {
                push @colors, $self->square_at($row,$col)->color;
            }
            
            # remove empty squres from the array, effectively 'dropping' the
            # colored squres together
            @colors = grep{ $_ ne '-' } @colors;

            # Pad the front of the array with empty space until it is
            # the correct length.
            while ( @colors < $self->row_count() ) {
                unshift( @colors,'-');
            }
            
            # Write the color values back onto the board squares
            for my $row ( 0..$self->row_count()-1 ) {
                $self->square_at($row,$col)->color($colors[$row]);
            }
        }
        
        # shift board to the left to fill empty columns
        #
        # determine which columns are empty
        my @empty_cols;
        for my $col ( 0..$self->column_count()-1 ) {
            my $is_empty = 1;
            for my $row ( 0..$self->row_count()-1) {
                if ( $self->square_at($row,$col)->color() ne '-') {
                    $is_empty = 0;
                }
            }
            push @empty_cols,$col if $is_empty;
        }

        # shift any piece on the board left one column if it's column
        # value is greater than the specified empty column
        # ** relys on board::all_squares() returning squares in
        #    order left to right, up to down.  what could go wrong
        for my $col ( reverse @empty_cols ) {
            for my $sq ( $self->all_squares ) {
                if ( $sq->col > $col ) {
                    $self->square_at($sq->row(),$sq->col()-1)->color($sq->color);
                    $sq->color('-');
                }
            }
        }
        
        # Rebuild piece information from new board configuration
        $self->reset_pieces();
        
    } # end Board::remove_piece()
    
    
    # $board->reset_pieces()
    #
    # Clear all data on piece orientation, and rebuild it from the
    # current board data.
    sub reset_pieces {
        my $self = shift;

        # Remove pieces from the board
        $self->_pieces([]);
        
        # remove pieces from all squares
        $_->piece('undef') for $self->all_squares;
        
        # Generate piece objects for each !empty board square
        for my $sq ( $self->all_squares ) {
            if ( !ref $sq->piece and $sq->color ne '-') {
                my $p = Piece->new(
                    square => $sq,
                    board  => $self,
                );
            }
        }
                
        # Store the list of possible moves we could try
        $self->_moves_available([
            map{ [ $_->row, $_->col ] }
            map{ $_->a_square() }
            sort { scalar($b->squares) <=> scalar($b->squares) }
            ( $self->all_playable_pieces )
        ]);
    }
    
    
    # @squares = $board->all_squares()
    sub all_squares {
        my $self = shift;
        my @all_squares;
        for my $row ( 0..$self->row_count()-1) {
            push @all_squares, @{ $self->_board->[$row] };
        }
        return @all_squares;
    }

    
    sub square_at   {
        my( $self, $row, $col ) = @_;
        return $self->_board->[$row]->[$col];
    }
    
    
    sub all_pieces  {
        my $self = shift;
        return @{ $self->_pieces() };
    }
    
    
    sub all_playable_pieces {
        my $self = shift;
        return grep { scalar($_->squares) > 1 } @{$self->_pieces()};
    }
    
    
    sub piece_at    {
        my ( $self, $row, $col ) = @_;
        return $self->square_at($row,$col)->piece();
    }
    
    
    sub add_piece {
        my ( $self, $p ) = @_;
        push @{ $self->_pieces() }, $p;
    }
    
    
    sub as_txt {
        my $self = shift;
        my $txt;
        for my $row (0..$self->row_count()-1) {
            $txt.= join " ", map{ $_->color } @{ $self->_board->[$row] };
            $txt.= "\n";
        }
        return $txt;
    }
        
    # ( $row, $col ) = board->first_move()
    sub first_move {
        my $self = shift;
        return @{ $self->_move_history()->[0] };
    }
    
    
    # @([$row,$col],...) = board->moves_available()
    sub moves_available {
        return @{ $_[0]->_moves_available };
    }
    
    
    sub next_available {
        return shift @{$_[0]->_moves_available };
    }
    
    
    # board->add_move_history(row,col)
    sub add_move_history {
        my ( $self, $row, $col ) = @_;
        push @{ $self->_move_history },[$row,$col];
    }
    
    
    # @([$row,$col]...) = board->move_history()
    sub move_history {
        return @{ $_[0]->_move_history };
    }
    
    # if there are no pieces on the board, it's solved
    sub is_solved {
        my $self = shift;
        #for my $sq ( $self->all_squares ) {
        #    return 0 unless $sq->is_empty;
        #}
        #return 1;
        return scalar( $self->all_pieces ) > 0 ? 0 : 1;
    }
}



=head1 Piece object

When this object is instantiated, it's passed a board_ref and a square_ref.
It will scan the board for any squares that should be considered also a part
of this game piece.  Then it will update all those square's piece attribute

=cut
package Piece {
    use parent -norequire, 'PerimusGetSet';
    
    sub _squares { my $self=shift; $self->_getset('_squares', @_) }
    sub new {
        my $class = shift @_;
        my %p     = @_;
        my %obj;

        my $board = $p{board};
        my $sq1    = $p{square};
        
        $obj{board} = $board;
        $obj{_squares} = [$sq1];
        
        # create an instance
        my $self = bless \%obj;

        # Add the piece to the first square
        $sq1->piece($self);
        
        # Add the piece to the board
        $board->add_piece($self);
        
        my @exam = ($sq1);
        while ( @exam ) {
            my $sq = shift @exam;

            for my $sq_n ( $sq->neighbors ) {
                if ( !ref $sq_n->piece && $sq_n->color eq $sq->color ) {
                    push @exam, $sq_n;
                    $sq_n->piece( $self );
                    push @{$self->_squares},$sq_n;
                }
            }
        }
        
        return $self;
    }
    
    
    # @squares = $Piece->squares()
    sub squares { 
        my $self = shift;
        return @{ $self->_squares };
    }
    
    # $sq = Piece->a_square()
    sub a_square {
        my $self = shift;
        return $self->_squares()->[0];
    }
}


=head1 Square

Square object representing one square of the game grid

=cut
package Square {
use parent -norequire, 'PerimusGetSet';
    
    sub row      { my $self=shift; $self->_getset('row', @_) }
    sub col      { my $self=shift; $self->_getset('col', @_) }
    sub color    { my $self=shift; $self->_getset('color', @_) }
    sub piece    { my $self=shift; $self->_getset('piece', @_) }
    sub board    { my $self=shift; $self->_getset('board', @_) }
    
    # my $square = new Square( %parameters )
    sub new {
        my $class = shift;
        my %parms = @_;
     
        my %defaults = (
            row         => undef,
            col         => undef,
            color       => undef,
            piece       => undef,
            board       => undef,
        );
        
        for my $k ( keys %defaults ) {
            $parms{$k} = $defaults{$k} unless exists $parms{$k};
        }
        
        my $self = bless \%parms;
        return $self;
    }
    sub is_empty {
        my $self = shift;
        return defined $self->color ? 0 : 1;
    }
    # my [$sq|undef] = $Square->get_rel([left|up|right|down]);
    sub get_rel {
        my ( $self, $dir ) = @_;
        if ($dir eq 'left') {
            return undef if $self->col eq 0;
            return $self->board->square_at($self->row(), $self->col-1);
        } elsif ($dir eq 'right') {
            return undef if $self->col eq $self->board->column_count - 1;
            return $self->board->square_at($self->row(), $self->col+1);
        } elsif ($dir eq 'up' ) {
            return undef if $self->row eq 0;
            return $self->board->square_at($self->row()-1, $self->col);
        } elsif ($dir eq 'down' ) {
            return undef if $self->row eq $self->board->row_count()-1;
            return $self->board->square_at( $self->row()+1, $self->col);
        }
        die("get_rel($dir): invalid direction '$dir'");
    }
    sub neighbors {
        my $self = shift;
        return grep { ref $_ } map { $self->get_rel($_) } qw(left up right down);
    }
}

# Parent object providing _getset()
package PerimusGetSet {
    sub new {}
    sub _getset {
        my $self = shift;
        my $key  = shift;
        $self->{$key} = shift if @_;
        return $self->{$key};
    }
}

