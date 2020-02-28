# Verwerk de elementen van een hash in een gesorteerde volgorde

my %hash = (
	"a" => 3,
	"b" => 2,
	"c" => 1,
);

print "sorted by key\n";
foreach $key (sort keys %hash) {
	print $key . " => " . $hash{$key} . "\n";
}

print "sorted by val\n";
foreach $key (sort { $hash{$a} <=> $hash{$b} } keys %hash) {
	print $key . " => " . $hash{$key} . "\n";
}
