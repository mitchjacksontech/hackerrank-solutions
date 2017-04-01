#!/usr/bin/perl
use strict;

my $count = <STDIN>;
my @r; push @r, $_ while <STDIN>;
chomp($count,@r);

my @students;
push @students, {} for (1..$count);
for my $i ( 0..$count-1 ) {
    $students[$i]->{left}   = $i > 0        ? $students[$i-1] : undef;
    $students[$i]->{right}  = $i < $count-1 ? $students[$i+1] : undef;
    $students[$i]->{candy}  = 1;
    $students[$i]->{rating} = $r[$i];
}

# travel through list once forwards and once backwards
for my $s ( @students, reverse @students ) {
    # for both left and right side of student,
    # set candy to +1 of neighbor's candy if student
    # rates higher, and doesn't already have more candy
    for my $side ( 'left', 'right' ) {
        if (     defined $s->{$side} 
             and $s->{$side}->{rating} < $s->{rating}
             and $s->{$side}->{candy} + 1 > $s->{candy}
           ) {
            $s->{candy} = $s->{$side}->{candy} + 1;
        }
    }
}

# print results
my $total = 0;
$total += $_->{candy} for @students;
print "$total\n";


