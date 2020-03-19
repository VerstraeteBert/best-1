#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Verwerk een bestand veld per veld. Je mag veronderstellen
# dat de velddelimiter kan omschreven worden met behulp van een reguliere expressie.

my $str = "komma,seperated,values,met,dubbels,dubbels,dubbels";

my @fields = split /,/, $str;

for my $lijn (@fields) {
    print "$lijn\n";
}
