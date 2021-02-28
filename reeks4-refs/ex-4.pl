# a) Op welke verschillende manieren kun je een scalaire variabele invullen met een referentie naar een hash.
use strict;

my %hash = (
    "key1" => "val1",
    "key2" => "val2",
    "key3" => "val3",
    "key4" => "val4"
);

# \ operator gebruiken
my $hashRef = \%hash;
print "Eerste hash: $hashRef\n";

# onmiddelijke initialisatie met { } (analoog aan [] voor arrs)
my $hashRef2 = {
    "test" => "test1"
};
print "Tweede hash: $hashRef2\n";

# b) een specifiek element van de hash aanspreken
# opnieuw met $ref->{"key"} of @{$ref}{"key"}
print ${$hashRef}{"key1"}. "\n";
print $hashRef->{"key2"} . "\n";

# c) een slice van een hash aanspreken
my @hash_slice = @{$hashRef}{"key1", "key2"};
print "slice vals: " . join(", ", @hash_slice) . "\n";

# d) alle indices bekomen
# keys(%{$hashref})
print "all keys: " . join ", ", keys(%{$hashRef}) . "\n";

# e) alle index waarde koppels verwerken

for my $key (sort keys %{$hashRef}) {
    print $key . " -> " . $hashRef->{$key} . "\n";
}
print "\n";
