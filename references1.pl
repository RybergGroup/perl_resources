#! /usr/bin/perl -w

# This script demonstrates references (but could easily had been implemented without references)
# It will read a file into memory and print all rows that include the text monticola

use strict;

my @fasta = <>;

chomp @fasta;

my @refs;

for (my $i=0; $i < scalar @fasta; ++$i) { # for each row
    if ($fasta[$i] =~ /monticola/) { # if sequence name include monticola
	push @refs, \$fasta[$i]; # Get ref to row	
    }
}

foreach my $ref (@refs) {
    print ${$ref}, "\n"; # Dereference
}
