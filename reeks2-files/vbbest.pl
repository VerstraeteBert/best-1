# <> leest één lijn in van stdin
#$x = <DATA>;
#print "$x\n";

# LIJN MODE
# while ( <BEST1>, <BEST2>, ...) {}
#while (<DATA>) {
#	chomp; # om dubbele lijnscheidingen te voorkomen (standaard \n toegevoegd)
#	print "$_\n";
#}


# PARAGRAAF MODE
$/=""; # sep teken "" -> paragraaf mode (per lezen scannen tot lege lijn!)
$x=0;
while (<DATA>) {
	$x++;
	chomp;
	print "$_\n";
}
print "$x\n";

# SLURP MODE -> volledig bestand ineens lezen
undef $/;
$x=0;
while (<DATA>) {
	$x++;
	chomp;
	print "$_\n";
}
print "$x\n";

$T=<>;

print scalar @T[-1], scalar @T;

# verdere interessante link
# read-write mode 
# https://www.arl.wustl.edu/projects/fpx/references/perl/cookbook/ch07_10.htm


__DATA__
nul
een
twee

drie
vier

vijf

zes
zeven
acht

negen
tien