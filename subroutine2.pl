#!/usr/bin/perl -w
use strict;

# This script reverse complement sequences in a fasta file

my $dna;

# Read file line by line into Perl's default scalar
while (<>) {
    chomp;
    if (/^>/) { # Sequence name
	if ($dna) { 
	    &revcomp(\$dna); # Send reference to sequence variable to subroutine
	    print $dna, "\n";
       	}
	undef $dna;
	print "$_\n";
    }
    else { $dna .= $_; }
}
if ($dna) {
    &revcomp(\$dna); # reverse complement last sequence
    print $dna, "\n";
}

### Subroutines ###
sub revcomp {
    my $dna = shift @_; # parameters passed to the sub, should be reference
    $$dna = reverse $$dna; # reverse sequence
    $$dna =~ tr/ACGTacgt/TGCAtgca/; # translate is similar tu substitute but does the substitutions simultaneously
}
