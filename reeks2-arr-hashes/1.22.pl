# Verwerk de elementen van een array, zoals je dat met pop of shift zou doen, maar nu meerdere elementen ineens.

# remove $N elements from front of @ARRAY (shift $N)
@FRONT = splice(@ARRAY, 0, $N);

# remove $N elements from the end of the array (pop $N)
@END = splice(@ARRAY, -$N);

# push(@a,$x,$y)      splice(@a,@a,0,$x,$y)
# pop(@a)             splice(@a,-1)
# shift(@a)           splice(@a,0,1)
# unshift(@a,$x,$y)   splice(@a,0,0,$x,$y)
# $a[$i] = $y         splice(@a,$i,1,$y)