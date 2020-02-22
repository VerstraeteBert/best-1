@arr = (1,2,3,4);

$needle = 5;
my ($found_el, $found_idx);

for ($i = 0; $i < scalar @arr; $i++) {
	if ($arr[$i] == $needle) {
		$found_idx = $i;
		$found_el = $arr[$i];
	}
}

if (defined $found_idx) {
	print "Found $found_el at position $found_idx";
} else {
	print "nothing found";
}
