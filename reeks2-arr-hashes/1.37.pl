# Stel een nieuwe hash samen op basis van twee bestaande hashes. 
# Je hoeft geen rekening te houden met indices die in beide originele hashes zouden voorkomen.

%hash1 = (
	"eend" => "kwak",
	"hond" => "woef",
	"kat" => "miauw",
	"vis" => "blub"
);

%hash2 = (
	"a" => 3,
	"b" => 2,
	"c" => 1,
);

%hashcomb = (%hash1, %hash2);

while (($key, $val) = each(%hashcomb)) {
	print $key . " => " . $val . "\n";
}
