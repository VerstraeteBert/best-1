# Gebruik hashes van array's om aan elke index van de hash een lijst van waarden te associëren.
# Hoe kun je de volledige lijst van waarden voor elke index tonen ?
use strict;
# de hash moet zijn keys mappen naar referenties naar arrays
my %eten_map = (
    "Fruit"     => [ "Banaan", "Appel", "Kiwi", "Peer" ],
    "Deegwaren" => [ "Penne", "Spaghetti", "Courgettini", "Gnocchi" ],
    "Vlees"     => [ "Varkenslapje", "Blinde Vink", "Stoofvlees"]
);

# Hoe kun je aan de lijst van een specifieke index een waarde toevoegen ?
push @{$eten_map{"Fruit"}}, "Sinaasappel";
# nieuwe array initialiseren?
# niet nodig door autovivicatie:
# -> als je een element voor de eerste keer aanspreekt op een specifieke manier,
# en dat element zou niet netjes geïnitialiseerd zijn,
# dat dan perl zelf voor de initialisatie zorgt,
# conform met de specifieke manier, waarop het element aangesproken wordt.
push @{$eten_map{"Vis"}}, "Kabeljauw";
push @{$eten_map{"Vis"}}, "Zalm";

for my $type (keys %eten_map) {
    print "---$type---\n";
    for my $naam (@{$eten_map{$type}}) {
        print "\t$naam\n";
    }
}
