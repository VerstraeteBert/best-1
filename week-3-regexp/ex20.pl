# Lees een tekstbestand paragraaf per paragraaf in.
# Verpak de eerste lijn in elke paragraaf in <H1>...</H1> HTML-tags,
# op voorwaarde dat die lijn begint met een string van volgende gedaante:
# "Chapter xx: ..." .
# Gebruik hierbij een reguliere expressie met betrekking tot een string die meerdere lijnen omvat.
# De metatekens . , ^ , en $ vergen dan ook een bijzondere behandeling.

$/ = '';
while (<DATA>) {
    s/
        \A # start of string
        (
            Chapter
            \S+ # (one or more) manadatory whitespace
            \d+ # (one or more) decimal number
            : # colon seperation to rest of str
            .* # anything else after chapter
        )$ # put this in $1
        /<H1>$1<\H1>/gx;
    print;
}

__DATA__
Chapter 23: hi
this is a test 23

Chapter 3: hi again
this shouldn't be in H1