@ARGV = "regios.csv";
while (<>) {
    chomp;
    ( $regio, $ouder, $population, $area ) = split ";";
    $hash{$regio} = { regio      => $regio,
                      ouder      => $hash{$ouder},
                      kinderen   => [],
                      number     => 0,
                      niveau     => 0,
                      population => $population,
                      area       => $area };
    push @{ $hash{$ouder}->{kinderen} }, $hash{$regio};

    for my $test (@{ $hash{$ouder}->{kinderen} }) {
        print $test;
    }

    $refouder = $hash{$regio}->{ouder};
    $hash{$regio}{niveau}=$refouder->{niveau}+1;
    next unless $population;

    while ($refouder) {
        $refouder->{number}     += 1;
        $refouder->{population} += $population;
        $refouder->{area}       += $area;
        $refouder = $refouder->{ouder};
    }
}
