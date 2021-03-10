#! /usr/bin/perl -w

use strict;

# This script aligns a fasta file (given as first argument) using mafft
# (needs to be installed in the right folder) and counts the number of
# gaps in each sequence

my @fasta = `C:/Users/Martin/programs/mafft-win/mafft.bat $ARGV[0]`; # run mafft and save the output in array

chomp @fasta;

my $n_gap;

for (my $i=0; $i <= scalar @fasta; ++$i) { # for each row +1
    if ($i == scalar @fasta || $fasta[$i] =~ s/^>//) { # if sequence name or after last row
	if (defined($n_gap)) { # if not first row
	    print "\t$n_gap\n";
	    $n_gap = 0;
	}
	if ($i < scalar @fasta) { print $fasta[$i]; } # if not after end of file
    }
    else {
	my @temp = split //, $fasta[$i]; # split sequence
	foreach (@temp) {
	    if ($_ eq '-') { ++$n_gap; } # if a gap, count it
	}
    }
}
