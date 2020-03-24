# Hoe kun je de inhoud van een hash tonen, waarbij een duidelijk onderscheid gemaakt wordt tussen de indices en hun corresponderende waarden. 
# Eenvoudige pogingen zoals print"%hash" of print %hash blijken niet te voldoen.
%test = (
	"eend" => "kwak",
	"hond" => "woef",
	"kat" => "miauw",
	"vis" => "blub"
);

while (($key, $val) = each(%test)) {
	print $key . " => " . $val . "\n";
}
