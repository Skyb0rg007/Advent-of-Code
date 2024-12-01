
local filename = assert(arg[1], 'Missing filename')
local file = assert(io.open(filename, 'r'))

local states = {}

local function run(vars)
    local function go(statename)
        if statename == 'A' then
            return true
        elseif statename == 'R' then
            return false
        end
        local state = states[statename]
        for _, rule in ipairs(state.rules) do
            local lhs, op, rhs = vars[rule.lhs], rule.op, rule.rhs
            if op == '<' and lhs < rhs then
                return go(rule.to)
            elseif op == '>' and lhs > rhs then
                return go(rule.to)
            end
        end
        return go(state.default)
    end

    return go('in')
end

local StateSpace = {}
StateSpace.__index = StateSpace

function StateSpace.new()
    local t = {x={1, 4001}, m={1, 4001}, a={1, 4001}, s={1, 4001}}
    return setmetatable(t, StateSpace)
end

function StateSpace:size()
    if not self._size then
        self._size =
            (self.x[2] - self.x[1])
          * (self.m[2] - self.m[1])
          * (self.a[2] - self.a[1])
          * (self.s[2] - self.s[1])
    end
    return self._size
end

function StateSpace:copy()
    local t = {}
    t.x = {self.x[1], self.x[2]}
    t.m = {self.m[1], self.m[2]}
    t.a = {self.a[1], self.a[2]}
    t.s = {self.s[1], self.s[2]}
    return setmetatable(t, StateSpace)
end

local function simulate()
    local function go(vars, statename)
        if vars:size() == 0 then
            return 0
        elseif statename == 'A' then
            return vars:size()
        elseif statename == 'R' then
            return 0
        end
        local state = states[statename]
        local n = 0
        for _, rule in ipairs(state.rules) do
            local vs = vars:copy()
            local op, rhs = rule.op, rule.rhs
            -- TODO: modify vars to false branch
            if op == '<' then
                vs[rule.lhs][1] = math.min(vs[rule.lhs][1], rhs)
                vs[rule.lhs][2] = math.min(vs[rule.lhs][2], rhs)
                n = n + go(vs, rule.to)
            elseif op == '>' then
                vs[rule.lhs][1] = math.max(vs[rule.lhs][1], rhs)
                vs[rule.lhs][2] = math.max(vs[rule.lhs][2], rhs)
                n = n + go(vs, rule.to)
            end
        end
        return n + go(vars, state.default)
    end
    return go(StateSpace.new(), 'in')
end

for state in file:lines() do
    if state == '' then
        break
    end

    local s = {}

    s.name = state:match('(%w+)')
    s.default = state:match('(%w+)}')
    s.rules = {}

    for x, op, n, to in state:gmatch('([xmas])([<>])(%d+):(%w+),') do
        local rule = {
            lhs = x,
            op = op,
            rhs = assert(tonumber(n)),
            to = to
        }
        s.rules[#s.rules + 1] = rule
    end

    states[s.name] = s
end

local sum = 0
for part in file:lines() do
    local x, m, a, s = part:match('x=(%d+),m=(%d+),a=(%d+),s=(%d+)')
    x=tonumber(x)
    m=tonumber(m)
    a=tonumber(a)
    s=tonumber(s)
    if run({x=x,m=m,a=a,s=s}) then
        sum = sum + x + m + a + s
    end
end

print('sum', sum)
print('sim', simulate())
