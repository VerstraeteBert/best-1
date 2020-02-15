# Genereer random gehele getallen in een vooropgesteld bereik. 
# Pas dit toe om een random paswoord te constreren 
# dat uit een vast aantal tekens uit een specifieke verzameling bestaat.
use strict;

my @choices = ('a'..'z', 0..9, 'A'..'Z');

for (my $i = 0; $i < 25; $i++) {
	print @choices[int rand scalar @choices];
}
