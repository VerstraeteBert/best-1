#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Schrijf een programma dat alle tabs in a string converteert in een aantal spaties.
# Hierbij mag verondersteld worden dat alle tab stops zich op een veelvoud van 8 bevinden.

my $str = "hanlo\tdit\tis\tnu\tmet\tspaties\tgescheiden";

$str =~ s/\t/ /g;
print $str;