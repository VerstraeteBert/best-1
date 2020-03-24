use strict;

my $tekst = 'DISTFILES = $(DIST_COMMON) $(SOURCES) $(HEADERS) \
        $(TEXINFOS) $(INFOS) $(MANS) $(DATA)
DEP_DISTFILES = $(DIST_COMMON) $(SOURCES) $(HEADERS) \
        $(TEXINFOS) $(INFO_DEPS) $(MANS) $(DATA) \
        $(EXTRA_DIST)';

# verwijder \\n, verwijder ondertussen ook meerdere spaties
$tekst =~ s/\\\n|\s{2,}//g;

# verwerk per lijn
my $counter = 1;
for my $lijn (split("\n",$tekst)) {
    print "lijn $counter: $lijn\n";
    $counter++
}
