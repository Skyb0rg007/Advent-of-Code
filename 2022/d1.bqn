#!/usr/bin/env BQN

ToNumber ← +⟜(10⊸×)´∘⌽-⟜'0'
Seps ← 0⊸=≠¨
PartitionIndices ← ⊢-˜+`×¬

lines ← •file.Lines "d1.txt"
calories ← ∨ +´¨ ToNumber¨¨ (PartitionIndices∘Seps ⊔ ⊢) lines

•Out "Day 1"
•Show ⊑calories
•Show +´3↑calories

