my $aantal = 1;
my @prefix_aantal = ();
my %aantal_prefix = ();

for my $prefix (reverse 0..32) {
    $prefix_aantal[$prefix] = $aantal;
    $aantal_prefix{$aantal} = $prefix;
    $aantal *= 2;
}


my $super = $ARGV[0];
if (!defined $super) {
    print("No supernet supplied");
    exit(1);
}
shift @ARGV;

my @super_ip = split(/[\/\.]/, $super);

# shortened ip addr?
if (@super_ip < 5) {
    #add trailing zeros if necesary to form complete ip
    # 123.24/24 -> 123.24.0.0/24
    splice @super_ip,(@super_ip-1),0,(0)x(5-@super_ip);
}

my $start = 0;
for (0..3) {
    $start = $start * 256 + $super_ip[$_];
}

if ($start % $prefix_aantal[$super_ip[4]]) {
    $super_ip[4]++ while $start%$prefix_aantal[$ip[4]];
    print "$super vereist minimaal /$super_ip[4]\n";
    exit(1);
}

my @sub_pool = ([$start, $prefix_aantal[$super_ip[4]]]);

while (@ARGV) {
    my $subnet = [$ARGV[0]];
    my @subnet_ip = split(/[\/\.]/, $subnet);

    if (@super_ip < 5) {
        splice @super_ip,(@super_ip-1),0,(0)x(5-@super_ip);
    }

    $start = 0;
    for (0..3) {
        $start = $start * 256 + $super_ip[$_];
    }

    $i = -1;
    my $found = 0;

    for $ref_super_ip (@sub_pool) {
        $i++;
        if ($start >= $super->[0] && $start < $super->[0] + $super->[1]) {
            $found = 1;
            if ($prefix_aantal[$ip[4]] == $super->[1]) {
                # supernet verwijderen indien = subnet
                splice @sub_pool, $i, 1;
                shift @ARGV; # volgend subnet behandelen
            }
            elsif ($prefix_aantal[$ip[4]] < $super->[1]) {
                # supernet opsplitsen  indien > subnet
                $helft = $super->[1] / 2;
                splice @sub_pool, $i, 1, ([ $super->[0], $helft ], [ $super->[0] + $helft, $helft ]);
            }
            last; # want toch geen overlappende supernetten mogelijk
        }

    }
    # subnet negeren indien supernet niet gevonden
    if (!$found) {
        shift @argv
    }
}

for $v (@sub_pool) {
    @ip=();                                    # 4 bytes netwerkadres + 1 byte prefixlenge
    for my $b (reverse 0..3) {
        $ip[$b]=$v->[0]%256;
        $v->[0]-=$ip[$b];
        $v->[0]/=256;
    }
    pop @ip while (@ip>1 && !$ip[-1]);         # trailing 0's verwijderen
    print join (".",@ip),"/$prefix{$v->[1]}\n";
}
