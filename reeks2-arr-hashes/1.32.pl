# Verwijder een hash element met een specifieke index. Hoe kan dit veralgemeend worden tot meerdere elementen ?
%test = (
	"test1" => 1,
	"test2" => 2,
	"test3" => 3,
	"test4" => 4
);

delete $test{"test1"};

print keys(%test);
print "\n";

delete @test{"test2", "test4"};
print keys(%test);
print "\n";
