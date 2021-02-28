@ARGV=("overwinningen.csv");

@S=<>;

print
    map {$_->[-1]}
    sort {
        $a->[1] cmp $b->[1]
                ||
        $b->[2] <=> $a->[2]
    }
    map {[ (split ';', $_), $_ ]}
    @S;