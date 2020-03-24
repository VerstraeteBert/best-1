#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# Hoe kun je vermijden dat je steeds twee perl opdrachten nodig hebt om eerst een substitutie
# met behulp van reguliere expressies uit te voeren,
# en vervolgens het resultaat te kopiëren in een specifieke variabele.

# use glob function
open(FH, glob("~/huiswerk/voeten.jpg")) || die "Couldn't open file: $!";
