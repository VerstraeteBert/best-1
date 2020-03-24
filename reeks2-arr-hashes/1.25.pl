@arr = (1,2,3,4,5,6);

@arr_res = ();

foreach $el (@arr) {
	if ($el >= 3) {
		push(@arr_res, $el);
	}
}

print @arr_res . "\n";

# of met grep -> grep returnt all waarden in arr die aan een voorwaarde voldoen
@arr_res2 = grep { $_ < 3 } @arr;

print @arr_res2;
