# Verwijder duplicaten uit een lijst waarden. 
# Deze lijst kan bijvoorbeeld bekomen worden door een invoerbestand lijn per lijn in te lezen, 
# of door de individuele elementen van een array a priori in te vullen, 
# of door de uitvoer van een opdracht te verwerken.
@arr = ( 1, 2, 3 , 4, 8, 9, 8, 2, 3, 4, 7 );

@res = ();
%seen = ();

for $el (@arr) {
	if (!exists $seen{$el}) {
		$seen{$el} = 1;
		push(@res, $el);
	}
}

print @res;