# Lees opnieuw een tekstbestand paragraaf per paragraaf in.
# Filter met behulp van een reguliere expressie alle tekst die zich tussen twee specifieke kodes,
#  bijvoorbeeld START en END, die zich aan het begin van een lijn bevinden.
#  Deze kodes kunnen meerdere keren in elke paragraaf optreden.

$/ = '';
while (<DATA>) {
    while (/^START(.*?)^END/gsm) {
        print "chunk $. has <<$1>>\n";
    }
}

__DATA__
ezfgzegze
START dit is een tussen een kode
END
Sazda
START
bert
END