#!/usr/bin/perl

# Hoe kun je slechts een deel van een string wijzigen ?
# Dit kan ondermeer interessant zijn
# om specifieke velden te wijzigen van records met vaste veldgrenzen.
use strict;
use warnings FATAL => 'all';

my $delimitted_zin = "dit:is:een:  delimited   :zin:met:whitespace:oops";

my @chunks = split ":", $delimitted_zin;

$chunks[3] =~ (s/^\s+|\s+$//g);

$delimitted_zin = join(':',@chunks);

print $delimitted_zin;
