my $filename = shift;

open(my $fd, "<", $filename) || die "Couldn't open file: $!\n";

my $X, $Y;
while (<$fd>) {
    if (m[<title>(\d+) by (\d+).*</title>]) {
        ($X, $Y)=($1, $2);
        last;
    }
}
<$fd>;

my @buren = ();
my %rand = ();

my $z = 0;
for my $row (1 .. $Y) {
    for my $col (1 .. $X) {
        $z++;
        print $z . "\n";
        # eerste verz -> mapt per index zijn naburige andere indices
        # 0 -> boven, 1 -> links, 2 -> rechts, 3 -> onder
        # ervan uitgaan dat alle buren initieel bereikbaar zijn
        # opletten voor randen: waarde 0 ipv buurindex
        $buren[$z][0] = ($row == 1) ? 0 : $z - $X;
        $buren[$z][1] = ($col == 1) ? 0 : $z - 1;
        $buren[$z][2] = ($col == $X) ? 0 : $z + 1;
        $buren[$z][3] = ($row == $Y) ? 0 : $z + $X;

        my $x1 = $col;
        my $x2 = $col + 1;
        my $y1 = $row;
        my $y2 = $row + 1;

        # tweede verzameling,
        # mapt per potentiële rand welke indices zijn buren zijn
        # uit standpunt van de buur!!
        push @{$rand{$x1}{$y1}{$x2}{$y1}},[$z,0];
        push @{$rand{$x1}{$y1}{$x1}{$y2}},[$z,1];
        push @{$rand{$x2}{$y1}{$x2}{$y2}},[$z,2];
        push @{$rand{$x1}{$y2}{$x2}{$y2}},[$z,3];
    }
}

print "\n # Burenlijst (hindernissen negerend): \n\n";
for my $z (1 .. $#buren) {
    print "$z: \t";
    print join "\t", @{$buren[$z]};
    print "\n";
}

my @wanden = ();

my $line = <$fd>;
my $width = 16;
while ($line =~ m[\s+<line x1=\"(\d+)\" y1=\"(\d+)\" x2=\"(\d+)\" y2=\"(\d+)\" />]) {
    my $x1 = $1;
    my $x2 = $3;
    my $y1 = $2;
    my $y2 = $4;

    if ($x1 > $x2) {
        ($x1, $x2) = ($x2, $x1);
    }

    if ($y1 > $y2) {
        ($y1, $y2) = ($y2, $y1);
    }

    $x1 /= $width;
    $x2 /= $width;
    $y1 /= $width;
    $y2 /= $width;

#    print "$x1 -> $x2 ; $y1 -> $y2\n";

    # horizontale wand
    if ($y1 == $y2) {
        # x waarden opslitsen
        for my $curr_x ($x1 .. $x2 - 1) {
#             print $curr_x . " ";
              push @wanden, [$curr_x, $y1, $curr_x + 1, $y1];
        }
    } else {
        # vert wand
        # y waarden opslitsen
        for my $curr_y ($y1 .. $y2 - 1) {
#            print $curr_y . " ";
             push @wanden, [$x1, $curr_y, $x1, $curr_y + 1];
        }
    }
    print "\n";

    $line = <$fd>;
}
close($fd);


for (@wanden) {
    my ($x1, $y1, $x2, $y2) = @{$_};
#    print "$x1 $y1 $x2 $y2\n";
    for $burenRef (@{$rand{$x1}{$y1}{$x2}{$y2}}) {
#        print join ":", @{$burenRef};
#        print "\n";
        $buren[$burenRef->[0]][$burenRef->[1]] = undef;
    }
#    print "\n";
}

# omzetten naar burenhash :-)
print "# Burenlijst (rekeninghoudend met wanden)\n";
for my $z (1.. $#buren) {
    my %new_hash = ();

    for (grep {defined $_} @{$buren[$z]}) {
        $new_hash{$_}=undef;
    }
    $buren[$z]=\%{new_hash};
    print "z: \t";
    print join "\t", sort { $a <=> $b } keys %{$buren[$z]};
    print "\n";
}
print "\n";

# burenlijsten schrappen
print "# Eindcellen in opeenvolgende iteraties: \n";
my $yield = 1;
while ($yield) {
    $yield = 0;
    my @deleted = ();
    for my $z (1 .. $#buren) {
        if (! defined $buren[$z] || scalar keys %{$buren[$z]} != 1) {
            next;
        }
        my ($neighb) = keys %{$buren[$z]};
        $buren[$z]=undef;
        delete $buren[$neighb]{$z};
        $yield = 1;
        push @deleted, $z;
    }
    if (scalar @deleted > 0) {
        print "- ";
        print join " ", @deleted;
        print "\n";
    }
}

print "\n#Burenlijst na eliminatie doodlopende paden:\n";
for $z (1 .. $#buren) {
    if (!defined $buren[$z]) {
        next;
    }
    print "$z: \t";
    print join "\t", keys %{$buren[$z]};
    print "\n";
}
print "\n";

# opsporen uitgangen
my $idx_in = 0;
my $idx_uit = 0;
for my $z (1 .. $#buren) {
    if (!defined $buren[$z]) {
        next;
    }
    if ((grep {$_ == 0} keys %{$buren[$z]}) > 0)  {
        if ($idx_in == 0) {
            $idx_in = $z;
        } else {
            $idx_uit = $z;
            last;
        }
    }
}

#print "in: $idx_in, uit: $idx_uit\n";

my @pad = ();
my $prev = 0;
my $curr = $idx_in;
while ($curr != 0) {
    push @pad, $curr;
    my ($next) = grep { $_ != $prev } keys %{$buren[$curr]};
    $prev = $curr;
    $curr = $next;
}

print "# Pad:\n";
print join " ", @pad;
print "\n";


$/ = undef;

open($fd, "<", $filename);

my $res = <$fd>;
close($fd);
$res =~ /(.*<\/title>\s+)(.*)/sm;
my $res = $1 . "<g fill=\"#FF0000\" stroke=\"none\">\n";

for my $z (@pad) {
    my $x1 = ($z - 1) % $X + 1;
    my $y1 = int(($z - 1) / $X) + 1;
    $x1 *= 16;
    $y1 *= 16;
    $x2 = $x1 + 16;
    $y2 = $y1 + 16;

    $res .= "   <polygon points=\"$x1,$y1 $x2,$y1 $x2,$y2 $x1,$y2\" />\n";
}

$res .= "  </g>\n$2" ;

open($fd, ">", "fixtures/svg/test.svg") || die "oeps";

print $fd $res;

close($fd);
