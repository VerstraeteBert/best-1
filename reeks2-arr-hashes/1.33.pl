# Op welke manieren kun je elk index-waarde paar van een hash element per element verwerken ? 
# Hou er rekening mee dat verwerken in gesorteerde volgorde al dan niet gewenst is.
%test = (
	"c" => 1,
	"d" => 2,
	"a" => 3,
	"b" => 4
);

# loop over keys
for $key (keys %test) {
	print $key . " ";
}
print "\n";

# sorted
for $key (sort(keys %test)) {
	print $key . " ";
}
print "\n";
