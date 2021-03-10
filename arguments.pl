#! /usr/bin/perl -w

# This script demonstrates @ARGV, give arguments to it on the command line

use strict;

foreach (@ARGV) { # Array for arguments given to the program on the command line
    print "Argument: $_\n"; # Print by using Perl's default variable
}
