#!/usr/bin/env io

# Note: This implementation is unfinished as Io doesn't support 64-bit integers

filename := System args at(1)
filename ifNil(
    "Usage: " print
    System args at(0) print
    " <filename>" println
    System exit(1)
)
file := File clone openForReading(filename)
lines := file readLines
file close

List addWithCarry := method(
    i := self size - 1
    while(i >= 0 and self at(i) == 1,
        self atPut(i, 0)
        i := i - 1
    )
    (i >= 0) ifTrue(
        self atPut(i, 1)
        return(true)
    ) ifFalse(
        return(false)
    )
)

Int64 := Object clone do(
    low  ::= nil
    high ::= nil

    add := method(other,
        rh := high + other high
        (low > (other low - Number integerMax)) ifTrue(
            rl := low - Number integerMax + other low
            rh = rh + 1
        ) ifFalse(
            rl := low + other low
        )
        Int64 clone setLow(rl) setHigh(rh)
    )

    mul := method(other,
        r := Int64 setInteger(low) add(Int64 setInteger(other low))
    )

    setInteger := method(n,
        self clone setLow(n) setHigh(0)
    )
)

x := Int64 clone setLow(Number integerMax) setHigh(0)
"x = " print; x println
"x+x = " print; x add(x) println

Bignat := Object clone do(
    atoms ::= nil

    add := method(other,
        a := self atoms clone
        b := other atoms clone
        # "b = " print; b println
        # "a = " print; a println
        while (a size < b size, a append(0))
        while (b size < a size, b append(0))
        r := List clone append(0, 0)
        carry := 0
        for(i, 0, a size - 1,
            # "i = " print; i println
            sum := (a at(i)) + (b at(i)) + carry
            carry = sum >> 12
            r append(sum & 0x0FFF)
        )
        (carry > 0) ifTrue(
            r atPut(a size, carry)
        )
        Bignat clone setAtoms(r) normalize
    )

    mul := method(other,
        a := self atoms clone
        b := other atoms clone
        r := List clone
        for(j, 0, a size + b size - 1, r append(0))
        for(j, 0, b size - 1,
            carry := 0
            for(i, 0, a size - 1,
                t0 := a at(i)
                t1 := b at(j)
                t2 := r at(i + j)
                mul := t0 * t1 + t2 + carry
                carry = mul >> 12
                r atPut(i + j, mul & 0x0FFF)
            )
        )
        (carry > 0) ifTrue(
            r atPut(i + j, carry)
        )
        Bignat clone setAtoms(r) normalize
    )

    normalize := method(
        while(atoms first == 0,
            atoms removeFirst
        )
        self
    )

    asString := method(
        normalize atoms asString
    )
)

n := Bignat clone setAtoms(list(234))
m := Bignat clone setAtoms(list(999))
n asString println
m asString println
# (n add(m)) asString println
(n mul(m)) asString println

return(0)

Equation := Object clone do(
    result ::= nil
    values ::= nil

    minResult := method(
        values sum
    )
    maxResult := method(
        values reduce(*)
    )

    evaluate := method(b,
        r := nil
        values foreach(i, v,
            (i == 0) ifTrue(
                r = v
                continue
            )
            b at(i - 1) ifNil(
                "b = " print; b println
                "eqn = " print; self println
            )
            (b at(i - 1) == 0) ifTrue(
                r1 := r
                r = r + v
                (r1 > r) ifTrue(
                    "overflow!" println
                )
            ) ifFalse(
                r1 := r
                r = r * v
                (r1 > r) ifTrue("overflow*!" println)
            )
        )
        r
    )

    satisfiable := method(
        # min := minResult
        # if (min == result) ifTrue(
        #     return(true)
        # )
        # (result < min) ifTrue(
        #     return(false)
        # )

        # max := maxResult
        # (result > max) ifTrue(
        #     return(false)
        # )
        # if (max == result) ifTrue(
        #     return(true)
        # )

        b := List clone
        for(i, 0, values size - 1, b append(0))

        loop(
            r := evaluate(b)
            (r == result) ifTrue(
                return(true)
            )
            b addWithCarry ifFalse(
                return(false)
            )
        )
    )
)

part1 := 0
lines foreach(i, line,
    nums := line split(" ")
    result := nums removeFirst rstrip(":") asNumber
    nums mapInPlace(n, n asNumber)

    # line println
    eqn := Equation clone setResult(result) setValues(nums)

    eqn satisfiable ifTrue(
        part1 = part1 + 1
    )
)

"Day 7" println
("Part 1: " .. part1 asString) println
