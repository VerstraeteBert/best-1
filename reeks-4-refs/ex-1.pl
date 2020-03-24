use strict;

my @m1 = (
    [1, 2, 3],
    [4, 5, 6]
);

my @m2 = (
    [1, 2],
    [3, 4],
    [5, 6]
);

my @res = (
    [0, 0],
    [0, 0]
);

for my $row (0 .. $#m1) {
    for my $col (0 .. $#res) {
        my $tmp = 0;
        for my $g (0 .. $#m2) {
            $tmp += $m1[$row][$g] * $m2[$g][$col];
        }
        $res[$row][$col] = $tmp;
    }
}

for my $rref ( @res ) {
    print "[ @$rref ]\n"
}
s