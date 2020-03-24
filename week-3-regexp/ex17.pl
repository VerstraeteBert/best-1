# Gebruik de range operatoren, .. en ..., om van een bestand,
# dat je nu opnieuw lijn per lijn inleest, alle tekst te filteren
# die zich tussen twee specifieke kodes bevindt.
# Deze kodes kunnen meerdere keren in het bestand optreden.
# Pas deze methode eveneens toe om lijnen met lijnnummers in een specifiek interval te filteren.

# The .. operator will test the right operand on the same iteration
# that the left operand flips the operator into the true state.
while (<>) {
    if (/BEGIN PATTERN/ .. /END PATTERN/) {
        # line falls between BEGIN and END in the
        # text, inclusive.
    }
}

while (<>) {
    if (FIRST_LINE_NUM .. LAST_LINE_NUM) {
        # operate only between first and last line, inclusive.
    }
}

# But the ... operator waits until the next iteration to check the right operand.
while (<>) {
    if (/BEGIN PATTERN/ ... /END PATTERN/) {
        # line is between BEGIN and END on different lines
    }
}

while (<>) {
    if (FIRST_LINE_NUM ... LAST_LINE_NUM) {
        # operate only between first and last line, not inclusive
    }
}


# print all <XMP> .. </XMP> displays from HTML doc
while (<>) {
    print if m#<XMP>#i .. m#</XMP>#i;
}

