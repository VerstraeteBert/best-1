#regexp  
##character classes  
Matchen van meerdere mogelijke karakters met []

```
/cat/; -> matches "cat"
/[bra]at/; -> matches "cat", "rat", "bat"  
/item[0123456789]/; -> matches item0, item1, ... item9  
"abc" =~ /[cab]/; -> matches 'a'

/[yY][eE][sS]/; -> matches case insensitive yes  
/yes/i; -> idem als hierboven; /i duidt aan de het eeen case insenseitive search is  

/[\]c]def/ -> matches "cdef" of ]def; 
```

### Ranges
```
/item[0-9]/; # matches ’item0’ or ... or ’item9’  
/[0-9bx-z]aa/; # matches ’0aa’, ..., ’9aa’,  
               # ’baa’, ’xaa’, ’yaa’, or ’zaa’  
/[0-9a-fA-F]/; # matches a hexadecimal digit  
/[0-9a-zA-Z_]/; # matches a "word" character,  like those in a perl variable name 
/[0-9-]/; # matches number OR -; if - is used at the end or front or escaped it is treated as a normal characteer
```
#### Negation in ranges
```
/[^a]at/; # doesn’t match ’aat’ or ’at’, but matches all other ’bat’, ’cat, ’0at’, ’%at’, etc.  
/[^0-9]/; # matches a non-numeric character  
/[a^]at/; # matches ’aat’ or ’^at’; here ’^’ is ordinary   
```

## character shorthands
  - \d is a digit and represents [0-9]
  - \s is a whitespace character and represents [\ \t\r\n\f]
  - \w is a word character (alphanumeric or _) and represents [0-9a-zA-Z_]
  - \D is a negated \d; it represents any character but a digit [^0-9]
  - \S is a negated \s; it represents any non-whitespace character [^\s]
  - \W is a negated \w; it represents any non-word character [^\w]
  - The period '.' matches any character but "\n"

Can be used both in and outside of character classes

/\d\d:\d\d:\d\d/; # matches a hh:mm:ss time format  
/[\d\s]/; # matches any digit or whitespace character   
/\w\W\w/; # matches a word char, followed by a  non-word char, followed by a word char  
/..rt/; # matches any two chars, followed by ’rt’  
/end\./; # matches ’end.’  
/end[.]/; # same thing, matches ’end.’  

### word anchor
\b -> matches boundary between word
```
$x = "Housecat catenates house and cat";  
$x =~ /cat/; # matches cat in ’housecat’  
$x =~ /\bcat/; # matches cat in ’catenates’  
$x =~ /cat\b/; # matches cat in ’housecat’  
$x =~ /\bcat\b/; # matches ’cat’ at end of string -> \b can also signify end of string  
```
### Single line and multi line 
// -> default behavior  
 -  '.' matches anything except "\n" 
 -  '^' only beginning of str
 -  '$' end or before newline of str
    
//s -> treat full string as single line
 - '.' matches any character even \n
 - '^' en '$' idem als default  
  
//m -> multiline
 - '.' matches anything except '\n'
 - '^' en '$' start or end of any line within str    
 - start and end (with \n) of string can still be matched with \A (start) and \Z (end)  
 - end without newline can be matched with \z
 
//sm -> single long line, detect multiple lines
 - '.' matches anything even '\n'
 - '^' en '$' start or end of any line within str 
 - start and end of string can still be matched with \A (start) and \Z (end)  
 ```
$x = "There once was a girl\nWho programmed in Perl\n";  
$x =~ /^Who/; # doesn’t match, "Who" not at start of string  
$x =~ /^Who/s; # doesn’t match, "Who" not at start of string  
$x =~ /^Who/m; # matches, "Who" at start of second line  
$x =~ /^Who/sm; # matches, "Who" at start of second line  
$x =~ /girl.Who/; # doesn’t match, "." doesn’t match "\n"  
$x =~ /girl.Who/s; # matches, "." matches "\n"  
$x =~ /girl.Who/m; # doesn’t match, "." doesn’t match "\n"  
$x =~ /girl.Who/sm; # matches, "." matches "\n"   

$x =~ /^Who/m; # matches, "Who" at start of second line  
$x =~ /\AWho/m; # doesn’t match, "Who" is not at start of string  
$x =~ /girl$/m; # matches, "girl" at end of first line  
$x =~ /girl\Z/m; # doesn’t match, "girl" is not at end of string  
$x =~ /Perl\Z/m; # matches, "Perl" is at newline before end  
$x =~ /Perl\z/m; # doesn’t match, "Perl" is not at end of string 
```

