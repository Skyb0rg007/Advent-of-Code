#! /usr/bin/env -S awk -f

BEGIN {
    if (ARGC < 2) {
        printf "Usage: %s <filename>", ARGV[0]
        exit 1
    }
    print "Hello from AWK!", ARGC
}

{
    printf "Line %d: %s\n", NR, $0
}
