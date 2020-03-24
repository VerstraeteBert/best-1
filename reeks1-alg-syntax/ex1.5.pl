# Converteer een willekeurige string in uppercase of lowercase.
use strict;

my $test = "string";

$test = uc $test;

print "UPPER: " . $test . "\n";

print "LOWER: " . lc($test) . "\n";