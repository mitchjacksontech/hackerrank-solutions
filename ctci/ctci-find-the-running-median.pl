#!/usr/bin/env perl
use strict;
no strict 'refs';

=head1 Hacker Rank ctci-find-the-running-median

    mitch@mitchjacksontech.com
    https://www.hackerrank.com/challenges/ccti-find-the-running-median

=head1 Comments

    I'm re-solving this problem with perl, to solve as was intended:
    Implementing the heap algorithms by hand, as we'd never do irl.

    The editorial for the problem reveals a clever approach.  Solve the
    problem of heap values not saying perfectly sorted by keeping twso
    heaps: a min-heap and max-heap.  The median value(s) are always at
    the root of the heaps when balanced properly.

    Don't get to see oo perl on hackerrank often.  I hope this is fast enough
    without refactoring.

=cut

my $skip_first_line = 1;
my $heap = new MedianHeap();
while (<>) {
    if ($skip_first_line) { $skip_first_line = 0; next }
    chomp;
    $heap->add($_);
    printf "%.1f\n",$heap->median();
}


exit;



# It's possible that I am a bit paranoid about my implementation...
#
# Generate 1000 random integers under 65535, and add to the min-heap and max-heap.
# Verify the root number is always the min/max
# repeat this 100 times
# sub test_heap {
#     my $success = 0;
#     my $fail    = 0;
#     for ( 0..99 ) {
#         my $min_heap = new Heap('min');
#         my $max_heap = new Heap('max');
#
#         my @numbers;
#         my $min;
#         my $max;
#         for ( 0..999 ) {
#             my $n = int(rand(65534))+1;
#             $min = $n unless $min;
#             $min = $n if $n < $min;
#             $max = $n if $n > $max;
#             $min_heap->add($n);
#             $max_heap->add($n);
#         }
#         print "\$min: $min\n";
#         print "\$max: $max\n";
#         print "\$min_heap root node: ".$min_heap->peek()."\n";
#         print "\$max_heap root node: ".$max_heap->peek()."\n";
#
#
#         if ( $min == $min_heap->peek() ) {
#             $success++;
#         } else {
#             $fail++;
#         }
#
#         $max == $max_heap->peek() ? $success++ : $fail++;
#     }
#
#     print "Successes: $success\n";
#     print "Failures: $fail\n";
# }


# It's also possible i'm a bit paranoid about my implementation...
# more excessive accuracy testing
#
# sub test_median_heap {
#     my $success = 0;
#     my $failure = 0;
#     for ( 0..99 ) {
#         my $h = new MedianHeap();
#         my @n;
#         for ( 0..int(rand(4000))+999 ) {
#             my $n = int(rand(65534))+1;
#             push @n,$n;
#             $h->add($n);
#         }
#         @n = sort { $a <=> $b } @n;
#
#         my $arr_m;
#         if ( @n % 2 ) {
#             $arr_m = $n[int(@n/2)];
#         } else {
#             $arr_m = ($n[int(@n/2)-1]+$n[int(@n/2)])/2;
#         }
#
#         my $obj_m = $h->median();
#
#         # print join(" ",@n)."\n";
#         # $arr_m = sprintf("%.1f",$arr_m);
#         # $obj_m = sprintf("%.1f",$obj_m);
#         # print "Arr Median: $arr_m \n";
#         # print "Obj Median: $arr_m \n";
#
#         if ( $arr_m == $obj_m ) {
#             $success++;
#         } else {
#             $failure++;
#             print "Failure\n";
#             print "Arr Median: $arr_m \n";
#             print "Obj Median: $arr_m \n";
#             print "\n";
#         }
#
#
#     }
#
#     print "Successes: $success\n";
#     print "Failures: $failure\n";
# }

# Implements a running-median using a min-heap and max-heap
package MedianHeap;
sub new {
    my $class = shift;
    my %obj = (
        left_heap => new Heap('max'),
        right_heap => new Heap('min'),
    );
    my $self = bless \%obj;
    return $self;
}
sub add {
    my ($self, $val) = @_;

    if (!$self->{left_heap}->size()) {
        $self->{left_heap}->add($val);
# print "1: Add $val to left\n";
    }
    elsif ($val <= $self->{left_heap}->peek()) {
# print "2: Add $val to left\n";
        $self->{left_heap}->add($val);
        $self->rebalance();
    }
    elsif ($val >= $self->{right_heap}->peek()) {
# print "3: Add $val to right\n";
        $self->{right_heap}->add($val);
        $self->rebalance();
    }
    elsif ($self->{left_heap}->size() > $self->{right_heap}->size()) {
# print "4: Add $val to right\n";
        $self->{right_heap}->add($val);
    }
    else {
        $self->{left_heap}->add($val);
# print "5: Add $val to left\n";
    }
}
sub rebalance {
    my ($self) = @_;
    my $left_heap = $self->{left_heap};
    my $right_heap = $self->{right_heap};
    my $left_size = $left_heap->size();
    my $right_size = $right_heap->size();

    return unless abs($left_size-$right_size) > 1;
# print "Rebalancing...\n";

    if ($left_size > $right_size) {
        $right_heap->add( $left_heap->poll() )
    } else {
        $left_heap->add( $right_heap->poll() )
    }
}
sub median {
    my ($self) = @_;
    my $left_size = $self->{left_heap}->size();
    my $right_size = $self->{right_heap}->size();

    if ($left_size == $right_size) {
        return ($self->{left_heap}->peek() + $self->{right_heap}->peek())/2;
    }
    elsif ($left_size > $right_size) {
        return $self->{left_heap}->peek();
    }
    else {
        return $self->{right_heap}->peek();
    }
}


