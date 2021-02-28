# Je kan ook een scalaire variabele invullen met een referentie naar een scalaire variabele of een scalaire constante.
# Op welke verschillende manieren ? Hoe kun je via deze referentie de oorspronkelijke waarde aanspreken of wijzigen ?
use strict;
my $test = 3;

# referentie creëren met \
my $scalar_ref = \$test;
print "$$scalar_ref\n";

# inhoud aanpassen
$$scalar_ref = "Hello, World!";
print $$scalar_ref;
