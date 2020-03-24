# Construeer een test die nagaat of een string enkel (een willekeurig aantal) decimale getallen bevat,
# van elkaar gescheiden door whitespace. Maak de constructie opnieuw zo leesbaar mogelijk voor anderen.

$string_1 = " 0.26 +0.83 -435.34 ";
$string_2 = "0.26 ehfzf +345";

$number = '
    [-+]? # optional sign
    \d+ # at least one digit
    \.? # optional .
    \d* # optional digits after dot
';

if ($string_1 =~ m{
        ^\s*              # optional leading whitespace
        $number             # at least one number
        (?:                 # begin optional cluster
        \s+            # must have some separator
        $number         # more the next one
        )*                 # repeat at will
        \s*$              # optional trailing whitespace
}x) {
    print "string 1 is good";
}

if ($string_2 = m{
    ^\s*              # optional leading whitespace
        $number             # at least one number
        (?:                 # begin optional cluster
        \s+            # must have some separator
        $number         # more the next one
        )*                 # repeat at will
        \s*$              # optional trailing whitespace
}x) {
    print "string 2 is good";
}
