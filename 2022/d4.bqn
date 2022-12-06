#!/usr/bin/env BQN

lines ← •file.Lines "d4.txt"

SplitAt ← (¬-˜⊢×·+`»⊸>)∘≠⊔⊢
ToNumber ← +⟜(10⊸×)´∘⌽-⟜'0'

ParseLine ← ToNumber¨¨ ('-'⊸SplitAt¨ ','⊸SplitAt)
lines ↩ > ParseLine¨ lines

ToRange ← ⊣+(↕∘¬)˜
Subset ← ∧´∘∊
Intersects ← ∨´∘∊

lines ↩ (0⊸⊑ ToRange 1⊸⊑)¨ lines

•Show +´ (Subset´ ∨ Subset˜´)˘ lines
•Show +´ (Intersects´ ∨ Intersects˜´)˘ lines
