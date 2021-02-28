use strict;

open(my $fh, "<", "./regios.csv") or die "couldn't open file";

my %hash = ();
while (<$fh>) {
    chomp;
    my ($regio, $ouder, $population, $area) = split ";";
    $hash{$regio} = {
        regio     => $regio,
        ouder     => $hash{$ouder},
        kinderen  => [],
        population => $population,
        aantal    => 0,
        niveau    => $hash{$ouder}->{niveau} + 1,
        area    => $area
    };

    push @{ $hash{$ouder}->{kinderen} }, $hash{$regio};

    next unless $population;

    my $refOuder = $hash{$ouder};
    while ($refOuder) {
        $refOuder->{population} += $population;
        $refOuder->{area} += $area;
        $refOuder->{aantal} += 1;
        $refOuder = $refOuder->{ouder};
    }
}

# extensie 1 : oplijsting -> volg grootste bevolkingsaantal
my $refKnoop = $hash{Belgie};
my @stack = ($refKnoop);

%hash = (); # expliciete hash niet meer nodig;
           # zolang we verwijzingen hebben geen GC

while ($refKnoop) {
    print "Knoop: ", $refKnoop->{"regio"}, "\n";
    print "Kinderen: ",
        join (" ",
                map( ($_->{regio}), sort @{ $refKnoop->{kinderen} } )
        ), "\n";
    print "#gemeenten: ", $refKnoop->{"aantal"}, "\n";
    print "Bevolking: ", $refKnoop->{"population"}, "\n";
    print "area: ", $refKnoop->{"area"}, "\n";
    print "\n";

    ($refKnoop) = sort { $b->{population} <=> $a->{population} } @{ $refKnoop->{kinderen} };
}

# extensie 2 -> depth first iteratie over de elementen

my $curr_knoop;
while (scalar(@stack)) {
    $curr_knoop = shift(@stack);
    unshift(@stack, sort { $b->{populatie} <=> $a->{populatie} }  @{ $curr_knoop->{kinderen} });
    printf "%-60s %8d %6d\n",(("      "x($curr_knoop->{niveau}-1)).$curr_knoop->{regio}),$curr_knoop->{population},$curr_knoop->{area};
}
