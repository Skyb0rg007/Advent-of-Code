#!/usr/bin/sh

# Day 7: bc
# Because bc doesn't have IO, I use POSIX sh to setup the inputs

if [ $# -ne 1 ]; then
    echo >&2 "Usage: $0 <filename>"
    exit 1
fi

part1=0
part2=0

while read -r result values; do
    i=0
    init=""
    for value in $values; do
        init="$init values[$i] = $value;"
        : $((i += 1))
    done
    n="$(bc <<EOF

result = ${result%:}
$init
nvalues = $i

define evaluate () {
    auto i, r
    r = values[0]
    for (i = 1; i < nvalues; i++) {
        if ( i <= dirty && cache[i] != r ) {
            print "ERROR\n"
            halt
        }
        cache[i] = r
        if (b[i - 1] == 0) {
            r += values[i]
        } else if (b[i - 1] == 1) {
            r *= values[i]
        } else {
            r = r * 10 ^ length(values[i]) + values[i]
        }
    }
    return( r )
}

for (num_ops = 2; num_ops < 4; num_ops++) {
    while (1) {
        if (evaluate() == result) {
            part[num_ops - 1] = result
            break
        }

        for (i = nvalues - 1; i >= 0; i--) {
            if (b[i] == (num_ops - 1)) {
                b[i] = 0
            } else {
                b[i] += 1
                break
            }
        }
        dirty = i + 1
        if (i == -1 && b[0] == 0) {
            break
        }
    }
}

# print ok, "\n"
print part[1], " ", part[2], "\n"
EOF
)"
    p1="${n%% *}"
    p2="${n##* }"
    : $((part1 += p1))
    : $((part2 += p2))
done < "$1"

echo "Day 7"
echo "Part 1: $part1"
echo "Part 2: $part2"
