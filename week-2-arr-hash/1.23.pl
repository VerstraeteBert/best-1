# Verwerk de elementen van een array circulair: na het laatste element moeten opnieuw 
# het eerste en alle daaropvolgende elementen telkens opnieuw afgelopen worden.
@test = (1,2,3,4);

for (1..1000) {
	print $test[0] . " ";
	if ($test[0] == 4) {
		print "\n";
	}
	$tmp = shift @test;
	push(@test, $tmp);
	sleep 1;
}
