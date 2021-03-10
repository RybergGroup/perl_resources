#! /usr/bin/perl -w

use strict;

use DBI;
use DBD::SQLite;
use Bio::SeqIO;

# Script to add sequences to table sequences in a SQLite database (table should have column accno and sequence as only required arguments
# First argument should be database name, second sequence file

# give database name, user name, and password (SQLite do not have users and password)
my $dbh = DBI->connect("dbi:SQLite:dbname=$ARGV[0]",'','') or die "Can not connect to $ARGV[0].\n";

# prepare a SQL statement looking if sequences table is present
my $sth = $dbh->prepare("SELECT name FROM sqlite_master WHERE type='table' AND name='sequences'");

$sth->execute(); # Run statement

if (!$sth->fetchrow_array()) { # If we did not find any table
    print STDERR "Table sequences does not exist. Creating it...\n";
    $sth->finish(); # finish previous statement
    $sth = $dbh->prepare("CREATE TABLE sequences (accno TEXT PRIMARY KEY, sequence TEXT)"); # statement to create table
    $sth->execute();
    $sth->finish();
}
else { $sth->finish(); } # finish statement

my $seqinput = Bio::SeqIO->new(-file => $ARGV[1], -format => 'Fasta'); # prepare to read sequences

$sth = $dbh->prepare("INSERT INTO sequences (accno, sequence) VALUES (?,?)"); # prepare statement to insert sequences. ? will be replaced

while (my $seq = $seqinput->next_seq()) { # for each sequence
    $sth->execute($seq->id(),$seq->seq()); # replace first ? with seq id and second with sequence
}
$sth->finish(); 
$dbh->disconnect(); # disconnect from database
