#!/usr/bin/env lua

local inspect = require('inspect')
local filename = assert(arg[1])

local lhs, rhs = {}, {}
local n = 0

for line in io.lines(filename) do
    local a, b = assert(line:match('(%d+)%s+(%d+)'))
    n = n + 1
    lhs[n] = assert(tonumber(a))
    rhs[n] = assert(tonumber(b))
end

print('Day 1')

-- Part 1: Distance
if true then
    local lhsTagged, rhsTagged = {}, {}
    for i = 1, n do lhsTagged[i] = { idx = i, value = lhs[i] } end
    for i = 1, n do rhsTagged[i] = { idx = i, value = rhs[i] } end

    local function comp(a, b)
        return a.value < b.value
    end

    table.sort(lhsTagged, comp)
    table.sort(rhsTagged, comp)

    local tot = 0

    for i = 1, n do
        tot = tot + math.abs(lhsTagged[i].value - rhsTagged[i].value)
    end

    print('Part 1:', tot)
end

-- Part 2: Similarity
if true then
    local sim = 0

    local rhsFreq = {}
    for _, x in ipairs(rhs) do
        rhsFreq[x] = (rhsFreq[x] or 0) + 1
    end

    for _, x in ipairs(lhs) do
        sim = sim + x * (rhsFreq[x] or 0)
    end

    print('Part 2:', sim)
end
