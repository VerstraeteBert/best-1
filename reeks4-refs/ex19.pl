my $filename = "fixtures/numbrix/$ARGV[0]";

if ( ! -f $filename || ! -r $filename ) {
    print "File $filename not found or not readable\n";
    exit 1;
}

my $fh;
open($fh, "<", $filename);

my $rows = 0;
my $cols;

my @cell_cand_map = ();
my @cand_cell_map = ();

my $i = 0;
while (<$fh>) {
    $cols = 0;
    while ($_ =~ /\.*0*([1-9]*)\s+/g) {
        print "$i: $1\n";
        if ($1) {
            $cell_cand_map[$rows][$cols]{$1}=undef;
            $cand_cell_map[$1]{$i}=undef;
        }
        $cols++;
        $i++;
    }
    $rows++;
}
print $rows, $cols;

# fill empty cell_cand_map cells with all numbers that haven't been assigned yet
my $N = $i;
for (my $row = 0; $row < $rows; $row++) {
    for (my $col = 0; $col < $cols; $col++) {
        if (!defined $cell_cand_map[$row][$col]) {
            for (my $num = 1; $num <= $N; $num++) {
                if (!defined $cand_cell_map[$num]) {
                    $cell_cand_map[$row][$col]{$num}=undef;
                }
            }
        }
    }
}

# ensure cand_cell_map is up to date
$i = 0;
for (my $row = 0; $row < $rows; $row++) {
    for (my $col = 0; $col < $cols; $col++) {
        for my $candidate (keys $cell_cand_map[$row][$col]) {
            $cand_cell_map[$candidate]{$i}=undef;
        }
        $i++;
    }
}

sub print_candidates_to_idx {
    print "CANDIDATE NUMBERS -> POSSIBLE INDICES\n";
    for (my $num = 1; $num <= $N; $num++) {
        print "NUMBER $num: ";
        for my $idx (sort { $a <=> $b } keys  $cand_cell_map[$num]) {
            print "$idx, ";
        }
        print "\n";
    }
}

sub print_idx_to_candidates {
    print "IDX -> CANDIDATE NUMBERS\n";
    for (my $row = 0; $row < $rows; $row++) {
        for (my $col = 0; $col < $cols; $col++) {
            $print_row = $row+1;
            $print_col = $col+1;
            print "IDX $print_row.$print_col: ";
            for my $candidate (sort { $a <=> $b } keys $cell_cand_map[$row][$col]) {
                print "$candidate, ";
            }
            print "\n";
        }
    }
}

print_candidates_to_idx;
print_idx_to_candidates;

sub neighbor_contains {
    my $idx = shift;
    my $num = shift;
    return ( (($idx + 1) % $cols != 0 && exists $cand_cell_map[$num]{$idx + 1}) # check right if not rightmost cell of row
        || (($idx) % $cols != 0 && exists $cand_cell_map[$num]{$idx - 1}) # check left if not leftmost cell of row
        || exists $cand_cell_map[$num]{$idx - $cols} # check top
        || exists $cand_cell_map[$num]{$idx + $cols}); #  check bottom
}


sub neighbor_reduction {
    local $num_reduced = 0;
    $i = -1;
    for (my $row = 0; $row < $rows; $row++) {
        for (my $col = 0; $col < $cols; $col++) {
            $i++;
            # skip entries that are already singletons
            if (scalar keys $cell_cand_map[$row][$col] == 1) {
                next;
            }
            for my $cand (keys $cell_cand_map[$row][$col]) {
                if (($cand > 1 && !neighbor_contains($i, $cand - 1))
                    || ($cand < $N && !neighbor_contains($i, $cand + 1))) {
                    $num_reduced++;
                    delete $cell_cand_map[$row][$col]{$cand};
                    delete $cand_cell_map[$cand]{$i};
                }
            }

        }
    }
    return $num_reduced;
}

sub eliminate_picked_vals {
    local $num_reduced = 0;
    $curr_idx = 0;
    for (my $row = 0; $row < $rows; $row++) {
        for (my $col = 0; $col < $cols; $col++) {
            if (scalar keys $cell_cand_map[$row][$col] == 1) {
                # remove this value from all other cell candidates
                my $num = (keys($cell_cand_map[$row][$col]))[0];
                # print "$num \n";
                for $idx_to_remove (keys $cand_cell_map[$num]) {
                    if ($idx_to_remove != $curr_idx) {
                        $num_reduced++;
                        # $row_to_remove = int($idx_to_remove / $cols);
                        # $col_to_remove = $idx_to_remove % $cols;
                        # print "$num $idx_to_remove $row_to_remove.$col_to_remove\n";
                        delete $cell_cand_map[int($idx_to_remove / $cols)][$idx_to_remove % $cols]{$num};
                        delete $cand_cell_map[$num]{$idx_to_remove};
                    }
                }
            }
            $curr_idx++;
        }
    }
    return $num_reduced;
}

sub select_single_occurences {
    local $num_reduced = 0;
    for (local $num = 1; $num <= $N; $num++) {
        if (scalar keys $cand_cell_map[$num] == 1) {
            local $idx = (keys $cand_cell_map[$num])[0];
            local $row = int($idx / $cols);
            local $col = $idx % $cols;

            for $candidate (keys $cell_cand_map[$row][$col]) {
                if ($candidate != $num) {
                    $num_reduced++;
                    delete $cell_cand_map[$row][$col]{$candidate};
                    delete $cand_cell_map[$candidate]{$idx};
                }
            }
        }
    }
    return $num_reduced;
}

my $reduction = 1;
while ($reduction == 1) {
    $reduction = 0;
    # always try neighbor reduction, untill it has no more effect
    while ( neighbor_reduction > 0) {};
    print_idx_to_candidates;
    print_candidates_to_idx;
    while ( eliminate_picked_vals > 0 ) {
        $reduction = 1;
    }
    while ( select_single_occurences > 0 ) {
        $reduction = 1;
    }
}

print "\nResultaat: \n";
for (my $row = 0; $row < $rows; $row++) {
    for (my $col = 0; $col < $cols; $col++) {
        my $num = (keys($cell_cand_map[$row][$col]))[0];
        printf "%03d ", (keys($cell_cand_map[$row][$col]))[0];
    }
    print "\n";
}



