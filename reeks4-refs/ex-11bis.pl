$aantal=1/2;
for my $prefix (reverse 0..32) {
  $aantal*=2;
  $aantal[$prefix]=$aantal;
  $prefix{$aantal}=$prefix;
}

$error = 0;

for $net (@ARGV) {
    @ip = split(/[.\/]/, $net);
    # indien verkort -> vul aan met 0 bytes
    if (scalar(@ip) < 5) {
        splice @ip, scalar(@ip) - 1, 0, (0)x(5 - scalar(@ip));
    }

    $start = 0;
    for (0..3) {
        $start = $start * 256 + $ip[$_];
    }

    if ($start % $aantal[$ip[4]] != 0) {
        while ($start % $aantal[$ip[4]] != 0) {
            $ip[4]++;
        }
        print "$net vereist minimaal /$ip[4]\n";
        $error=1;
    }
    # enkel supernet (eerste ip in lijst pushen)
    if (scalar(@V) == 0) {
        @V=([$start, $aantal[$ip[4]]])
    }
}

if ($error) {
    exit(0);
}

shift @ARGV;

while (@ARGV) {
    @ip = split(/[.\/]/, $ARGV[0]);
    if (scalar(@ip) < 5) {
        splice @ip, scalar(@ip) - 1, 0, (0)x(5 - scalar(@ip));
    }
     $start = 0;
     for (0..3) {
        $start = $start * 256 + $ip[$_];
     }
     $aant = $aantal[$ip[4]];
     $indx = -1;
     $found = 0;
     for $super (@V) {
        $indx++;
        if ($start >= $super->[0] && $start < $super->[0] + $super->[1]) {
            # valt binnen bereik
            $found = 1;
            # samenvallend?
            if ($aant == $super->[1]) {
                # verwijderen, deze is volledige af
                splice @V, $indx, 1;
                shift @ARGV;
            } elsif ($aant < $super->[1]) {
                # supernet opslitsen in twee gelijke delen
                $helft = $super->[1] / 2;
                splice @V, $indx, 1, ([$super->[0], $helft], [$super->[0] + $helft, $helft]);
            }
            last;
        }
     }
     if (! $found) {
        shift @ARGV
     }
}

for $v (@V) {
    @ip=();
    for $b (reverse 0..3) {
        $ip[$b] = $v->[0]%256;
        $v->[0] -= $ip[$b];
        $v->[0] /= 256;
    }
    while (scalar(@ip) > 1 && !$ip[-1]) {
        pop @ip;
    }
    print join ('.', @ip),"/$prefix{$v->[1]}\n";
}
