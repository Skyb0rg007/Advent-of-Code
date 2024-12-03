#!/usr/bin/env red
; vim: set ft=rebol tabstop=4 shiftwidth=4 noexpandtab:

Red [
	Title: "Advent of Code 2024 Day 3 Solution"
	Author: "Skye Soss"
	File: %solution.red
	Tabs: 4
	Rights: "Copyright (c) 2024 Skye Soss"
	License: "MIT License"
]

print "Hello from Red!"
print system/options/path
print pwd
filename: system/options/args/1

if none? filename [
	cause-error 'script 'no-value ["first command-line argument"]
]

print to-file filename
lines: read/lines to-file filename
foreach line lines [
	print ["line: " line]
]
