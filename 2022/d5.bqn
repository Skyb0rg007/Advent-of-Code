#!/usr/bin/env BQN

SplitMask ← (¬-˜⊢×·+`»⊸>)∘⊣⊔⊢

digits ← '0'+↕10

# "move %d from %d to %d" -> ⟨%d,%d,%d⟩
ParseCommand ← ∊⟜digits SplitMask ⊢

lines ← •file.Lines "d5-small.txt"
init‿cmds ← (0=⟨⟩⊸≡¨lines) SplitMask lines
•Show init
•Show cmds

# height ← 3
# stacks ← 3
# init ← height↑lines
# •Show init

# commands ← (height+2)↓lines
# •Show { ((𝕩<'0') ∨ (𝕩>'9')) SplitAt 𝕩 }¨ commands

