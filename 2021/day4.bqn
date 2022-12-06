
lines ← •file.Lines "day4.txt"

ToNumber ← +⟜(10⊸×)´∘⌽-⟜'0'
SplitAt ← (⊢-˜+`×¬)∘=⊔⊢
SplitEvery ← (⌊∘÷˜⟜(↕≠))⊔⊢ 

ParseDraws ← ToNumber¨ ',' SplitAt ⊑
boards ← ToNumber¨ ' ' SplitAt 6/⊸⊔ 1↓ lines

draws ← ToNumber¨ ',' SplitAt ⊑lines
# boards ← 6 SplitEvery 1↓lines

•Show ParseDraws lines
•Show 1⊑boards
