#!/usr/bin/perl
use strict;
use warnings FATAL => 'all';

#Het gedrag van een perl programma kan door de gebruiker ervan beïnvloed
# worden door parameters op de opdrachtlijn
# te vermelden, of door environment variabelen te interpreteren.
#  Het invullen van configuratiebestanden vormt een ander alternatief.
# Hoe kunnen deze configuratiebestanden best gestructureerd en verwerkt worden ?

while (<CONFIG>) {
    chomp;                  # no newline
    s/#.*//;                # no comments
    s/^\s+//;               # no leading white
    s/\s+$//;               # no trailing white
    next unless length;     # anything left?
    my ($var, $value) = split(/\s*=\s*/, $_, 2);
    $User_Preferences{$var} = $value;
}

#or better yet, treat the config file as full Perl code:

#do "$ENV{HOME}/.progrc";
