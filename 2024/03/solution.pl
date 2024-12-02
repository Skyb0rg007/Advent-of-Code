#! /usr/bin/env perl

use v5.34;
use strict;
use warnings;

my $file = $ARGV[0] or die "Supply an input file";
open(my $fh, '<:encoding(UTF-8)', $file) or die "Unable to open $file: $!";
while ( my $line = <$fh> ) {
    $line =~ s/^\s+|\s+$//g;
    say "\$line = '$line'";
}
close $fh;
