#Gebruik een reguliere expressie om uit een string in DD/MM/YYYY formaat de dag-, maand- en jaartallen te parsen.
use strict;

my $datum = "06/02/1997";

(my $dag, my $maand, my $jaar) = ($datum =~ m{(\d\d)/(\d\d)/(\d\d\d\d)});

print "$dag, $maand, $jaar";