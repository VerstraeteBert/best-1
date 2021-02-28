open(my $fd, "<", "regios.csv");

my $line = <$fd>;

my %H = {};
while ($line) {
    my ($name, $parent, $pop, $opp) = split ";", $line;

    $H{$name} = {
        "name" => $name,
        "parent" => undef,
        "children" => [],
        "pop" => $pop,
        "opp" => $opp,
        "count" => 0
    };

    push @{$H{$parent}->{"children"}}, $H{$name};

    if ($parent) {
        $H{$name}->{"parent"} = $H{$parent};
    }

    if ($pop) {
        my $parent_ref = $H{$parent};
        while (defined $parent_ref) {
            $parent_ref->{"pop"} += $pop;
            $parent_ref->{"opp"} += $opp;
            $parent_ref->{"count"} += 1;
            $parent_ref = $parent_ref->{"parent"};
        }
    }

    $line = <$fd>
}

my $top_ref = $H{"Belgie"};
%H = undef;

my $cur_ref = $top_ref;
while ($cur_ref) {
    print "Knoop:\t" . $cur_ref->{"name"} . "\n";
    print "Kinderen: ",
        join (" ",
                map {$_->{"name"}} @{$cur_ref->{children}}
        ), "\n";
    print "#gemeenten:\t" . $cur_ref->{"count"} . "\n";
    print "population:\t" . $cur_ref->{"pop"} . "\n";
    print "area:\t" . $cur_ref->{"opp"} . "\n";
    print "\n";

    ($cur_ref) = sort { $b->{"pop"} <=> $a->{"pop"} } @{$cur_ref->{"children"}};
}

my @stack = ( $top_ref );
while (@stack) {
    my $cur_ref = shift @stack;
    print $cur_ref;
}
