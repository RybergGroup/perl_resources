#This script shows which folders Perl look for modules

foreach (@INC) { print "$_\n"; }
