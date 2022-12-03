#!/usr/bin/env BQN

ToNumber ← +⟜(10⊸×)´∘⌽-⟜'0'
lines ← •file.Lines "d3.txt"

•Show 5↑lines