# Implements a heap storage object of type min-heap or max-heap
package Heap;
sub new {
    my $class = shift;
    my $type  = shift || 'min';

    my $obj = {
        type  => $type,
        items => [],
    };
    my $self = bless $obj;
    return $self;
}

sub size { return scalar(@{$_[0]->{items}}) }
sub left_idx { return 2 * $_[1] + 1 }
sub right_idx { return 2 * $_[1] + 2 }
sub parent_idx { return int(($_[1]-1)/2) }

sub has_left {
    my ($self, $i) = @_;
    return $self->left_idx($i) < $self->size();
}
sub has_right {
    my ($self, $i) = @_;
    return $self->right_idx($i) < $self->size();
}
sub has_parent {
    my ($self, $i) = @_;
    return 1 if $i;
}

sub left {
    my ($self, $i) = @_;
    return $self->{items}->[$self->left_idx($i)];
}
sub right {
    my ($self, $i) = @_;
    return $self->{items}->[$self->right_idx($i)];
}
sub parent {
    my ($self, $i) = @_;
    return $self->{items}->[$self->parent_idx($i)];
}

sub peek { return $_[0]->{items}->[0] }
sub poll {
    my ($self) = @_;
    my $size = $self->size();
    return undef unless $size;
    my $root_val = $self->{items}->[0];
    if ( $size > 1 ) {
        $self->{items}->[0] = pop(@{$self->{items}});
        $self->heapify_down();
    } else {
        pop(@{$self->{items}});
    }
    return $root_val;
}
sub add {
    my ($self, $val) = @_;
    push @{$self->{items}},$val;
    $self->heapify_up();
}
sub swap {
    my ( $self, $i1, $i2 ) = @_;
    ($self->{items}->[$i1],$self->{items}->[$i2])
        = ($self->{items}->[$i2],$self->{items}->[$i1])
}

sub heapify_up {
    my ($self) = @_;
    return $self->__min_heapify_up() if $self->{type} eq 'min';
    return $self->__max_heapify_up();
}
sub __min_heapify_up {
    my ($self) = @_;
    my $i = @{$self->{items}}-1;
        while ($self->has_parent($i) && $self->parent($i) > $self->{items}->[$i] ) {
           $self->swap($i,$self->parent_idx($i));
           $i = $self->parent_idx($i);
       }
}
sub __max_heapify_up {
    my ($self) = @_;
    my $i = @{$self->{items}}-1;
        while ($self->has_parent($i) && $self->parent($i) < $self->{items}->[$i] ) {
           $self->swap($i,$self->parent_idx($i));
           $i = $self->parent_idx($i);
       }
}

sub heapify_down {
    my ($self) = @_;
    return $self->__min_heapify_down() if $self->{type} eq 'min';
    return $self->__max_heapify_down();
}
sub __min_heapify_down {
    my ($self) = @_;
    my $i = 0;

    while ($self->has_left($i)) {
        my $sm_i = $self->left_idx($i);
        $sm_i = $self->right_idx($i)
            if $self->has_right($i) && $self->right($i) < $self->left($i);

        if ($self->{items}->[$i] < $self->{items}->[$sm_i]) {
            last;
        }
        else {
            $self->swap($i,$sm_i);
        }

        $i = $sm_i;
    }
}
sub __max_heapify_down {
    my ($self) = @_;
    my $i = 0;
    while ($self->has_left($i)) {
        my $sm_i = $self->left_idx($i);
        $sm_i = $self->right_idx($i)
            if $self->has_right($i) && $self->right($i) > $self->left($i);

        if ($self->{items}->[$i] > $self->{items}->[$sm_i]) {
            last;
        }
        else {
            $self->swap($i,$sm_i);
        }

        $i = $sm_i;
    }
}
