#!/usr/bin/env lua

local function solve(part, file)
    assert(part == 1 or part == 2, "part must be 1 or 2")
    local fd = assert(io.open(file))
    local stacks = {}

    for line in fd:lines() do
        local n, from, to = line:match('move (%d+) from (%d+) to (%d+)')
        if n then
            n, from, to = tonumber(n), tonumber(from), tonumber(to)
            local m = #stacks[from]
            for i = 1, n do
                local j = part == 1 and m - i + 1 or m - n + i
                table.insert(stacks[to], stacks[from][j])
                stacks[from][j] = nil
            end
        else
            for idx, char in line:gmatch('()%[([A-Z])%]') do
                local stack = math.tointeger((idx + 3) / 4)
                stacks[stack] = stacks[stack] or {}
                table.insert(stacks[stack], 1, char)
            end
        end
    end

    fd:close()
    for _, stack in ipairs(stacks) do
        io.write(stack[#stack] or '')
    end
    io.write('\n')
end

solve(1, 'd5.txt')
solve(2, 'd5.txt')
