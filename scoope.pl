#! /usr/bin/perl -w

# This script demonstrate different scoops

use strict;

my $variable = 'global'; # global variable

print $variable, "\n"; # print can take a list of arguments to print

{ # curly brackets define a block
    my $variable = 'local'; # variables defined in a block only exist in the block
    print $variable, "\n";
}

print $variable, "\n"; # local variables do not overwrite global variables
