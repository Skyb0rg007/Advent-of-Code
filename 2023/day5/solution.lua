#! /usr/bin/env nix-shell
--[[
#! nix-shell -i lua --packages lua54Packages.lua lua54Packages.inspect
--]]

local inspect = require('inspect')


local file = 'example.txt'
-- file = 'input.txt'

local current_from, current_to
local current_map = {}
local maps = {}
local seeds = {}

for line in io.lines(file) do
    if line:match('^seeds: ') then
        for seed in line:gmatch('%d+') do
            table.insert(seeds, assert(tonumber(seed)))
        end
    elseif line == '' then
        if current_from then
            maps[current_from] = {
                from = current_from,
                to = current_to,
                ranges = current_map
            }
        end
        current_from = nil
        current_to = nil
        current_map = nil
    elseif current_from then
        local dst_start, src_start, len = assert(line:match('(%d+) (%d+) (%d+)'))
        dst_start = assert(tonumber(dst_start))
        src_start = assert(tonumber(src_start))
        len = assert(tonumber(len))
        table.insert(current_map, {
            dst = dst_start,
            src = src_start,
            len = len
        })
    else
        local from, to = assert(line:match('(%w+)%-to%-(%w+) map:'))
        current_from = from
        current_to = to
        current_map = {}
    end
end
if current_from then
    maps[current_from] = {
        from = current_from,
        to = current_to,
        ranges = current_map
    }
end

print(inspect(seeds))
print(inspect(maps))

local function lookup(ranges, n)
    for i, range in ipairs(ranges) do
        if range.src <= n and n < range.src + range.len then
            local offset = n - range.src
            if offset + 1 == range.len then
                range.len = offset
            elseif offset == 0 then
                range.src = range.src + 1
                range.dst = range.dst + 1
                range.len = range.len - 1
            else
                table.insert(ranges, i + 1, {
                    src = range.src + offset + 1,
                    dst = range.dst + offset + 1,
                    len = range.len - offset - 1
                })
                range.len = offset
            end
            return range.dst + offset
        end
    end
    return n
end

local locs = {}
for _, seed in ipairs(seeds) do
    local kind = "seed"
    local value = seed
    while kind ~= "location" do
        -- print('value', value, 'kind', kind)
        local map = maps[kind]
        value = lookup(map.ranges, value)
        kind = map.to
    end
    table.insert(locs, value)
end

print('min loc:', math.min(table.unpack(locs)))
