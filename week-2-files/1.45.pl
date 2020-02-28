# Verwerk een bestand in omgekeerde zin:
my $data_start = tell DATA;
@lines = reverse <DATA>;
foreach (@lines) {
	chomp;
	print "New line: " . $_ . "\n";
}

seek DATA, $data_start, 0;
$/="";
@paragraphs = reverse <DATA>;
foreach (@paragraphs) {
	chomp;
	print "New para: " . $_ . "\n";
}


__DATA__
12

4


5


6

7