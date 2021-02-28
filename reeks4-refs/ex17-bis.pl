open($fd, "<", $ARGV[0]) || die "Couldn't open file: $!\n";

while (<$fd>) {
    if (/<title>(\d+) by (\d+)/) {
        $cols = $1; $rows = $2;
        last;
    }
}
<$fd>; # skip bucht

print "$rows by $cols\n";

@neighbors = ();
for $num (1.. $rows * $cols) {
    @neighors[$num] = [];

    $col = ($num - 1) % $cols + 1;
    $row = int(($num - 1) / $cols) + 1;

#    print "$num: $row $col\n";

    # boven
    if ($row == 1) {
        $neighbors[$num][0] = 0;
    } else {
        $neighbors[$num][0] = $num - $cols;
    }

    # links
    if ($col == 1) {
        $neighbors[$num][1] = 0;
    } else {
       $neighbors[$num][1] = $num - 1;
    }

    # rechts
    if ($col == $cols) {
        $neighbors[$num][2] = 0;
    } else {
        $neighbors[$num][2] = $num + 1;
    }

    # onder
    if ($row == $rows) {
        $neighbors[$num][3] = 0;
    } else {
        $neighbors[$num][3] = $num + $cols;
    }
}

# controle stap burenlijst
#print "# Burenlijst (wanden negerend):\n\n";
#for $idx (1 .. $rows * $cols) {
#    print "$idx:\t";
#    for (0..3) {
#        printf "%-6d", $neighbors[$idx][$_];
#    }
#    print "\n";
#}

$line = <$fd>;
@arr_lines = ();
while ($line =~ /<line x1="(\d+)" y1="(\d+)" x2="(\d+)" y2="(\d+)"/) {
    $x1 = $1 / 16;
    $x2 = $3 / 16;
    $y1 = $2 / 16;
    $y2 = $4 / 16;

    @x = ();
    @y = ();

    print "x: $x1 -> $x2, y: $y1 -> $y2\n";

    while ($x1 != $x2) {
        push(@arr_lines, [
            $x1,
            $x1 + 1,
            $y1,
            $y2
        ]);
#          my $print_helper = $x1 + 1;
#          print "Broken up x: ($x1, $y1) -> ($print_helper, $y2)\n";
        $x1++;

    }

    while ($y1 != $y2) {
        push(@arr_lines, [
            $x1,
            $x2,
            $y1,
            $y1 + 1
        ]);

#         my $print_helper = $y1 + 1;
#         print "Broken up y: ($x1, $y1) -> ($x2, $print_helper)\n";

        $y1++;
    }
    $line = <$fd>;
}

for (@arr_lines) {
    $x1 = $_->[0];
    $x2 = $_->[1];
    $y1 = $_->[2];
    $y2 = $_->[3];

    $col = $x1;
    $row = $y1;

    $idx = ($row - 1) * $cols + $col;
    $top_idx = $idx - $cols;
    $left_idx = $idx - 1;

    if ($idx < 0 || $idx > $rows * $cols || $row > $rows || $col > $cols) {
        $idx = 0;
    }

    if ($top_idx < 0 || $col > $cols) {
        $top_idx = 0;
    }

    if ($left_idx < 0 || $col == 1) {
        $left_idx = 0;
    }

#    print "$row $col: $idx $top_idx $left_idx\n";

    # horizontale wand (bovenkant cel)
    if ($y1 == $y2) {
        # verwijder huidige cel, en de cel erboven uit elkaars deelverzamelingen
        # 1) verwijzing naar cel boven huidige cel verwijderen
        if ($idx != 0) {
            $neighbors[$idx][0] = undef;
        }

        if ($top_idx != 0) {
            $neighbors[$top_idx][3] = undef;
        }
    } elsif ($x1 == $x2) {
        # verticale wand
        # verwijder linkerbuur van huidige cel uit zijn deelverz
        #  linkerbuur kan ook huidige cel niet meer bereiken

        if ($idx != 0) {
            $neighbors[$idx][1] = undef;
        }

        if ($left_idx != 0) {
            $neighbors[$left_idx][2] = undef;
        }
    }
}

