#! /usr/bin/perl -w

# This script will read a fasta file into memory
# and print given columns. Sequence order is not kept
# First argument - Fasta file (required)
# Second argument - First column (integer; optional)
# Third argument - Last column (integer; optional)
 

use strict;

# Read fasta file
open my $INPUT, "<$ARGV[0]" or die "Could not open $ARGV[0]: $!.\n";
my @fasta = <$INPUT>;
close $INPUT;
chomp @fasta;

my %seq_matrix; # Hash for sequences arrays
my $name;

while (defined(my $line = shift @fasta)) { # get each line from the fasta file
    if ($line =~ s/^>//) { # if a name, save it
	$name = $line;
	$seq_matrix{$name} = []; # create array reference
    }
    else {
	push (@{$seq_matrix{$name}}, split(//, $line)); # save sequence as array
    }
}

my $start = 0;

if (scalar @ARGV > 1 && $ARGV[1] >= 1) { # If start value given
    $start = $ARGV[1] -1;
}

my $end;

if (scalar @ARGV > 2 && $ARGV[2] >= 1) { # If end value given
    $end = $ARGV[2];
}

foreach $name (keys %seq_matrix) {
    print ">$name";
    my $length;
    if (defined $end) { $length = $end; } # If end value given
    if ( !defined $end || $length > scalar @{$seq_matrix{$name}}) { $length = scalar @{$seq_matrix{$name}}; } # If end not given or end larger than sequence length
    for (my $i=$start; $i < $length; ++$i) { # Print bases from start to end
	if (!(($i-$start) % 50)) { print "\n"; } # 50 residues per line
	print $seq_matrix{$name}->[$i]; # Dereference and print sequence residue
    }
    print "\n";
}
