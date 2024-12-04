#!/usr/bin/env red
; vim: ft=rebol tabstop=4 shiftwidth=4 noexpandtab

Red [
	Title: "Advent of Code 2024 Day 3 Solution"
	Author: "Skye Soss"
	File: %solution.red
	Tabs: 4
	Rights: "Copyright (c) 2024 Skye Soss"
	License: "MIT License"
]

; For whatever reason Red changes directory to the script location
change-dir to-file get-env "PWD"

filename: system/options/args/1

if none? filename [
	cause-error 'script 'no-value ["first command-line argument"]
]

lines: read/lines to-file filename

xmas: 0

; Vertical "XMAS"
foreach line lines [
	i: 1
	loop (length? line) - 3 [
		slice: copy/part at line i 4
		if slice = "XMAS" [ xmas: xmas + 1 ]
		if slice = "SAMX" [ xmas: xmas + 1 ]
		i: i + 1
	]
]

; Horizontal "XMAS"
cols: []
loop (length? lines/1) [
	append/only cols (make block! [])
]
foreach line lines [
	j: 1
	foreach c line [
		append/only (pick cols j) c
		j: j + 1
	]
]

foreach col cols [
	i: 1
	loop (length? col) - 3 [
		slice: rejoin copy/part at col i 4
		if slice = "XMAS" [
			xmas: xmas + 1
		]
		if slice = "SAMX" [
			xmas: xmas + 1
		]
		i: i + 1
	]
]

; Diagonal "XMAS"
rdiag: function [i][
	d: make block! []
	n: length? lines
	foreach line lines [
		append d (pick line i)
		i: i + 1
	]
	return d
]
ldiag: function [i][
	d: make block! []
	n: length? lines
	foreach line lines [
		append d (pick line i)
		i: i - 1
	]
	return d
]

i: 1 - length? lines
loop 1 + 2 * length? lines [
	d1: ldiag i
	d2: rdiag i
	j: 1
	loop (length? d1) - 3 [
		slice1: rejoin copy/part at d1 j 4
		slice2: rejoin copy/part at d2 j 4
		if slice1 = "XMAS" [ xmas: xmas + 1 ]
		if slice1 = "SAMX" [ xmas: xmas + 1 ]
		if slice2 = "XMAS" [ xmas: xmas + 1 ]
		if slice2 = "SAMX" [ xmas: xmas + 1 ]
		j: j + 1
	]
	i: i + 1
]

x-mas: 0

i: 2
loop (length? lines) - 2 [
	j: 2
	loop (length? lines/1) - 2 [
		if (pick (pick lines i) j) = #"A" [
			d1: rejoin [(pick (pick lines (i - 1)) (j - 1)) (pick (pick lines (i + 1)) (j + 1))]
			d2: rejoin [(pick (pick lines (i + 1)) (j - 1)) (pick (pick lines (i - 1)) (j + 1))]
			if ((d1 = "MS") or (d1 = "SM")) and ((d2 = "MS") or (d2 = "SM")) [
				x-mas: x-mas + 1
			]
		]
		j: j + 1
	]
	i: i + 1
]

print "Day 4"
print ["Part 1:" xmas]
print ["Part 2:" x-mas]
