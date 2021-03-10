#! /usr/bin/perl -w

# This script takes a file in fasta format as first argument
# the file is aligned using mafft (needs to be installed separately
# in right folder)
# and displayed using aliview (should be installed in a folder in your PATH)

use strict;

# Run mafft
system "C:/Users/Martin/programs/mafft-win/mafft.bat $ARGV[0] > $ARGV[0].aln.fst";

# Open alignment in AliView and terminate script
exec "aliview $ARGV[0].aln.fst";
