# Bepaal dag, maand en jaar van de datum vandaag.
# Bepaal ook het nummer van de week in het jaar.

(my $mday, my $mon, my $year, my $wday, my $yday) = (localtime)[3,4,5,6,7];
print $mday . "-" . $mon . "-" . $year . "\n"; 

my $weeknum = int($yday / 7) + 1;
print $weeknum