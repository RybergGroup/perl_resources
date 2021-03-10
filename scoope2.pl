#! /usr/bin/perl -w

# This script demonstrates scoop in a loop

use strict;

my $global;

for (my $i = 0; $i < 10; ++$i) {
    my $local;
    ++$global;
    ++$local;
    print "$i - $global - $local\n"; # Is a string, so - is not an operator
}