## Matching this or that  
Alternation character |  
/dog|cat/; # matches dog or cat  
```
"cats and dogs" =~ /cat|dog|bird/; # matches "cat"  
"cats and dogs" =~ /dog|cat|bird/; # matches "cat" 

"cats" =~ /c|ca|cat|cats/; # matches "c"  
"cats" =~ /cats|cat|ca|c/; # matches "cats"  
"cab" =~ /a|b|c/ # matches "c"  /a|b|c/ == /[abc]/  
```
## grouping metacharacters
housecat|housekeeper -> house(cat|keeper)  

```
/(a|b)b/; # matches ’ab’ or ’bb’  
/(ac|b)b/; # matches ’acb’ or ’bb’  
/(^a|b)c/; # matches ’ac’ at start of string or ’bc’ anywhere  
/(a|[bc])d/; # matches ’ad’, ’bd’, or ’cd’  
/house(cat|)/; # matches either ’housecat’ or ’house’    
/house(cat(s|)|)/; # matches either ’housecats’ or ’housecat’ or ’house’. Note groups can be nested.  
/(19|20|)\d\d/; # match years 19xx, 20xx, or the Y2K problem, xx "20" =~ /(19|20|)\d\d/; # matches the null alternative ’()\d\d’, because ’20\d\d’ can’t match  
```

### extracting matches
groupings can be used to extract parts of matched string  

```
extract hours, minutes, seconds
if ($time =~ /(\d\d):(\d\d):(\d\d)/) { 
# match hh:mm:ss format
    $hours = $1;
    $minutes = $2;
    $seconds = $3;
}

OF

# extract hours, minutes, seconds
($hours, $minutes, $second) = ($time =~ /(\d\d):(\d\d):(\d\d)/);
```

#### backreferences
Analogous to $1, $2, ...; there's \1, \2, ...   
Refering to previous grouped matches, spotting for example multiple occurences of something.  

```
% simple_grep ’^(\w\w\w\w|\w\w\w|\w\w|\w)\1$’ /usr/dict/words
beriberi
booboo
coco
mama
murmur
papa

# doubles with space in between
/(\w\w\w)\s\1/;
```

#### position of matches
```
$x = "Mmm...donut, thought Homer";
$x =~ /^(Mmm|Yech)\.\.\.(donut|peas)/; # matches
foreach $expr (1..$#-) {
    print "Match $expr: ’${$expr}’ at position ($-[$expr],$+[$expr])\n";
}


Match 1: ’Mmm’ at position (0,3)
Match 2: ’donut’ at position (6,11)
```

## Matching repetitions 
Quantifier metacharacters ?, +, *, { }  

- a? = match 'a' 1 or 0 times
- a* = match 'a' 0 or more times
- a+ = match 1 or more times; at least once 
- a{n,m} = match at least n times, but at most m times
- a{n,} = match at least n times or more
- a{n} = match exactly n times

```
/[a-z]+\s+\d*/; # match a lowercase word, at least some space, and any number of digits
/(\w+)\s+\1/; # match doubled words of arbitrary length
/y(es)?/i; # matches ’y’, ’Y’, or a case-insensitive ’yes’
$year =~ /\d{2,4}/; # make sure year is at least 2 but not more than 4 digits
$year =~ /\d{4}|\d{2}/; # better match; throw out 3 digit dates
$year =~ /\d{2}(\d{2})?/; # same thing written differently. However, this produces $1 and the other does not.
% simple_grep ’^(\w+)\1$’ /usr/dict/words # isn’t this easier?
beriberi
booboo
coco
mama
murmur
papa
`````

```
$x = "the cat in the hat";
$x =~ /^(.*)(cat)(.*)$/; # matches,
    # $1 = ’the ’
    # $2 = ’cat’
    # $3 = ’ in the hat’
```

## matching principles
- Principle 0: Taken as a whole, any regexp will be matched at the earliest possible position in
the string.
- Principle 1: In an alternation , the leftmost alternative that allows a match for the
whole regexp will be the one used.
- Principle 2: The maximal matching quantifiers, and will in general match as much of the string as possible while still allowing the whole regexp to match.
- Principle 3: If there are two or more elements in a regexp, the leftmost greedy quantifier, if
any, will match as much of the string as possible while still allowing the whole regexp to
match. The next leftmost greedy quantifier, if any, will try to match as much of the string
remaining available to it as possible, while still allowing the whole regexp to match. And so on,
until all the regexp elements are satisfied.


