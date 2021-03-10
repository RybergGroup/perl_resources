#! /usr/bin/perl -w

# This script prints the reverse complementary of a sequence using BioPerl
# Input sequence file should be first argument
# Output to STDOUT

use strict;

use Bio::SeqIO; #import module

my $in = Bio::SeqIO->new(-file => $ARGV[0],-format => 'Fasta'); # object for input

my $out = Bio::SeqIO->new(-fh => \*STDOUT, -format => 'Fasta'); # object for output

while ( my $seq = $in->next_seq() ) { # read sequence to sequence object
    $out->write_seq($seq->revcom()); # -> to access object functions
}
