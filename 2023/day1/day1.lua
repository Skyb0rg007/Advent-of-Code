
local digits = {
    'one',
    'two',
    'three',
    'four',
    'five',
    'six',
    'seven',
    'eight',
    'nine',
    'ten'
}

local function firstDigit(part2, str)
    local start, _, value = str:find('(%d)')
    value = tonumber(value)

    if part2 then
        for i, d in ipairs(digits) do
            local s = str:find(d, 1, true)
            if s and s < start then
                start, value = s, i
            end
        end
    end
    return value
end

local function lastDigit(part2, str)
    local _, end_, value = str:find('.*(%d)')
    value = tonumber(value)

    if part2 then
        for i, d in ipairs(digits) do
            local s, e = str:find('.*' .. d)
            if s and e > end_ then
                end_, value = e, i
            end
        end
    end
    return value
end

local filename = assert(arg[1], 'Must provide input file')
local f = io.open(filename)

local sum1 = 0
local sum2 = 0

for line in f:lines() do
    local d1, d2

    d1 = firstDigit(false, line)
    d2 = lastDigit(false, line)
    sum1 = sum1 + tonumber(d1 .. d2)

    d1 = firstDigit(true, line)
    d2 = lastDigit(true, line)
    sum2 = sum2 + tonumber(d1 .. d2)
end

print('Part 1', sum1)
print('Part 2', sum2)
