#!/usr/bin/env tclsh
# solution.tcl --
#
###Abstract
# This script implements the solution to the
# Advent of Code day 8 of 2024
#
# Copyright (c) 2024 Skye Soss
#
###Copyright
# This file is available under the MIT License
#

if {$argc != 1} {
    puts stderr "Usage: $argv0 <filename>"
    exit 1
}

# slurpLines --
#
# Returns all the lines in a file
#
# Arguments:
# filename is the file to read from
# Results:
# The result is a list of strings
proc slurpLines {filename} {
    set f [open $filename {RDONLY}]
    set lines {}
    while {[gets $f line] > 0} {
        lappend lines $line
    }
    return $lines
}

# Network --
#
# Represents the input to the problem: a 2-D array of antennae
oo::class create Network {
    variable rows antennae antennaeByLabel numRows numCols

    # Arguments:
    # lines the lines of the input file
    constructor {lines} {
        set rows $lines
        my Init
    }

    method Init {} {
        set numRows [llength $rows]
        set numCols [string length [lindex $rows 0]]
        set antennae {}
        set antennaeByLabel [dict create]
        set j -1
        foreach row $rows {
            incr j
            for {set i 0} {$i < [string length $row]} {incr i} {
                if {[string index $row $i] != "."} {
                    lappend antennae [list $i $j]
                    dict lappend antennaeByLabel [string index $row $i] [list $i $j]
                }
            }
        }
    }

    # foreachAntenna --
    #
    # Executes a script for each antennae, or for each antennae with a given label
    #
    # Arguments:
    # label (optional) the antennae label to limit iteration for
    # varName the name of the iteration variable, set to the coordinate
    # script the script to execute for each antennae
    method foreachAntenna {args} {
        if {[llength $args] == 2} {
            lassign $args varName script
            upvar $varName var
            foreach var $antennae {
                uplevel 1 $script
            }
        } elseif {[llength $args] == 3} {
            lassign $args label varName script
            upvar $varName var
            if {[dict exists $antennaeByLabel $label]} {
                foreach var [dict get $antennaeByLabel $label] {
                    uplevel 1 $script
                }
            }
        }
    }

    # foreachPosition --
    #
    # Executes a script for each position in the input network
    #
    # Arguments:
    # varName the name of the loop variable
    # script the script to execute for each position
    method foreachPosition {varName script} {
        upvar $varName var
        set i 0
        set j 0
        for {set j 0} {$j < $numRows} {incr j} {
            for {set i 0} {$i < $numCols} {incr i} {
                set var [list $i $j]
                uplevel 1 $script
            }
        }
    }

    # at --
    #
    # Gets the antennae at a given position
    #
    # Arguments:
    # x the x coordinate of the position
    # y the y coordinate of the position
    # Results:
    # The antennae label, or "." if there is no antennae, or "" if out-of-bounds
    method at {i j} {
        return [string index [lindex $rows $j] $i]
    }

    # numRows --
    #
    # The limit on the y coordinate in the network
    #
    # Results:
    # The integer representing the number of rows in the network
    method numRows {} {
        return $numRows
    }

    # numCols --
    #
    # The maximum value for the x coordinate in the network
    #
    # Results:
    # The integer representing the number of rows in the network
    method numCols {} {
        return $numCols
    }
}

set lines [slurpLines [lindex $argv 0]]
set network [Network new $lines]
set part1Antinodes [dict create]
set antinodes [dict create]

set numRows [$network numRows]
set numCols [$network numCols]

# updateAntinodes --
#
# Marks all positions in the line created by the positions as antinodes
#
# Arguments:
# dictVar the name of the dictionary value in caller scope to be updated
# x1, y1 are the first antennae coordinates
# x2, y2 are the second antennae coordinates
proc updateAntinodes {dictVar x1 y1 x2 y2} {
    upvar $dictVar antinodes
    set dx [expr {$x2 - $x1}]
    set dy [expr {$y2 - $y1}]

    # Walk forwards + backwards
    set i 0
    while {true} {
        set x [expr {$x1 + $i * $dx}]
        set y [expr {$y1 + $i * $dy}]
        incr i
        # Check both since the sign of dx and dy are unknown
        if {$x < 0 || $y < 0 || $x >= $::numCols || $y >= $::numRows} {
            break
        }
        dict incr antinodes [list $x $y]
    }

    set i -1
    while {true} {
        set x [expr {$x1 + $i * $dx}]
        set y [expr {$y1 + $i * $dy}]
        incr i -1
        if {$x < 0 || $y < 0 || $x >= $::numCols || $y >= $::numRows} {
            break
        }
        dict incr antinodes [list $x $y]
    }
}

$network foreachPosition pos {
    lassign $pos x y
    $network foreachAntenna antenna {
        lassign $antenna z w
        set label [$network at $z $w]
        $network foreachAntenna $label other {
            lassign $other z1 w1
            if {$z == $z1 && $w == $w1} {
                continue
            }
            set z2 [expr {2 * $z1 - $z}]
            set w2 [expr {2 * $w1 - $w}]
            if {[$network at $z2 $w2] ne {}} {
                dict incr part1Antinodes [list $z2 $w2]
            }
            updateAntinodes antinodes $z $w $z1 $w1
        }
    }
}

$network destroy

puts "Day 8"
puts "Part 1: [dict size $part1Antinodes]"
puts "Part 2: [dict size $antinodes]"
