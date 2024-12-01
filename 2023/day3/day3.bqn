
lines ← ⟨ "467..114.."
          "...*......"
          "..35..633."
          "......#..."
          "617*......"
          ".....+.58."
          "..592....."
          "......755."
          "...$.*...."
          ".664.598.." ⟩
# lines ↩ •file.Lines ⊑ •args

arr ← ∾˘lines

digits ← '0'+↕10
symMask ← 1-arr∊'.'∾digits
numMask ← arr∊digits
# Expand the symbol mask to include the spots on each side and diagonally
symMask ↩ symMask⌈(»˘symMask)⌈(«˘symMask)
symMask ↩ symMask⌈(»symMask)⌈(«symMask)

# Calculate a "group-mask" from a bitmask
# That maps non-digits to ¯1, and each group of digits to an increasing index
GroupMask ← ¬-˜⊢×·+`»⊸>
# groupMask AdjacentIndices symMask
AdjacentIndices ← {1↓⍷¯1»1-˜(1+𝕨)×𝕩}
# Parse an integer
ParseNum ← 10⊸×⊸+˜´∘⌽-⟜'0'

# Convert back to list-of-lists
symMask ↩ <˘symMask
gm      ← <˘GroupMask˘ numMask
nums    ← ParseNum⚇¯2 gm⊔¨<˘arr

# •Out "Part 1: "
# •Show +´∾(gm AdjacentIndices¨ symMask)⊏¨nums

gearMask ← arr∊"*"

# Array with each number's value in the spot of each of the digits
nums ↩ ∾˘gm{𝕨⊏𝕩∾0}¨nums
# •Show arr
# •Show nums
downRight ← (1-numMask)×(»»˘nums)
upRight ← (1-numMask)×(«»˘nums)
downLeft ← (1-numMask)×(»«˘nums)
upLeft ← (1-numMask)×(««˘nums)
up ← (1-numMask)×(«nums)
down ← (1-numMask)×(»nums)
left ← (1-numMask)×(«˘nums)
right ← (1-numMask)×(»˘nums)
comb ← (downRight×upRight) ⌈ (downRight×downLeft) ⌈ (downRight×upLeft) ⌈ (upRight×downLeft) ⌈ (upRight×upLeft) ⌈ (downLeft × upLeft)


# •Out "Part 2:"
# •Show nums
# •Show comb
# •Show gears ← comb×gearMask
# •Show +´⥊gears

# •Show nm1 ← ((1-numMask)×(«˘nums))×((1-numMask)×(»˘nums))
# •Show nm2 ← ((1-numMask)×(«nums))×((1-numMask)×(»nums))
# •Show gearMask
# •Show nm2×gearMask
# •Show («˘nm1)

# Expand the digit mask to include spots on each side, adding
# nmL ← (1-numMask)×«˘numMask
# nmR ← (1-numMask)×»˘numMask
# numMask ↩ numMask⌈nmL+nmR
# numMask ↩ numMask+(»numMask)+(«numMask)
# activeGearMask ← gearMask × 2=numMask

# •Out "Part 2: "
# •Show numMask
# •Show activeGearMask
