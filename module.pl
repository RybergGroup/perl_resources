#!/usr/bin/perl -w
use strict;
use FindBin ();
use lib "$FindBin::Bin";
use my_bioinf; # load module

my $dna;

while (<>) {
    chomp;
    if (/^>/) {
	if ($dna) { print my_bioinf::revcomp($dna), "\n"; } # must give namespace before module name
	undef $dna;
	print "$_\n";
    }
    else { $dna .= $_; }
}
if ($dna) {
    print my_bioinf::revcomp($dna),"\n";
}
