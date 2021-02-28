# In reeks 2 vraag 35 werd besproken hoe je een hash kon inverteren.
# Veralgemeen deze methode, zodat je nu ook toelaat dat de originele hash duplikaten vertoont.
use strict;

my %food_color = (
    "banaan" => "geel",
    "citroen" => "geel",
    "appel" => "rood",
    "kiwi" => "bruin"
);

my %color_foods = ();

while  ((my $food, my $color) = each (%food_color)) {
    push(@{$color_foods{$color}}, $food);
}

print "@{$color_foods{geel}} waren gele fuiten";