my @neighbor_hashes = ();
for my $i (1 .. $rows * $cols) {
    if (defined $neighbors[$i]->[0]) {
        $neighbor_hashes[$i]->{"boven"} = $neighbors[$i][0];
    }
    if (defined $neighbors[$i]->[1]) {
        $neighbor_hashes[$i]->{"links"} = $neighbors[$i][1];
    }
    if (defined $neighbors[$i]->[2]) {
        $neighbor_hashes[$i]->{"rechts"} = $neighbors[$i][2];
    }
    if (defined $neighbors[$i]->[3]) {
        $neighbor_hashes[$i]->{"onder"} = $neighbors[$i][3];
    }
}

print "# Burenlijst (rekening houdend met hindernissen):\n";
for my $i (1 .. $rows * $cols) {
    print "$i: boven: @neighbor_hashes[$i]->{'boven'}\t links: @neighbor_hashes[$i]->{'links'}\t rechts: @neighbor_hashes[$i]->{'rechts'}\t onder:@neighbor_hashes[$i]->{'onder'}\n"
}

print "# Eindecellen in opeenvolgende iteraties:\n";
$found_dangling = 1;
while ($found_dangling) {
    $found_dangling = 0;

    @removed = ();
    for $i (1 .. $rows * $cols) {
        if (!defined $neighbor_hashes[$i]) {
            next;
        }

        if (scalar keys %{$neighbor_hashes[$i]} == 1) {
            if (exists $neighbor_hashes[$i]->{"boven"}) {
                delete $neighbor_hashes[$neighbor_hashes[$i]->{"boven"}]->{"onder"};
            }

            if (exists $neighbor_hashes[$i]->{"links"}) {
                delete $neighbor_hashes[$neighbor_hashes[$i]->{"links"}]->{"rechts"};
            }

            if (exists $neighbor_hashes[$i]->{"rechts"}) {
                delete $neighbor_hashes[$neighbor_hashes[$i]->{"rechts"}]->{"links"};
            }

            if (exists $neighbor_hashes[$i]->{"onder"}) {
                delete $neighbor_hashes[$neighbor_hashes[$i]->{"onder"}]->{"boven"};
            }

            $neighbor_hashes[$i] = undef;
            $found_dangling = 1;
            push(@removed, $i);
        }
    }
    print "- @removed\n";
}

print "# Burenlijst (na eliminatie doodlopende paden):\n";
for my $i (1 .. $rows * $cols) {
    if (defined $neighbor_hashes[$i]) {
        print "$i: boven: $neighbor_hashes[$i]->{'boven'}\t links: $neighbor_hashes[$i]->{'links'}\t rechts: $neighbor_hashes[$i]->{'rechts'}\t onder:$neighbor_hashes[$i]->{'onder'}\n"
    }
}

my $in_i;
my $uit_i;
for $i (1 .. $rows * $cols) {
    if (!defined $neighbor_hashes[$i]) {
        next;
    }

    for $key (keys $neighbor_hashes[$i]) {
        if ($neighbor_hashes[$i]->{$key} == 0) {
            if (!defined $in_i) {
                $in_i = $i;
            } else {
                $uit_i = $i;
            }
        }
    }
}

print $in_i . " -> " . $uit_i;

$prev_i = 0;
$cur_i = $in_i;
@path = ( $in_i );
while ($cur_i != 0) {
    for $key (keys %{$neighbor_hashes[$cur_i]}) {
        if ($neighbor_hashes[$cur_i]->{$key} != $prev_i) {
            $next_i = $neighbor_hashes[$cur_i]->{$key};
            print "curr: $cur_i, prev:$prev_i, next: $next_i\n";
            push @path, $next_i;
            $prev_i = $cur_i;
            $cur_i = $next_i;
            last;
        }
    }
}

pop @path;

print "# Pad:\n";
print "@path";

undef $/;
$^I=".bak";
$_=<>;
/(.*<\/title>.)(.*)/s;
print "$1  <g fill=\"#FF0000\" stroke=\"none\">\n";

while ($#path) {
    $curr = pop @path;
    $col = ($curr - 1) % $cols + 1;
    $row = int(($curr - 1) / $cols) + 1;

    $x1 = $col * 16;
    $x2 = $col * 16 + 16;
    $y1 = $row * 16;
    $y2 = $row * 16 + 16;

    print "    <polygon points=\"$x1,$y1 $x2,$y1 $x2,$y2 $x1,$y2\" />\n";
}

print "  </g>\n$2";
