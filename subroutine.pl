#!/usr/bin/perl -w
use strict;

# This script reverse complement sequences in a fasta file

my $dna;

# Read file line by line into Perl default scalar
while (<>) {
    chomp;
    if (/^>/) { # Sequence name
	if ($dna) { print &revcomp($dna), "\n"; } # Use subroutine
	undef $dna;
	print "$_\n";
    }
    else { $dna .= $_; }
}
if ($dna) {
    print &revcomp($dna),"\n";
}

### Subroutines ###
sub revcomp {
    my $dna = shift @_; # parameters passed to the sub
    $dna = reverse $dna; # reverse sequence
    $dna =~ tr/ACGTacgt/TGCAtgca/; # translate is similar tu substitute but does the substitutions simultaneously
    return $dna;
}
