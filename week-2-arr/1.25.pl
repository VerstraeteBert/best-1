@arr = (1,2,3,4,5,6);

@arr_res = ();

foreach $el (@arr) {
	if ($el >= 3) {
		push(@arr_res, $el);
	}
}

print @arr_res;
