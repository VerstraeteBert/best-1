#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

#In perl is het niet mogelijk om als recorddelimiter (in de $/ variabele)
# een reguliere expressie te gebruiken. Hoe kun je dit toch simuleren ?
# Dit kan soms het parsen van complex geformatteerde inputbestanden aanzienlijk vereenvoudigen.

undef $/; # read in whole file at once
my @chunks = split(/:/, <DATA>);
print @chunks;

__DATA__
n:i:e:t:c:s:v