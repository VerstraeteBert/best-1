# Indien een functie (stat bijvoorbeeld) een lijst met meerdere elementen als
# terugkeerwaarde heeft, hoe kun je dan slechts met een beperkt aantal van 
# deze elementen expliciet rekening houden, en de andere elementen negeren ?
use strict;

(my $devnum, my $ino) = stat('ex1.12.pl'); 
(my $mode) = (stat('ex1.12.pl'))[2]; 
print $devnum . " " . $ino . " " . $mode;
