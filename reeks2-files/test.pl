
$/="";
open(FH, "<", "best") || print($!);

@lines=(<FH>);
for $line (reverse @lines) {
    chomp;
    print $line;
}