```
$x = "The programming republic of Perl";
$x =~ /^(.+)(e|r)(.*)$/; # matches,
    # $1 = ’The programming republic of Pe’
    # $2 = ’r’
    # $3 = ’l’

$x =~ /(m{1,2})(.*)$/; # matches,
# $1 = ’mm’
# $2 = ’ing republic of Perl’

$x =~ /.*(m{1,2})(.*)$/; # matches,
# $1 = ’m’
# $2 = ’ing republic of Perl’

$x =~ /(.?)(m{1,2})(.*)$/; # matches,
# $1 = ’a’
# $2 = ’mm’
# $3 = ’ing republic of Perl’

"aXXXb" =~ /(X*)/; # matches with $1 = ’’
# can also match on 0 X's -> will do so
```

## Minimal matching
??, *?, +?, and {}?

- a?? matches 'a' 0 or 1 times, try 0 first then 1;
- a*? matches 'a' 0 or more times, as few times as possible;
- a+? matches 'a' at least once, but as few times as possible;
- a{n,m}, at least n times, at most m; as few times;

```
$x = "The programming republic of Perl";
$x =~ /^(.+?)(e|r)(.*)$/; # matches,
# $1 = ’Th’
# $2 = ’e’
# $3 = ’ programming republic of Perl’


$x =~ /(.*?)(m{1,2}?)(.*)$/; # matches,
# $1 = ’The progra’
# $2 = ’m’
# $3 = ’ming republic of Perl’

$x =~ /(.??)(m{1,2})(.*)$/; # matches,
# $1 = ’a’
# $2 = ’mm’
# $3 = ’ing republic of Perl’
```

## using regexp in perl
=~, !~ -> inverse van =~  
"dog" =~ /d/; matches d`


### //g and //c
//g 
-  global matching, allows for multiple matches within the same string
-  succesive invocations will jump to the next match
-  get the position of the match with `pos()`

```
$x = "cat dog house"; # 3 words
$x =~ /^\s*(\w+)\s+(\w+)\s+(\w+)\s*$/; # matches,
# $1 = ’cat’
# $2 = ’dog’
# $3 = ’house’

# vb zonder //g -> er moeten 3 groupings aangemaakt worden

# MET //G

while ($x =~ /(\w+)/g) {
    print "Word is $1, ends at position ", pos $x, "\n";
}
#Word is cat, ends at position 3
#Word is dog, ends at position 7
#Word is house, ends at position 13

# in list context
@words = ($x =~ /(\w+)/g); # matches,
# $word[0] = ’cat’
# $word[1] = ’dog’
# $word[2] = ’house’
```

//c 
  - a failed match or with //g reset the position
  - //c prevents this
 
\G   
Closely associated with the modifier is the anchor. The anchor matches at the point where
the previous match left off. allows us to easily do context-sensitive matching:  

```
$metric = 1; # use metric units
...
$x = <FILE>; # read in measurement
$x =~ /^([+-]?\d+)\s*/g; # get magnitude
$weight = $1;
if ($metric) { # error checking
    print "Units error!" unless $x =~ /\Gkg\./g;
}
else {
    print "Units error!" unless $x =~ /\Glbs\./g;
}
$x =~ /\G\s+(widget|sprocket)/g; # continue processing


while ($dna =~ /\G(\w\w\w)*?TGA/g) {
    print "Got a TGA stop codon at position ", pos $dna, "\n";
}
#Got a TGA stop codon at position 18
```

### Search and replace
s///  
s/regexp/replacement/modifiers  
```
$x = "Time to feed the cat!";
$x =~ s/cat/hacker/; # $x contains "Time to feed the hacker!"
if ($x =~ s/^(Time.*hacker)!$/$1 now!/) {
    $more_insistent = 1;
}

$y = "’quoted words’";
$y =~ s/^’(.*)’$/$1/; # strip single quotes,
# $y contains "quoted words"
```

s///g

```
$x = "I batted 4 for 4";
$x =~ s/4/four/; # doesn’t do it all:
# $x contains "I batted four for 4"
$x = "I batted 4 for 4";
$x =~ s/4/four/g; # does it all:
# $x contains "I batted four for four"
```

s///ge
///e -> laat toe om logica te runnen tijdens replacing
```
$x = "Bill the cat";
$x =~ s/(.)/$chars{$1}++;$1/eg; # final $1 replaces char with itself
print "frequency of ’$_’ is $chars{$_}\n"
foreach (sort {$chars{$b} <=> $chars{$a}} keys %chars);
```

### split function
split($regexp, $str);
```
$x = "Calvin and Hobbes";
@words = split /\s+/, $x; 
# $word[0] = ’Calvin’
# $word[1] = ’and’
# $word[2] = ’Hobbes’
```

Splitting into individual characters
```
$test = "hanlonk";
@chars = split(//, $test)
# $chars[0] = 'h'
# $chars[1] = 'a'
# ...
```
