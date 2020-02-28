# Voeg alle elementen van een array toe aan een andere array.
@arr1 = (1, 2, 3);
@arr2 = (-1);

@arr2 = (@arr2, @arr1);

print @arr2;
