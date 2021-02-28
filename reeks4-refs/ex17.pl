use strict;

my @ARGS = @ARGV;

my $filename = "fixtures/svg/$ARGS[0]";

my $line = "";

open(my $fd, "<", $filename);

$line = <$fd>;

# skip untill <rect> tag has been found
while ($line !~ /^.*<rect.*$/) {
    $line = <$fd>;
}

# read title line
$line = <$fd>;

my $rows, my $cols;
$line =~ /.*<title>(\d*) by (\d*).*/;
$cols = $1;
$rows = $2;

# initialize neighbor_list
# each entry holds a reference to an array of 1 .. 4 elements containing
#           [iBoven, iLinks, iRechts, iOnder]
my @neighbor_list = ();

for my $idx (1 .. $rows * $cols) {
    my @index_neighbors = ();

    my $row = int(($idx - 1) / $cols) + 1;
    my $col = ($idx - 1) % $cols + 1;

    if ($row == 1) {
        $index_neighbors[0] = 0;
    } else {
        $index_neighbors[0] = $idx - $cols;
    }

    if ($row == $rows) {
        $index_neighbors[3] = 0;
    } else {
        $index_neighbors[3] = $idx + $cols;
    }

    if ($col == 1) {
        $index_neighbors[1] = 0;
    } else {
        $index_neighbors[1] = $idx - 1;
    }

    if ($col == $cols) {
        $index_neighbors[2] = 0;
    } else {
        $index_neighbors[2] = $idx + 1;
    }

    $neighbor_list[$idx] = \@index_neighbors
}
$neighbor_list[0] = undef;

print "# Burenlijst (wanden negerend)\n\n";
$"="\t";
for my $i (1 .. $rows * $cols) {
    print "$i: @{$neighbor_list[$i]}\n";
}


# skip <g> wrapper
$line = <$fd>;
# first line tag input in line
$line = <$fd>;

my @arr_lines;
# read in lines and break lines spanning multiple fields into parts
while ($line =~ /^\s*<line x1="(\d+)" y1="(\d+)" x2="(\d+)" y2="(\d+)" \/>$/) {
    my $x1 = $1 / 16;
    my $y1 = $2 / 16;
    my $x2 = $3 / 16;
    my $y2 = $4 / 16;

    $line = <$fd>;

    print "Full line coords: ($x1, $y1) -> ($x2, $y2)\n";

    while ($x1 != $x2) {
        push(@arr_lines, {
            "x1" => $x1,
            "x2" => $x1 + 1,
            "y1" => $y1,
            "y2" => $y2
        });
        my $print_helper = $x1 + 1;
        print "Broken up x: ($x1, $y1) -> ($print_helper, $y2)\n";
        $x1++;
    }
    while ($y1 != $y2) {
        push(@arr_lines, {
            "x1" => $x1,
            "x2" => $x2,
            "y1" => $y1,
            "y2" => $y1 + 1
        });
        my $print_helper = $y1 + 1;
        print "Broken up y: ($x1, $y1) -> ($x2, $print_helper)\n";
        $y1++;
    }
}

close $fd;

# remove blocking edges from neighbor list
for (@arr_lines) {
    my $x1 = $_->{x1};
    my $y1 = $_->{y1};
    my $x2 = $_->{x2};
    my $y2 = $_->{y2};

    my $col = $x1;
    my $row = $y1;

    my $curr_idx = $col + (($row - 1) * $cols);
    if ($curr_idx < 1 || $curr_idx > ($rows * $cols) || $col > $cols) {
        $curr_idx = 0;
    }

    my $top_idx = ($col) + (( $row - 2) * $cols);
    if ($row == 1 || $col == ($cols + 1)) {
        $top_idx = 0;
    }

    my $left_idx = ($col - 1) + (( $row - 1) * $cols);
    if ($col == 1 || $row == ($rows + 1)) {
        $left_idx = 0;
    }
    print "Line coords: ($x1, $y1) -> ($x2, $y2)\n";
    print "curr_idx: $curr_idx, top_idx: $top_idx, left_idx: $left_idx\n";

    # y's equal -> horizontal line (top of cell)
    if ($y1 == $y2) {
        # eliminate bottom from top cell, top from curr cell
        if ($curr_idx != 0) {
            @neighbor_list[$curr_idx]->[0] = undef;
        }
        if ($top_idx != 0) {
            @neighbor_list[$top_idx]->[3] = undef;
        }
    }
    # x's equal -> vertical line (left of curr cell)
    if ($x1 == $x2) {
        # eliminate left from curr cell, right from left cell
        if ($curr_idx != 0) {
            @neighbor_list[$curr_idx]->[1] = undef;
        }
        if ($left_idx != 0) {
            @neighbor_list[$left_idx]->[2] = undef;
        }
    }
}

my @neighbor_hashes = ();
push @neighbor_hashes, undef;
for my $i (1 .. $rows * $cols) {
    if (defined $neighbor_list[$i]->[0]) {
        $neighbor_hashes[$i]->{"boven"} = $neighbor_list[$i]->[0];
    }
    if (defined $neighbor_list[$i]->[1]) {
        $neighbor_hashes[$i]->{"links"} = $neighbor_list[$i]->[1];
    }
    if (defined $neighbor_list[$i]->[2]) {
        $neighbor_hashes[$i]->{"rechts"} = $neighbor_list[$i]->[2];
    }
    if (defined $neighbor_list[$i]->[3]) {
        $neighbor_hashes[$i]->{"onder"} = $neighbor_list[$i]->[3];
    }
}

