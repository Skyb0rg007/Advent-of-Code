#!/bin/sh

infile="$1"
# infile="${0%/*}/test-input.txt"

points=0
while read -r line; do
    score=0
    IFS=':|' read -r _ winners nums <<EOF
$line
EOF
    for num in $nums; do
        for w in $winners; do
            if [ "$num" -eq "$w" ]; then
                if [ "$score" -eq 0 ]; then
                    score=1
                else
                    : $((score *= 2))
                fi
                continue 2
            fi
        done
    done
    : $((points += score))
done < "$infile"

echo "Part 1: $points"

multipliers=""

multiplier () {
    sum=1
    for mult in $multipliers; do
        life="${mult%-*}"
        num="${mult#*-}"
        if [ "$life" -gt 0 ]; then
            : $((sum += num))
        fi
    done
    echo $sum
}

add_match () {
    multipliers="$2-$1 $multipliers"
}

tick () {
    ms="$multipliers"
    multipliers=""
    for m in $ms; do
        life="${m%-*}"
        num="${m#*-}"
        : $((life -= 1))
        if [ "$life" -gt 0 ]; then
            multipliers="$life-$num $multipliers"
        fi
    done
}

points=0
while read -r line; do
    score=0
    IFS=':|' read -r _ winners nums <<EOF
$line
EOF
    for num in $nums; do
        for w in $winners; do
            if [ "$num" -eq "$w" ]; then
                : $((score += 1))
                continue 2
            fi
        done
    done
    mult="$(multiplier)"
    : $((points += mult))
    tick
    add_match "$mult" "$score"
done < "$infile"

echo "Part 2: $points"
