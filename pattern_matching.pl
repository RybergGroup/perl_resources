#! /usr/bin/perl -w
# This script removes white space from sequence names in fasta files

use strict;

while (my $row = <>) { # read from file or STDIN
    chomp $row; # remove newline
    if ($row =~ /^>/) { # if FASTA seq name
	$row =~ s/\s+/_/g; # replace whitespace with _
    }
    print "$row\n"; # print to STDOUT
}
