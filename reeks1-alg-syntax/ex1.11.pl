# Hoe kun je binaire ("0b10110", ...), octale ("0755" ...), of hexadecimale 
# ("0x55", ...) representaties van getallen omvormen in hun decimale vorm ? 
use strict;

my $biny = '0b10110';
my $octy = '0755';
my $hexy = '0x55';

print oct($biny) . " " . oct($octy) . " " . oct($hexy);
