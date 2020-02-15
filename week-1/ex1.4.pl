# Bepaal de inverse van een willekeurige, uit woorden samengestelde string:
use strict;

my $zin = "Was it a car or a cat I saw?";

print "Orig: " . $zin . "\n";

print "Reverse chars: " . reverse($zin) . "\n";

print "Reverse words: " . join(" ", reverse(split(" ", $zin))) . "\n";