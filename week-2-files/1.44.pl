my $data_start = tell DATA;
$count = 0;
while (<DATA>) {
	$count++;
}
print "aant lijnen:" . $count . "\n";

seek DATA, $data_start, 0;
$/="";
$count = 0;
while (<DATA>) {
	$count++;
}
print "aant paragrafen:" . $count;


__DATA__
1
2

3

4


5

5
