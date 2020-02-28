# Bepaal de waarden van elementen die in een eerste array voorkomen, maar niet in een tweede. 
# Pas dit toe om lijnen van een bestand te filteren die niet voorkomen in een ander bestand.

@file1 = (1, 2, 3, 4, 5, 6, 7);
@file2 = (4, 5, 6, 7, 8, 9, 10, 11);

@seen{@file2} = ();

@diff = ();
for $el (@file1) {
	if (!exists $seen{$el}) {
		push(@diff, $el);
	}
}

@file1 = @diff;
print @file1;
