#! /usr/bin/perl -w

# First argument should be a GFF3 formated file, but without any comment
# rows, and no blank rows. Name of output file is optional second argument.
# If output file name is not given, output will be directed to STDOUT

use strict;

# The convention is to use all CAPITAL letters for file handles
# File handles can be variables or bare words
open INPUT, "<", $ARGV[0] or die "Could not open $ARGV[0]: $!.\n";
my $OUTPUT; # Global variable
if ($ARGV[1]) {
    open $OUTPUT, '>', $ARGV[1] or die "Could not open $ARGV[1]: $!.\n";	
}
else { # If no file name given for output
    $OUTPUT = *STDOUT; # Use STDOUT
}

while (my $row = <INPUT>) { # Read row by row
    my @fields = split /\t/, $row; # Get tab delimited columns
    if (defined($fields[2])) { # If third column exist
	if ($fields[2] eq 'gene') {
	    print $OUTPUT "$fields[0] have a gene at position $fields[3]-$fields[4]\n";
	}
    }
    elsif (!defined($fields[0])) { # No first column
	print STDERR "Empty row!\n";
    }
    else { print STDERR "File format error!\n" }
}
