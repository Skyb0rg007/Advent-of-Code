#!/usr/bin/env BQN

FirstUniqueN ← { ⊑ 𝕨+ ⊐⟜1 𝕨= +´∘∊˘ 𝕨↕ 𝕩 }

chars ← •file.Chars "d6.txt"
•Show 4 FirstUniqueN chars
•Show 14 FirstUniqueN chars

# Tests
! 7 = 4 FirstUniqueN "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
! 5 = 4 FirstUniqueN "bvwbjplbgvbhsrlpgdmjqwftvncz"
! 6 = 4 FirstUniqueN "nppdvjthqldpwncqszvftbrmjlhg"
! 10 = 4 FirstUniqueN "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
! 11 = 4 FirstUniqueN "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"

! 19 = 14 FirstUniqueN "mjqjpqmgbljsphdztnvjfqwrcgsmlb"
! 23 = 14 FirstUniqueN "bvwbjplbgvbhsrlpgdmjqwftvncz"
! 23 = 14 FirstUniqueN "nppdvjthqldpwncqszvftbrmjlhg"
! 29 = 14 FirstUniqueN "nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg"
! 26 = 14 FirstUniqueN "zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw"
