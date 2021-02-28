my $filename = "fixtures/numbrix/$ARGV[0]";

if ( ! -f $filename || ! -r $filename ) {
    print "File $filename not found or not readable\n";
    exit 1;
}

my $fh;
open($fh, "<", $filename);

my $rows = 0;
my $cols;

my @row_col_cands = ();
my @cands_idx = ();

my $i = 0;
while (<$fh>) {
    $cols = 0;
    while ($_ =~ /\.*0*([1-9]*)\s+/g) {
        print "$1\n";
        if ($1) {
            $row_col_cands[$rows][$cols]{$1}=undef;
            # print "$rows $cols $i: $1\n";
            $cands_idx[$1]{$i}=undef;
        }
        $cols++;
        $i++;
    }
    # doet een iteratie te veel elke keer...
    $i--;
    $rows++;
}
# cols zal één idx te ver zitten
$cols--;
# print $rows, $cols;

my $N = $i;
for (my $row = 0; $row < $rows; $row++) {
    for (my $col = 0; $col < $cols; $col++) {
        if (!defined $row_col_cands[$row][$col]) {
            for (my $num = 1; $num <= $N; $num++) {
                if (!defined $cands_idx[$num]) {
                    $row_col_cands[$row][$col]{$num}=undef;
                }
            }
        }
    }
}


$i = 0;
for (my $row = 0; $row < $rows; $row++) {
    for (my $col = 0; $col < $cols; $col++) {
        for my $candidate (keys $row_col_cands[$row][$col]) {
            $cands_idx[$candidate]{$i}=undef;
        }
        $i++;
    }
}

sub print_candidates_to_idx {
    print "CANDIDATE NUMBERS -> POSSIBLE INDICES\n";
    for (my $num = 1; $num <= $N; $num++) {
        print "NUMBER $num: ";
        for my $idx (sort { $a <=> $b } keys  $cands_idx[$num]) {
            print "$idx, ";
        }
        print "\n";
    }
}

sub print_idx_to_candidates {
    print "IDX -> CANDIDATE NUMBERS\n";
    for (my $row = 0; $row < $rows; $row++) {
        for (my $col = 0; $col < $cols; $col++) {
            print "IDX $row.$col: ";
            for my $candidate (sort { $a <=> $b } keys $row_col_cands[$row][$col]) {
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
    # dit fixen -> wat bij boundaries (rechts of links!!)
    return ( (($idx + 1) % $cols != 0 && exists $cands_idx[$num]{$idx + 1}) # check right if not rightmost cell of row
        || (($idx) % $cols != 0 && exists $cands_idx[$num]{$idx - 1}) # check left if not leftmost cell of row
        || exists $cands_idx[$num]{$idx - $cols} # check top
        || exists $cands_idx[$num]{$idx + $cols}); #  check bottom
}

sub check_neighboring_cells {
    local $reduction = 1;
    while ($reduction == 1) {
        $reduction = 0;
        # reductie criterium 1
        $i = -1;
        for (my $row = 0; $row < $rows; $row++) {
            for (my $col = 0; $col < $cols; $col++) {
                $i++;
                if (scalar keys $row_col_cands[$row][$col] == 1) {
                    next;
                }
                for my $cand (keys $row_col_cands[$row][$col]) {
                    my $is_valid = 1;
                    if ($cand > 1 && !neighbor_contains($i, $cand - 1)) {
                        $is_valid = 0;
                    }
                    elsif ($cand < $N && !neighbor_contains($i, $cand + 1)) {
                        $is_valid = 0;
                    }

                    if ($is_valid == 0) {
                        $reduction = 1;
                        delete $row_col_cands[$row][$col]{$cand};
                        delete $cands_idx[$cand]{$i}
                    }
                }
            }
        }
    }
}

sub eliminate_singleton_vals {
    local $total_removals = 0;
    local $reduction = 1;
    while ($reduction == 1) {
        $reduction = 0;
        $i = -1;
        for (my $row = 0; $row < $rows; $row++) {
            for (my $col = 0; $col < $cols; $col++) {
                $i++;
                if (scalar keys $row_col_cands[$row][$col] == 1) {
                    # remove this value from all other cell candidates
                    my $num = (keys($row_col_cands[$row][$col]))[0];
                    # print "$num \n";
                    for $idx_to_remove (keys $cands_idx[$num]) {

                        if ($idx_to_remove != $i) {
                            if ($num == 19) {
                                print "$idx_to_remove\n";
                            }
                            $reduction = 1;
                            $total_removals++;
                            delete $row_col_cands[int($idx_to_remove / $cols)][$idx_to_remove % $cols]{$num};
                            delete $cands_idx[$num]{$idx_to_remove}
                        }
                    }
                }
            }
        }
    }
    return $total_removals;
}

sub pick_reduced_singleton {
    local $total_removals;
    local $reduction = 1;
    while ($reduction == 1) {
        $reduction = 0;
        for (local $num = 1; $num <= $N; $num++) {
            # reduced to singleton
            if (scalar keys $cands_idx[$num] == 1) {
                local $idx = (keys $cands_idx[$num])[0];
                local $row = int($idx / $cols);
                local $col = $idx % $cols;

                for $candidate (keys $row_col_cands[$row][$col]) {
                    if ($candidate != $num) {
                        $reduction = 1;
                        $total_removals++;
                        delete $row_col_cands[$row][$col]{$candidate};
                        delete $cands_idx[$candidate]{$idx};
                    }
                }
            }
        }
    }
    return $total_removals;
}

my $reduction = 1;
while ($reduction > 0) {
    $reduction = 0;
    check_neighboring_cells;
    print_idx_to_candidates;

    $reduction += eliminate_singleton_vals;
    print ("After removing singleton numbers \n");
    print_idx_to_candidates;

    $reduction += pick_reduced_singleton;
}

print "\nResultaat: \n";
for (my $row = 0; $row < $rows; $row++) {
    for (my $col = 0; $col < $cols; $col++) {
        my $num = (keys($row_col_cands[$row][$col]))[0];
        printf "%03d ", (keys($row_col_cands[$row][$col]))[0];
    }
    print "\n";
}
