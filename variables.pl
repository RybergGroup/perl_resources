#! /usr/bin/perl -w

# This script calculates the number of occurrences of each distinct value in the first column of a tab-separated table

use strict;

# when using strict all variables need to be defined with my
# = is used to assign values to variables

my %categories; # hash - indexed by string

while (my $row = <>) { # scalar - string or number
    my @columns = split /\t/, $row; # array - indexed by number 0-
    ++$categories{$columns[0]};
}

foreach my $key (keys %categories) {
    print "$key - $categories{$key}\n";
}
