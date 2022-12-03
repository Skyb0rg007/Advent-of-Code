#!/usr/bin/env BQN

ToNumber ← +⟜(10⊸×)´∘⌽-⟜'0'
lines ← ToNumber¨ •FLines "day1.txt"

•Out "Day 1"
•Show +´ (⊢<«) lines
•Show +´ (⊢<«) +´˘ 3↕ lines
