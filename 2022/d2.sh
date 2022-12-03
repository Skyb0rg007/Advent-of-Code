#!/usr/bin/bash

declare -a you opp
declare -i round=0
while read -r a b; do
    opp[$round]=$a
    you[$round]=$b
    ((round++))
done < d2.txt

score_play () {
    case "$1" in
        X) echo 1 ;;
        Y) echo 2 ;;
        Z) echo 3 ;;
        *) echo "ERROR"; exit 1 ;;
    esac
}

score_battle () {
    case "$1,$2" in
        A,X) echo 3 ;;
        B,Y) echo 3 ;;
        C,Z) echo 3 ;;
        A,Y) echo 6 ;;
        B,Z) echo 6 ;;
        C,X) echo 6 ;;
        A,Z) echo 0 ;;
        B,X) echo 0 ;;
        C,Y) echo 0 ;;
        *) echo "ERROR"; exit 1 ;;
    esac
}

declare score=0
for ((i = 0; i < round; i++)); do
    case "${you[$i]}" in
        X) ((score += 0)) ;;
        Y) ((score += 3)) ;;
        Z) ((score += 6)) ;;
        *) echo "ERROR"; exit 1 ;;
    esac

    case "${opp[$i]},${you[$i]}" in
        # A,X) ((score += 3)) ;;
        # B,Y) ((score += 3)) ;;
        # C,Z) ((score += 3)) ;;
        # A,Y) ((score += 6)) ;;
        # B,Z) ((score += 6)) ;;
        # C,X) ((score += 6)) ;;
        # A,Z) ((score += 0)) ;;
        # B,X) ((score += 0)) ;;
        # C,Y) ((score += 0)) ;;

        A,X) ((score += 3)) ;;
        A,Y) ((score += 1)) ;;
        A,Z) ((score += 2)) ;;

        B,X) ((score += 1)) ;;
        B,Y) ((score += 2)) ;;
        B,Z) ((score += 3)) ;;

        C,X) ((score += 2)) ;;
        C,Y) ((score += 3)) ;;
        C,Z) ((score += 1)) ;;

        *) echo "ERROR"; exit 1 ;;
    esac
    # ((score = score + "$(score_play "${you[$i]}")"))
    # ((score = score + "$(score_battle "${you[$i]}" "${opp[$i]}")"))
done

echo "round = $round"
echo "score = $score"

