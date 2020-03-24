($rows, $cols) = (24, 80);
my $text = q(I am $rows high and $cols long);  # like single quotes!
$text =~ s/\$(\w+)/${$1}/g;
print $text;
#I am 24 high and 80 long

#When Perl is compiling your program and sees a /e on a substitute,
#  it compiles the code in the
# replacement block along with the rest of your program,
# long before the substitution actually happens.
#  When a substitution is made,
#  $1 is replaced with the string that matched.
# The code to evaluate would then be something like:
# 2 * 17

#We need to evaluate the result again to get the value of the variable.
# To do that, just add another /e:

$text =~ s/(\$\w+)/$1/eeg;          # finds my( ) variables
