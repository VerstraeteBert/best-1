@test = ('pol', 'tom', 'bert');
for (0..$#test) {
	print @test[$_];
	if ($_ == $#test - 1) {
		print " en ";
	}  elsif ($_ != $#test) {
		print ", ";
	}
}
