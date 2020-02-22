$\ = ' ';
$/ = ' ';
my $str = 'test zin met meerdere woorden';


my @arr1 = ('test', 'zin', 'met', 'meerdere', 'woorden');
print @arr1;

my @arr2 = qw (test zin met meerdere woorden);
print @arr2;


my @arr3;

while (<DATA>) {
	chomp;
	push @arr3, $_
}
print @arr3;

__DATA__
hallo
dit
is
een
zin
