#!/usr/bin/env perl

=head1 SYNOPSIS

Advent of Code 2024 Day 3 Solution

=head1 USAGE

C<day3> <filename>

=back

=head1 LICENSE

This software is released under the MIT License

=head1 AUTHOR

Skye Soss

=cut

use v5.34;
use strict;
use warnings;

my $file = $ARGV[0] or die "Supply an input file";
open(my $fh, '<:encoding(UTF-8)', $file) or die "Unable to open $file: $!";

my $total1 = 0;
my $total2 = 0;
my $enable = 1;

while ( my $line = <$fh> ) {
    my @matches = $line =~ /(?:(mul|do|don't)\((?:(\d+),(\d+))?\))/g;
    for (my $i = 0; $i < scalar @matches; $i += 3) {
        if ( $matches[$i] eq "do" ) {
            $enable = 1;
        } elsif ( $matches[$i] eq "don't" ) {
            $enable = 0;
        } elsif ( $matches[$i] eq "mul" ) {
            $total1 += $matches[$i+1] * $matches[$i+2];
            $total2 += $matches[$i+1] * $matches[$i+2] if $enable;
        }
    }
}
close $fh;

say "Day 3";
say "Part 1: $total1";
say "Part 2: $total2";
