# Op welke verschillende manieren kun je een
# scalaire variabele invullen met een referentie naar een array ?
# Hoe kun je via deze referentie:
use strict;

# a) manieren om scalare var te vullen met ref
# 1) [] gebruiken bij initialisatie array
# geeft referentie terug
my $arrRef = [
    "test1",
    "test2",
    "test3",
    "test4",
    "test5"
];
print "$arrRef\n";

# 2) met \ operator op bestaande array
# return opnieuw een referentie naar de array
my @arr = ("nog een arr");
my $arrRef2 = \@arr;
print "$arrRef2\n";

# b) een specifiek element van de array aanspreken ?
# 1) met dereference operator @ of $; @{$refvar}[n] of ${$refvar}[n]
print "${$arrRef}[0]\n";
    # of
print "@{$arrRef}[0]\n";
# 2) dereferencen met -> shorthand
print "$arrRef->[1]\n";
# kan ook gebruikt worden om de data te manipuleren
$arrRef->[2] = "een nieuwe waarde";
print "$arrRef->[2]\n";

# c) een slice van de array aanspreken?
# analoog aan vorige, met een index range
print "slicing: ";
my @slice = @{$arrRef}[2..4];
print join(', ', @slice) . "\n";
# lukt niet met postfix operator; tenzij je elke individueel element apart in een nieuwe array (slice) steekt;

# d) het laatste indexnummer bekomen
# bij normale array -> $#names
# referentie -> $#$names_ref of $#{$names_ref}
print "last index number: $#{$arrRef}\n";

# e) het aantal elementen in een array bekomen
# bij normale array -> scalar @arr
# bij ref -> scalar @$arr
print "size of array: " . scalar @$arrRef . "\n";

# f) een element achteraan toevoeegen?
# bij normale array push @arr, $el;
# bij ref push @{$arr}, $el;
# OF dereferentie zelfs niet nodig: push $arrRef, $el lukt ook
print "Before push: @{$arrRef}\n";
push $arrRef, "nog een nieuwe waarde";
print "After push: @{$arrRef}\n";

# g) de array element per element verwerken
for my $el (@$arrRef) {
    print $el . " ";
}
print "\n";
