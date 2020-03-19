#!/usr/bin/perl

# Verwerk een string karakter per karakter. Pas dit toe om:

#een gesorteerde lijst uit te printen van alle karakters die minstens éénmaal in een string voorkomen.
my $zin = "een zin met meerdere karakters enzo";

my %uniq = ();

foreach my $char (split('', $zin)) {
    $uniq{$char}++;
};

print "uniq: ", sort(keys %uniq), "\n";


# an een bestand elk karakter individueel naar standaard uitvoer weg te schrijven,
# # met telkens een kleine tussenpause ertussen.
#  Maak hierbij gebruik van de select functie om de pauzes te genereren.
# Stel ook $| in op 1, om de output niet te laten bufferen.
$| = 1;
while (<DATA>) {
    for (split(//)) {
        print;
        select(undef,undef,undef, 0.005 * 1);
    }
}

__DATA__
dit is een lange
zin met
veel
karakter \r