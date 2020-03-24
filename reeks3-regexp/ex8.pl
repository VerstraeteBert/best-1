# Verwerk een bestand woord per woord, bijvoorbeeld om een frequentietabel
# te construeren met een teller voor elk optredend woord.

my %freq = ();
while (<DATA>) {
    for my $chunk (split) {
        #verwerk
        $freq{$chunk}++;
    }
}

for my $key (keys %freq) {
    print "$key -> $freq{$key}\n";
}

# of

while (<DATA>) {
    while ( /(\w[\w'-]*)/g ) {
        # do something with $1
    }
}


__DATA__
dit is een lange zin en en

met meerdere    lijnen lijnen