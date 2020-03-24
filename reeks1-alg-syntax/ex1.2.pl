# Hoe kun je de inhoud van twee of meer variabelen cyclisch omwisselen, 
# zonder een intermediaire variabele te gebruiken ?.

# met list assignment ops : ($VAR1, $VAR2) = ($VAR2, $VAR1);
use strict;

my $a = 'twee';
my $b = 'een';

($a, $b) = ($b, $a);

print $a . " " . $b;