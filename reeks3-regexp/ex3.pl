#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Verwijder in een string alle whitespace die zich vooraan of achteraan bevindt.

my $zin = "      \t dit is een zin met whitespace\t vooraan en achteraan \t ";

$zin =~ s/^\s+|\s+$//gx;
# verwijder één of meerdere whitespace karakters aan begin of eind van de str
# ^ start van str
# \s+ -> een of meerdere whitespace karakters
# | of
# $ eind

print $zin;
