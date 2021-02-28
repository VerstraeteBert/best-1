# In reeks 2 vraag 20 werden een paar technieken gehanteerd om de inhoud van een hash te tonen.
# Je kan bijvoorbeeld een intermediare array invoeren waarin je de volledige hash opslaat, om deze dan ineens uitprinten.
# Pas dit nu toe met behulp van een anonieme array, om een expliciete intermediare array te vermijden.
use strict;

my %hash = (
    "test1" => "val1",
    "test2" => "val2",
    "test3" => "val3"
);

print (@{[%hash]}) . "\n";
