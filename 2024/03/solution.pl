#!/usr/bin/env perl

use v5.34;
use strict;
use warnings;

my $file = $ARGV[0] or die "Supply an input file";
open(my $fh, '<:encoding(UTF-8)', $file) or die "Unable to open $file: $!";

my $total1 = 0;
my $total2 = 0;
my $enable = 1;

while ( my $line = <$fh> ) {
    $line =~ s/^\s+|\s+$//g;

# Part 1
    my @matches = $line =~ /mul\((\d+),(\d+)\)/g;
    for (my $i = 0; $i < scalar @matches; $i += 2) {
        $total1 += $matches[$i] * $matches[$i+1];
    }

    @matches = $line =~ /(?:(mul|do|don't)\((?:(\d+),(\d+))?\))/g;
    for (my $i = 0; $i < scalar @matches; $i += 3) {
        if ( $matches[$i] eq "do" ) {
            $enable = 1;
        } elsif ( $matches[$i] eq "don't" ) {
            $enable = 0;
        } elsif ( $matches[$i] eq "mul" && $enable ) {
            $total2 += $matches[$i+1] * $matches[$i+2];
        }
    }
}
close $fh;

say "Day 3";
say "Part 1: $total1";
say "Part 2: $total2";
