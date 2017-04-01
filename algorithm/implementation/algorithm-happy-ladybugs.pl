#!/usr/bin/perl
my @in;push @in,$_ for (<STDIN>);chomp(@in);
my $g = shift @in;
BUGS: while (@in) {
    my $size = shift @in;
    my @bugs = split //, shift @in;
    my %bugs;
    $bugs{$_}++ for @bugs;
#print join "",@bugs;
#print " size: $size\n";
    # IF there are no line items at all
    if ( $size < 1 ) {
        print "NO\n";
        next BUGS;
    }
    
    # if @bugs is only one bug long, and not a _
    if ( scalar(@bugs) eq 1 && $bugs[0] ne '-' ) {
        print "YES\n";
        next BUGS;
    }
    
    # what if there are no unhappy bugs?
    if ( keys %bugs < 2 && exists $bugs{'_'} ) {
        print "YES\n";
        next BUGS;
    }

    # check if the bugs are already all happy
    my $already_happy = 1;
    for my $i ( 0..$size-1 ) {
        if ( $bugs[$i] ne '-' ) {
            if ( $i > 0 && $i < $size-1) {
                if ( $bugs[$i] ne $bugs[$i-1] && $bugs[$i] ne $bugs[$i+1] ) {
                    $already_happy = 0;
                } elsif ( $i eq 0 && $bugs[$i] ne $bugs[$i+1] ) {
                    $already_happy = 0;
                } elsif ( $i eq $size-1 && $bugs[$i] ne $bugs[$i-1] ) {
                   $already_happy = 0;
                }
            }
        
        }
    }
    if ( $already_happy ) {
        print "YES\n";
        next BUGS;
    }
    
    
    # can't move bugs w/o empty spaces
    unless ( exists ( $bugs{'_'})) {
        print "NO\n";;
        next BUGS;
    }

    # Lone bugs can't be made happy
    for my $k ( keys %bugs ) {
        if ( $bugs{$k} < 2 && $k ne '_' ) {
            print "NO\n";
            next BUGS;
        }
    }

    print "YES\n"; # unknown case 50/50 guess
} #BUGS

