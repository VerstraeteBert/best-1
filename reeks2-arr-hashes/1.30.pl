# Veronderstel dat je over twee lijsten beschikt, die elk geen duplikate waarden bevatten. 
# Bereken de intersectie-, de unie-, en de verschil-lijsten: elementen die in beide lijsten, 
# minstens in één van beide lijsten, of slechts in één van beide lijsten voorkomen.
@lijst1 = (1, 2, 3, 4, 5, 6, 7);
@lijst2 = (6, 7, 8, 9, 10);

@seen{@lijst1} = ();

@intersectie = ();
foreach $el (@lijst2) {
	if (exists $seen{$el}) {
		push(@intersectie, $el);
	}
}

print "Intersectie: @intersectie\n";

@unie = @lijst1;

foreach $el (@lijst2) {
	if (!exists $unie{$el}) {
		push(@unie, $el);
	}
}

print "Unie: @unie\n";

@uniek{@lijst1} = ();
foreach $el (@lijst2) {
	if (exists $uniek{$el}) {
		delete $uniek{$el};
	} else {
		$uniek{$el} = ();
	}
}

@uniek = sort { $a <=> $b } keys(%uniek);

print "Verschil: @uniek\n";
