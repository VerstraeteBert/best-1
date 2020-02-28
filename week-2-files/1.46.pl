@line_nrs = (0, 1, 10);

@line_nrs = sort { $a <=> $b } @line_nrs;

@lines = <DATA>;

foreach $line_nr (@line_nrs) {
	if ($line_nr <= $#lines) {
		print $line_nr . ": " . $lines[$line_nr];
	} else {
		last;
	}
}

__DATA__
hallo
1
2
3
5
6
7
8
9
10
11