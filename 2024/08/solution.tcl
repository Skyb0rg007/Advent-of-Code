#!/usr/bin/env tclsh

if {![package vsatisfies $tcl_version 8.5-]} {
    puts stderr "Error: TCL 8.5 or above required for bignum support"
    exit 1
}

puts "Hello from TCL $tcl_patchLevel!"

if {$argc != 1} {
    puts stderr "Usage: $argv0 <filename>"
    exit 1
}

set filename [lindex $argv 0]
set f [open $filename {RDONLY}]

while {[gets $f line] > 0} {
    puts "line: '$line'"
}

close $f
