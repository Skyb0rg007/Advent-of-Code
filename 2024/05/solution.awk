#!/usr/bin/awk -f

# Day 5 using POSIX awk

BEGIN {
    if (ARGC < 2) {
        printf "Usage: %s <filename>", ARGV[0]
        exit 1
    }

    FS = "[|,]"
    part1 = part2 = 0
}

/[0-9]+\|[0-9]+/ {
    # Maps each page to the pages that must come after it
    after[$2] = after[$2] "," $1
}

/[0-9]+,([0-9]+)*/ {
    skip = done = 0
    while (!done) {
        done = 1
        # avoid[$i] holds the index of the page that conflicts with $i
        for (i in avoid)
            delete avoid[i]

        for (i = 1; i <= NF; i++) {
            if ($i in avoid) {
                skip = 1
                done = 0
                j = avoid[$i]
                # Swap the page with its conflicting counterpart
                tmp = $i
                $i = $j
                $j = tmp
            }
            if ($i in after) {
                split(after[$i], after_constraints, ",")
                for (j in after_constraints)
                    avoid[after_constraints[j]] = i
            }
        }
    }
    if (!skip) {
        part1 += $((NF + 1) / 2)
    } else {
        part2 += $((NF + 1) / 2)
    }
}

END {
    print "Day 5"
    printf "Part 1: %d\n", part1
    printf "Part 2: %d\n", part2
}
