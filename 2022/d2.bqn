#!/usr/bin/env BQN

lines ← •file.Lines "d2.txt"
elf ← 'A'-˜0⊑¨lines
you ← 'X'-˜2⊑¨lines

•Out "Day 2"
•Show +´ (1+you) + 3×3|1+you-elf
•Show +´ (3×you) + 1+3|2+elf+you

