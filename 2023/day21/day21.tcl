#!/bin/sh
# \
exec tclsh "$0" "$@"

oo::class create Board {
    variable rows tiles

    constructor {} {
        set rows {}
        set tiles {}
    }

    method load {chan} {
        set startPos {}
        while {[gets $chan line] >= 0} {
            set row [split $line ""]
            if {$startPos == {}} {
                set sPos [string first "S" $line]
                if {$sPos >= 0} {
                    set startPos [list [llength $rows] $sPos]
                    lset row $sPos "."
                }
            }
            lappend rows $row
        }
        if {$startPos == {}} {
            return -code error "No starting position found!"
        }
        set tiles [list $startPos]
    }

    method display {{chan stdout}} {
        set rowsCopy $rows
        foreach tile $tiles {
            lassign $tile row col
            lset rowsCopy $row $col "O"
        }
        foreach row $rowsCopy {
            puts $chan [join $row ""]
        }
        puts $chan ""
    }

    method step {} {
        set newTiles {}
        foreach tile $tiles {
            lassign $tile row col
            if {[lindex [lindex $rows $row] $col+1] == "."} {
                lappend newTiles [list $row [expr {$col + 1}]]
            }
            if {[lindex [lindex $rows $row] $col-1] == "."} {
                lappend newTiles [list $row [expr {$col - 1}]]
            }
            if {[lindex [lindex $rows $row+1] $col] == "."} {
                lappend newTiles [list [expr {$row + 1}] $col]
            }
            if {[lindex [lindex $rows $row-1] $col] == "."} {
                lappend newTiles [list [expr {$row - 1}] $col]
            }
        }
        set tiles [lsort -unique $newTiles]
    }

    method steps {n} {
        for {set i 0} {$i < $n} {incr i} {
            my step
        }
    }

    method numTiles {} {
        llength $tiles
    }

    method boardSize {} {
        llength $rows
    }
}


if {$argc < 1} {
    puts stderr "Usage: $argv0 <filename>"
    exit 1
}

# The board
set board [Board new]

set f [open [lindex $argv 0] "r"]
$board load $f
close $f

set n [$board boardSize]
$board steps 64

set t1 [$board numTiles]
$board steps $n
set t2 [$board numTiles]
$board steps $n
set t3 [$board numTiles]

puts "Part 1: $t1"
puts "$t1,$t2,$t3"
puts "[expr {$t2 - $t1}], [expr {$t3 - $t2}]"
puts "[expr {($t3 - $t2) - ($t2 - $t1)}]"

# lassign [loadBoard [lindex $argv 0]] board start

# puts "start: $start"

# set numRows [llength $board]
# set numCols [llength [lindex $board 0]]
# puts "$numRows, $numCols"

# set tiles [list $start]
# showBoard $board $tiles
# set tiles [step $board $tiles]
# showBoard $board $tiles
# set tiles [step $board $tiles]
# showBoard $board $tiles
