# Hoe kun je best bepalen hoeveel keer elke waarde in een tabel optreedt ?

@arr = ( 1,2,3,2,2,3,4,5,1 );

%occ = ();

foreach $val (@arr) {
	$occ{$val}++;
}

while (($key, $val) = each(%occ)) {
	print $key . " => " . $val . "\n";
}
