#!/usr/bin/bash

# readarray elves < d1.txt

# echo "${#elves[@]}"

# exit

declare -a elves
declare -i cur=0

while read -r; do
    if [[ -z $REPLY ]]; then
        elves[${#elves[@]}]=$cur
        cur=0
    else
        cur+=$REPLY
    fi
done

declare -i max1=0
for elf in "${elves[@]}"; do
    if [[ $max1 -lt $elf ]]; then
        max1=$elf
    fi
done

echo "max1 = $max1"

declare -i max2=0
for elf in "${elves[@]}"; do
    if [[ $elf -ne $max1 && $max2 -lt $elf ]]; then
        max2=$elf
    fi
done

echo "max2 = $max2"

declare -i max3=0
for elf in "${elves[@]}"; do
    if [[ $elf -ne $max1 && $elf -ne $max2 && $max3 -lt $elf ]]; then
        max3=$elf
    fi
done

echo "max3 = $max3"

echo $((max1 + max2 + max3))
