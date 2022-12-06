#!/usr/bin/env BQN

lines ← •FLines "d3.txt"
•Out "Day 3"

# Part 1
Priority ← 1+'Z'⊸<◶⟨-⟜('A'-26), -⟜'a'⟩
SplitLine ← ⊢(↓˜⋈↑˜)(2÷˜≠)
Match ← ⊑(∊/⊣)´
•Show +´ Priority∘Match∘SplitLine¨ lines

# Part 2
Group3 ← (3⌊∘÷˜(↕∘≠))⊔⊢

•Show +´ Priority∘Match¨ Group3 lines

