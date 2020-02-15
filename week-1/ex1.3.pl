# Geef de (numerieke) ascii-waarde weer van een willekeurig karakter. 
# Geef de karakterrepresentatie weer van een willekeurige numerieke ascii-waarde.
use strict;

my $a = 81;
my $b = 'd';

# ord -> return numeric value of first char of the EXPR
print $b . ': ' . ord($b) . "\n";

# chr -> returns char respresented by number in charset
print $a . ': ' . chr($a) . "\n";
