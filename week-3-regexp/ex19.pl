# Gebruik een reguliere expressie om alle dubbele woorden te vinden:
# woorden die in een paragraaf vlak na elkaar herhaald worden, enkel gescheiden met whitespace.

$/ = ''; # paragrep mode
while (<>) {
    while ( m{
        \b            # start at a word boundary (begin letters)
            (\S+)         # find chunk of non-whitespace
            \b            # until another word boundary (end letters)
            (
            \s+       # separated by some whitespace
            \1        # and that very same chunk again -> backreference
            \b        # until another word boundary
            )+           # one or more sets of those
    }xig
    )
    {
        print "dup word '$1' at paragraph $.\n";
    }
}