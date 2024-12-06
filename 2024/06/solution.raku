#!/usr/bin/env raku

# "Hello from Raku!".say;

my @map = @*ARGS[0].IO.lines.map: *.comb(1).Array ;
my $nrows = @map.elems;
my $ncols = @map[0].elems;

my (Int $start-y, List $row) = @map.first: /\^/, :kv;
my Int $start-x = $row.first: /\^/, :k;
@map[$start-y][$start-x] = '.';

sub visit(Int:D $x_, Int:D $y_ --> List) {
    my Int $x = $x_;
    my Int $y = $y_;
    my SetHash[Str] $visited .= new;
    my SetHash[Str] $seen .= new;

    my (Int:D $dx, Int:D $dy) = (0, -1);

    while !$visited{"$x,$y,$dx,$dy"} {
        $visited.set("$x,$y,$dx,$dy");
        $seen.set("$x,$y");
        my ($x1, $y1) = ($x+$dx,$y+$dy);
        return ($seen.Set, False) unless 0 <= $y1 < $nrows and 0 <= $x1 < $ncols;
        given @map[$y1][$x1] {
            when '.' {
                $x += $dx;
                $y += $dy;
            }
            when '#' | 'O' {
                # Rotate 90 degrees to the right
                ($dx, $dy) = (-$dy, $dx);
            }
            default {
                say "Error!";
                last;
            }
        }
    }

    return ($seen.Set, True);
}

my ($visited,) = visit($start-x, $start-y);
say "Day 6";
say "Part 1: ", $visited.elems;

my Int $loops;
my Int $n;
for $visited.keys -> $square {
    my ($block-x, $block-y) = $square.split: /','/;

    $n++;
    # say "n = $n, loops = $loops" if $n %% 100;

    @map[$block-y][$block-x] = 'O';

    my $loop = visit($start-x, $start-y)[1];
    $loops += 1 if $loop;

    @map[$block-y][$block-x] = '.';
}

say "Part 2: ", $loops;

# DONE:
# for 0..^$nrows -> $block-y {
#     for 0..^$ncols -> $block-x {
#         next unless @map[$block-y][$block-x] eq '.';
#         # say "Trying ($block-x, $block-y): ", @map[$block-y][$block-x];

#         @map[$block-y][$block-x] = 'O';
#         NEXT {
#             # say "($x + $dx, $y + $dy)";
#             # .say for @map;
#             # say "";
#             # say "CLEARING =====================";
#             # @map[$block-y][$block-x] = '.';
#             for @map -> @row {
#                 for @row -> $elem is rw {
#                     $elem = '.' if $elem eq 'X' | 'O';
#                 }
#             }
#             # say "($x + $dx, $y + $dy)";
#             # .say for @map;
#             # say "";
#         };

#         ($dx, $dy) = (0, -1);
#         ($x, $y) = ($start-x, $start-y);
#         my Int $rot-attempts = 0;
#         my Bool %seen;

#         while True {
#             if %seen{"$x, $y, $dx, $dy"}:exists {
#                 $loops++;
#                 last;
#             }
#             %seen{"$x, $y, $dx, $dy"} = True;
#             @map[$y][$x] = 'X';
#             last unless 0 <= $y+$dy < $nrows and 0 <= $x+$dx < $ncols;
#             given @map[$y+$dy][$x+$dx] {
#                 when 'X' | '.' {
#                     $x += $dx;
#                     $y += $dy;
#                     $rot-attempts = 0;
#                 }
#                 when '#' | 'O' {
#                     # Rotate 90 degrees to the right
#                     ($dx, $dy) = (-$dy, $dx);
#                     $rot-attempts++;
#                     last if $rot-attempts > 3;
#                 }
#                 default {
#                     # say "($x + $dx, $y + $dy)";
#                     last
#                 }
#             }
#         }
#     }
# }
# # say "End:";
# # .say for @map;

# say "Part 1:";
# @map.map( *.grep(/X/).elems ).sum.say;
# say "Part 2: $loops";


