# Hoe kun je bewerkingen uitvoeren op een rij getallen, 
# bestaande uit alle gehele getallen tussen X en Y ?
use strict;

my $LOWER = 2;
my $UPPER = 20;

for (my $i = $LOWER; $i <= $UPPER; $i++) {
	print $i . ",";
} 
print "\n";

# of
foreach ($LOWER..$UPPER) {
	print $_ . ","
}