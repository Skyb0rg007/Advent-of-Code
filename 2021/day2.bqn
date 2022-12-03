
lines ← •FLines "day2.txt"

nums ← '0'-˜¨⊑¨⊢˝¨lines
fw ← nums×⟨"forward"⟩⍷7↑¨lines
up ← nums×⟨"up"⟩⍷2↑¨lines
dn ← nums×⟨"down"⟩⍷4↑¨lines
aim ← +` dn-up

•Out "Day 2"
•Show (+´fw)×+´dn-up
•Show (+´fw)×+´aim×fw


