$T = <>;

for (reverse 0..$#T) {
	if ($T[$_]=~/god/i) {
		splice @T,$_,1;
	}
}

print @T;