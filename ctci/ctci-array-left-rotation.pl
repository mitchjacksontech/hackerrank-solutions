#!/usr/bin/env perl
use strict;

=head1
mitch@mitchjacksontech.com
 https://www.hackerrank.com/challenges/ctci-array-left-rotation
 Cracking the Coding Interview: Array Left Rotation

Comments:
The lazy slow approach here would be to perform an array shift operation
inside a for loop.  Unnecessarily expensive.  Instead, let's build a new
array out of two slices of the original array.  The operation's cost is
the same regardless of the values provided.
=cut

# read input
my @in; push @in,$_ for <STDIN>; chomp for @in;
my ($size, $rotations) = split / /,shift @in;
my @arr = split / /,shift @in;

# disregard extra array rotations
$rotations = $rotations % $size if $rotations > $size;

# rebuild the array from two slices of itself
@arr = @arr[$rotations..(scalar(@arr)-1),0..($rotations-1)] if $rotations;

print join " ",@arr;
print "\n";
