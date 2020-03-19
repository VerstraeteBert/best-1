#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

# use glob function
open(FH, glob("~/huiswerk/voeten.jpg")) || die "Couldn't open file: $!";
