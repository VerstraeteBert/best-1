# Hoe kun je een variabele instellen met een default waarde, 
# enkel op voorwaarde dat die variabele op dat ogenblik geen waarde heeft ?
use strict;

my $gevuld = "eerste juist";
my $leeg;

my $test_gevuld = $gevuld || 'dit is fout';
my $test_leeg = $leeg || 'tweede juist';

print $test_gevuld . "\n";
print $test_leeg . "\n";

undef $test_leeg;

$test_leeg ||= 'dit is juist';

print $test_leeg . "\n";

# If 0, "0", and "" are valid values for your variables, use defined instead:
my $a;
my $c = 'test';
$a = defined($b) ? $b : $c;
print $a . "\n";