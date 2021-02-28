# Stel een nieuwe hash samen op basis van meerdere bestaande hashes.
#  Hou, in tegenstelling tot reeks 2 vraag 37, nu wel rekening met indices die in meerdere originele hashes voorkomen.
# Probeer ook het herhalen van de while-lus, voor elk van de hashes, van de oorspronkelijke oplossing te vermijden.
use strict;

my %food_color = (
    "banaan" => "geel",
    "citroen" => "geel",
    "appel" => "rood",
    "kiwi" => "bruin"
);

my %drink_color = (
    "pepsi" => "zwart",
    "fanta" => "geel",
    "kiwi"  => "bruin"
);

my %combined = ();

for my $ref (\%food_color, \%drink_color) {
    while ((my $key, my $val) = each %$ref) {
        if (!exists $combined{$key}) {
            $combined{$key}=$val;
        }
    }
}