print "# Burenlijst (rekening houdend met hindernissen):\n";
for my $i (1 .. $rows * $cols) {
    print "$i: boven: @neighbor_hashes[$i]->{'boven'}\t links: @neighbor_hashes[$i]->{'links'}\t rechts: @neighbor_hashes[$i]->{'rechts'}\t onder:@neighbor_hashes[$i]->{'onder'}\n"
}

print "# Eindcellen in opeenvolgende iteraties:\n";
my $found_dangling = 1;
$"=" ";
while ($found_dangling == 1) {
    my @iter_removed = ();

    # print "\n\n";
    # for my $j (1 .. $rows * $cols) {
    #     if (defined $neighbor_hashes[$j]) {
    #         print "$j: $neighbor_hashes[$j]->{'boven'}\t $neighbor_hashes[$j]->{'links'}\t $neighbor_hashes[$j]->{'rechts'}\t$neighbor_hashes[$j]->{'onder'}\n"
    #     }
    # }

    for my $i (1 .. $rows * $cols) {
        if (!defined($neighbor_hashes[$i])) {
            next;
        }

        if (scalar(keys %{$neighbor_hashes[$i]}) == 1) {
            for my $key (keys %{$neighbor_hashes[$i]}) {
                my $idx_connected = $neighbor_hashes[$i]->{$key};
                $neighbor_hashes[$i] = undef;
                push @iter_removed, $i;
                # print "$i: $key : $idx_connected\n";

                if ($key eq "boven") {
                    # print $neighbor_hashes[$idx_connected]->{"onder"};
                    delete $neighbor_hashes[$idx_connected]->{"onder"};
                }
                if ($key eq "onder") {
                    # print $neighbor_hashes[$idx_connected]->{"boven"};
                    delete $neighbor_hashes[$idx_connected]->{"boven"};
                }
                if ($key eq "links") {
                    # print $neighbor_hashes[$idx_connected]->{"rechts"};
                    delete $neighbor_hashes[$idx_connected]->{"rechts"};
                }
                if ($key eq "rechts") {
                    # print $neighbor_hashes[$idx_connected]->{"links"};
                    delete $neighbor_hashes[$idx_connected]->{"links"};
                }
                # print "\n";
            }
        }
    }

    if (scalar(@iter_removed) == 0) {
        $found_dangling = 0;
    }

    print "- @iter_removed \n";
}

print "# Burenlijst na eliminatie doodlopende paden\n";
for my $i (1 .. $rows * $cols) {
    if (defined $neighbor_hashes[$i]) {
        print "$i: ";
        if (defined $neighbor_hashes[$i]->{'boven'}) {
            print "$neighbor_hashes[$i]->{'boven'}\t";
        }
        if (defined $neighbor_hashes[$i]->{'onder'}) {
            print "$neighbor_hashes[$i]->{'onder'}\t";
        }
        if (defined $neighbor_hashes[$i]->{'links'}) {
            print "$neighbor_hashes[$i]->{'links'}\t";
        }
        if (defined $neighbor_hashes[$i]->{'rechts'}) {
            print "$neighbor_hashes[$i]->{'rechts'}\t";
        }

        print "\n";
    }
}

my $start_i = 0;
my $end_i = 0;
for my $i (1 .. $rows * $cols) {
    if (defined $neighbor_hashes[$i]) {
        for my $key (keys $neighbor_hashes[$i]) {
            if ($neighbor_hashes[$i]->{$key} == 0) {
                if ($start_i == 0) {
                    $start_i = $i;
                } else {
                    $end_i = $i;
                }
            }
        }
    }
}

my @path = ();
my $prev_i = 0;
my $curr_i = $start_i;

while ($curr_i != 0) {
    push @path, $curr_i;
    for my $key (keys $neighbor_hashes[$curr_i]) {
        if ($neighbor_hashes[$curr_i]->{$key} != $prev_i) {
            $prev_i = $curr_i;
            $curr_i = $neighbor_hashes[$curr_i]->{$key};
            last;
        }

    }
}

print "# Pad:\n";
print "@path\n";


# printing path (filling with red)
$line = "";

$^I=1;
open($fd, "<>", $filename);

$line = <$fd>;

my @output = ();
while ($line !~ /.*<title>(\d*) by (\d*).*/) {
    push @output, $line;
    $line = <$fd>;
}
push @output, "$line";
push @output, "    <g fill=\"#FF0000\" stroke=\"none\">\n";

for my $i_path (@path) {
    my $row = int(($i_path - 1) / $cols) + 1;
    my $col = (($i_path - 1) % $cols) + 1;

    my $output_line = "      <polygon points=\"";

    $output_line = $output_line . ($col * 16) . "," . ($row * 16) . " ";
    $output_line = $output_line . (($col + 1) * 16) . "," . ($row * 16) . " ";
    $output_line = $output_line . (($col + 1) * 16) . "," . (($row + 1) * 16) . " ";
    $output_line = $output_line . (($col ) * 16) . "," . (($row + 1) * 16) . "\" />\n";

    push @output, $output_line;
}
push @output, "    </g>\n";

while (<$fd>) {
    push @output, $_;
}

close($fd);

open($fd, ">", "fixtures/svg/sol_$ARGS[0]");

for (@output) {
    print $fd $_;
}

close($fd);
