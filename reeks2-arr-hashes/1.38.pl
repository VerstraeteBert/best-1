# Veronderstel dat je over twee hashes beschikt. 
# Bepaal enerzijds de indices die in beide hashes, 
# en anderzijds de indices die slechts in één van beide hashes voorkomen.

%hash1 = (
	"a" => 1,
	"b" => 2,
	"c" => 3,
	"d" => 4,
);

%hash2 = (
	"b" => 3,
	"c" => 4,
	"z" => 5
);

# intersectie
@intersectie = ();

foreach $key (keys %hash1) {
	if (exists $hash2{$key}) {
		push (@intersectie, $key)
	}
}

print "intersectie: @intersectie\n";


# uniek
@uniek = ();

foreach $key (keys %hash1) {
	if (!exists $hash2{$key}) {
		push (@uniek, $key)
	}
}

foreach $key (keys %hash2) {
	if (!exists $hash1{$key}) {
		print $key;
		push (@uniek, $key)
	}
}

print "uniek: @uniek\n";
