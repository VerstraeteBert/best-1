use strict;

my $zin = "dit is een zin gescheiden met whitespace's";
# \s -> any whitespace character
# + -> at least once
my @arr = split /\s+/,$zin;

$, = "--";
print @arr;
print "\n";

# of
my $x = "test nog een_zin";
while ($x =~ /(\w+)/g) {
    print "Word is $1, ends at position ", pos $x, "\n";
}

#of
my @words = ($x =~ /(\w+)/g);
print @words;
print "\n";
