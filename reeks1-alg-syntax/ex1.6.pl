# Rond a willekeurig floating-point getal af op een vooropgezet aantal decimale 
# cijfers (na de komma). Dit is ondermeer interessant om de uitvoer beter leesbaar # te maken, en bij problemen met het testen op gelijkheid (zie vraag 7).
use strict;

my $fp = 432.2325678909876;

print $fp . "\n";
print sprintf("%.2f", $fp);
