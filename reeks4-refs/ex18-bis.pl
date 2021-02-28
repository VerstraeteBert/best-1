use strict;

my $filename = $ARGV[0];

open(my $fd, "<", $filename) || die "Invalid file supplied: $!\n";

# houdt kandidaten per cel bij
my @cands_cell=();
# houdt overblijvende plekken per nummer bij
my @cand_cells=();
my @reeds_geprint = ();

my $line = <$fd>;
my $row = 0;
my $col = 0;
my $idx = 0;
while ($line) {
    $col = 0;
    while ($line =~ /\.*0*(\d*)\s+/g) {
        if ($1) {
            $cands_cell[$row][$col]{$1}=undef;
            $cand_cells[$1]{$idx}=undef;
            $reeds_geprint[$row][$col]=1;
#            print "$row $col $idx $1\n";
        }
        $col++;
        $idx++;
    }
    $row++;
    $line = <$fd>;
}

my $dim = $row; # N x N matrix

# fill cand_cells with remaning nums
my $N = $dim*$dim;
for (my $row = 0; $row < $dim; $row++) {
    for (my $col = 0; $col < $dim; $col++) {
        if (!defined $cands_cell[$row][$col]) {
            for (my $num = 1; $num <= $N; $num++) {
                if (!defined $cand_cells[$num]) {
                    $cands_cell[$row][$col]{$num}=undef;
                }
            }
        }
    }
}

# fill cand_cells
for (my $row = 0; $row < $dim; $row++) {
    for (my $col = 0; $col < $dim; $col++) {
        for my $num (keys %{$cands_cell[$row][$col]}) {
            $cand_cells[$num]{$row * $dim + $col}=undef;
        }
    }
}



sub print_cands_cell {
    print "CELL -> CANDIDATES:\n";
    for (my $row = 0; $row < $dim; $row++) {
        for (my $col = 0; $col < $dim; $col++) {
            print "IDX: $row.$col: ";
            for my $cand ( sort { $a <=> $b } keys %{$cands_cell[$row][$col]} ) {
                print "$cand, ";
            }
            print "\n";
        }
    }
    print "\n";
}

sub print_cand_cells {
    print "NUMS -> POSSIBLE CELLS:\n";
    for my $candidate (1 .. $dim * $dim) {
        print "NUM $candidate: ";
        for my $spot (sort { $a <=> $b } keys %{$cand_cells[$candidate]}) {
            print "$spot, ";
        }
        print "\n";
    }
    print "\n";
}

sub neighbor_contains {
    my $idx = shift;
    my $cand = shift;

    # boven; onder; links en rechts checken
    # opgelet bij links en rechts; meest linkse kolom heeft geen linkerbuur
    # analoog voor meest rechts kolom, geen rechterbuur
    # maakt niets uit voor bovenste rij en onderste rij :-)
    return (
            exists ($cand_cells[$cand]{$idx - $dim}) ||
            exists ($cand_cells[$cand]{$idx + $dim}) ||
            (($idx % $dim != 0) && exists $cand_cells[$cand]{$idx - 1}) ||
            (( $idx % $dim != $dim - 1) && exists $cand_cells[$cand]{$idx + 1})
        )
}


sub do_reduc_1 {

}

# pas reducties toe
my $yield = 1;
my $yield1 = 0;
my $yield2;
my $yield3;
while ($yield) {
    $yield = 0;

    # criterium 1
    my $i = -1;
    for (my $row = 0; $row < $dim; $row++) {
        for (my $col = 0; $col < $dim; $col++) {
            $i++;

            if (scalar keys %{$cands_cell[$row][$col]} == 1) {
                next;
            }

            for my $cand (keys %{$cands_cell[$row][$col]}) {
                my $valid = 1;
                if ($cand > 1 && !neighbor_contains($i, $cand - 1)) {
                    $valid = 0;
                }
                if ($valid && $cand < $N && !neighbor_contains($i, $cand + 1)) {
                    $valid = 0;
                }

                if (!$valid) {
                    $yield1++;
                    $yield++;
                    delete $cands_cell[$row][$col]{$cand};
                    delete $cand_cells[$cand]{$i};
                }
            }
        }
    }
    if ($yield) {
        next;
    }
    print_cands_cell;

    # criterium 2

    $yield2 = "";
    $yield = 1;

    while ($yield) {
        $yield = 0;
        my $i = -1;
        for (my $row = 0; $row < $dim; $row++) {
            for (my $col = 0; $col < $dim; $col++) {
                $i++;
                if (scalar(keys %{$cands_cell[$row][$col]}) != 1) {
                    next;
                }

                my ($num) = keys %{$cands_cell[$row][$col]};
                for my $idx_to_remove (keys $cand_cells[$num]) {
                    if ($idx_to_remove != $i) {
                        $yield++;
                        delete $cands_cell[int($idx_to_remove / $dim)][$idx_to_remove % $dim]{$num};
                        delete $cand_cells[$num]{$idx_to_remove}
                    }
                }
                if (!$reeds_geprint[$row][$col]) {
                    $yield2 .= "($row.$col)=$num ";
                    $reeds_geprint[$row][$col]=1;
                }
            }
        }
    }

    if ($yield2) {
        print "# cel(len) met slechts 1 kandidaat:\n";
        print $yield2;
        print "\n\n";
    }

    $yield = $yield2;
    next if $yield2;

    # reductie criterium 3
    $yield3 = "";
    for (my $num = 1; $num <= $N; $num++) {
                # reduced to singleton
        if (scalar keys $cand_cells[$num] == 1) {
            my $idx = (keys $cand_cells[$num])[0];
            my $row = int($idx / $dim);
            my $col = $idx % $dim;

           for my $other_num (keys %{$cands_cell[$row][$col]}) {
                if ($other_num == $num) {
                    next;
                }
                delete $cands_cell[$row][$col]{$other_num};
                delete $cand_cells[$other_num]{$idx};
                $yield = 1;
                $reeds_geprint[$row][$col] = 1;
                $yield3 .= "($row.$col=$num) ";
           }
        }
    }

    if ($yield3) {
        print "# getal(len) slechts mogelijk in 1 enkele cel\n";
        print $yield3;
        print "\n\n";
    }
    $yield = $yield3;
}

print "RESULTAAT:\n";
for (my $row = 0; $row < $dim; $row++) {
    for (my $col = 0; $col < $dim; $col++) {
        printf "%-3d ", (keys %{$cands_cell[$row][$col]})[0];
    }
    print "\n";
}
