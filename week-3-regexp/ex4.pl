#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Construeer reguliere expressies die controlleren of een string correct kan geïnterpreteerd als natuurlijk getal,
# geheel getal, decimaal getal of floating-point getal
# (met een syntax zoals je die in programmeertalen als C en Java mag hanteren).
# geen goesting in floating points :-)

my @getallen = ("123", "+456", "-456", " ", "0", ".2", "-0.2", "+10.23");

foreach my $getal (@getallen) {
    if ($getal =~ /^[+]\d+$/) {
        print "$getal is een natuurlijk getal\n";
    }
    if ($getal =~ /^[+-]?\d+$/) {
        print "$getal is een geheel getal\n";
    }
    if ($getal =~ /^[+-]?\d+\.?\d*$/) {
        print "$getal is een decimaal getal\n";
    }
    else {
        print "$getal pastte niet in vorige categoriën\n";
    }
}
