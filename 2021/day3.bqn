
# lines ← •file.Lines "day3.txt"
lines ← "00100"‿"11110"‿"10110"‿"10111"‿"10101"‿"01111"‿"00111"‿"11100"‿"10000"‿"11001"‿"00010"‿"01010"
lines ↩ >'0'-˜lines

MCB ← +˝≥(2÷˜≠)
B2D ← +⟜(2⊸×)´∘⌽

•Out "Day 3"
•Show (¬∘MCB ×○B2D MCB) lines
! 198 = (¬∘MCB ×○B2D MCB) lines

# Part 2 TODO

