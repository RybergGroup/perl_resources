#! /usr/bin/perl -w

# This script will pars out a series of taxa in a fasta file
# Give the fasta file with -f or else the program will read from STDIN
# Set the output file with -o or else the program will print to STDOUT
# Give the sequences you want as a comma separated list with -q

use strict;

### Global variables ###
my $infile_name;
my $outfile_name;
my $OUTFILE_HANDLE;
my $INFILE_HANDLE;
my @taxa_to_print;
my $print_flag = 'n';

### Pars the arguments to the program ###
for (my $i=0; $i < scalar @ARGV; ++$i) {
    if (($ARGV[$i] eq '-f' or $ARGV[$i] eq '--file') and $i+1 < scalar @ARGV) {
	$infile_name = $ARGV[++$i];
    }
    elsif (($ARGV[$i] eq '-o' or $ARGV[$i] eq '--output') and $i+1 < scalar @ARGV) {
	$outfile_name = $ARGV[++$i];
    }
    elsif (($ARGV[$i] eq '-q' or $ARGV[$i] eq '--query') and $i+1 < scalar @ARGV) {
	@taxa_to_print = split /,/, $ARGV[++$i];
    }
    else {
	die "$ARGV[$i] is not a recognized argument.\n";
    }
}

### Open infile for reading ###
if ($infile_name) {
    open ($INFILE_HANDLE, $infile_name) or die "Could not open $infile_name: $!.\n";
}
else {
    $INFILE_HANDLE = *STDIN; # if no file given read from STDIN
}
### Open outfile for printing
if ($outfile_name) {
    open ($OUTFILE_HANDLE, ">$outfile_name") or die "Could not open $outfile_name: $!.\n";
}
else {
    $OUTFILE_HANDLE = *STDOUT; # if no filename given print to standard out
}

### Read infile row-by-row ###
while (my $input = <$INFILE_HANDLE>) {
    chomp $input;
    if ($input =~ /^>(.+)/) { # if it is a sequence name
	if (&present_in_array($1,@taxa_to_print)) { $print_flag = 'y'; } # if it is a name we are seeking set flag to print
	else { $print_flag = 'n'; } # otherwise set flag to not print
    }
    if ($print_flag eq 'y') { # Print if flag say so
	print $OUTFILE_HANDLE "$input\n";
    }
}
close $OUTFILE_HANDLE;

###################
### Subroutines ###
###################

### Sub to check if scalar is in an array
sub present_in_array {
    my $query = shift @_;
    foreach my $value (@_) {
	if ($query eq $value) { return 1; }
    }
    return 0;
}
