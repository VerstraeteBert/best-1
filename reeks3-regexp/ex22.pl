# Soms is het noodzakelijk om niet de eerste, maar de Nde deelstring te vinden die aan een reguliere expressie voldoet.
# Filter bijvoorbeeld achtereenvolgens de woorden die voor het derde optreden
# en het laatste optreden van het woord "fish" staan in de string:

# Use the /g modifier in a while loop, keeping count of matches:

$WANT = 3;
$count = 0;
while (/(\w+)\s+fish\b/gi) {
    if (++$count == $WANT) {
        print "The third fish is a $1 one.\n";
        # Warning: don't 'last' out of this loop
    }
}
# The third fish is a red one.

# Or use a repetition count and repeated pattern like this:

/(?:\w+\s+fish\s+){2}(\w+)\s+fish/i;