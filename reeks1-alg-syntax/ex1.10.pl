# Maak een programma dat een rij random getallen genereert. 
# Zorg ervoor dat, telkens het programma opstart, 
# steeds dezelfde rij gereproduceerd wordt.
use strict;

srand(3);

for(my $i = 0; $i < 5; $i++) {
	print int(rand(9));
}