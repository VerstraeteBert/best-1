# Hoe kun je best twee willekeurige floating-point getallen met elkaar vergelijken,
# enkel rekening houdend met een specifiek aantal decimale cijfers (na de komma) ?

my $a = 1.234568;
my $b = 1.234568;
my $c = 1.234267;

my $EPS = 0.000001;

print "a == b? " . (abs($a - $b) < 0.000001) . "\n";
print "a == c? " . (abs($a - $c) < 0.000001) . "\n";

# opl moreau
#   my ($A, $B);
#    if (sprintf("%.${dp}g", $A) eq sprintf("%.${dp}g", $B)) {...}
#  }
