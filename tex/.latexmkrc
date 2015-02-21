our %externalflag = ();

$pdflatex = 'internal mypdflatex %O %S %B';

sub mypdflatex {
    our %externalflag;
    my $n = scalar(@_);
    my @args = @_[0 .. $n - 2];
    my $base = $_[$n - 1];

    system 'pdflatex', @args;
    if ($? != 0) {
        return $?
    }
    if ( !defined $externalflag->{$base} ) {
        $externalflag->{$base} = 1;
        system ("$make -j5 -f $base.makefile");
    }
    return $?;
}
