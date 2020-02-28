@arr = (20, 4, 8, 9, 2, 3, 21, 20);

# <=> -> numerical comparison operator
@arr = sort { $a <=> $b } @arr;

print "@arr";
