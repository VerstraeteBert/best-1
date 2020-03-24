# Met welke twee functies kun je nagaan of een specifieke waarde optreedt als index in een hash ?

# met exists () -> checken of exist,; niet persé defined / truthy

%hash = ( "bert" => 1, "Michiel" => 2 );

if (exists $hash{"bert"}) {
	print "correct" . "\n";
}

if (!exists $hash{"Wim"}) {
	print "correct" . "\n";
}

# met gewone vergelijking

%hash = ( "bert" => 1, "Michiel" => 2, "Test2" => 0 );

if ($hash{"bert"}) {
	print "correct" . "\n";
}

if (!$hash{"Wim"}) {
	print "correct" . "\n";
}

# HIERMEE OPPASSEN WEL DEFINED MAAR FALSY VALUE
if ($hash{"Test2"}) {
	print "correct" . "\n";
}
