# Inverteer een hash

%test = (
	"eend" => "kwak",
	"hond" => "woef",
	"kat" => "miauw",
	"vis" => "blub"
);

%testrev = reverse %test;

while (($key, $val) = each(%testrev)) {
	print $key . " => " . $val . "\n";
}
