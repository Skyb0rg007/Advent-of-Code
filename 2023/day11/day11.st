| filename |

Object subclass: Day11 [
    | galaxies |

    age [ self subclassResponsibility ]
    num [ self subclassResponsibility ]

    solve: filename [
        | stream |
        stream := FileStream open: filename mode: FileStream read.
        self loadFrom: stream; displaySolution
    ]

    displaySolution [
        stdout
            display: ('Part %1: %2' bindWith: self num with: self sum);
            nextPut: Character nl
    ]

    loadFrom: aStream [
        | i emptyCols age |
        age := self age.
        i := 1.
        galaxies := OrderedCollection new.
        aStream linesDo: [ :line |
            | emptyRow |
            emptyRow := true.
            emptyCols ifNil: [
                emptyCols := Array new: line size.
                1 to: line size do: [ :i | emptyCols at: i put: true ]
            ].
            line keysAndValuesDo: [ :j :x |
                (x == $#) ifTrue: [
                    emptyRow := false.
                    emptyCols at: j put: false.
                    galaxies add: (Point x: i y: j)
                ]
            ].
            emptyRow
                ifFalse: [ i := i + 1 ]
                ifTrue: [ i := i + age ]
        ].
        galaxies do: [ :pt |
            | delta |
            delta := 0.
            emptyCols keysAndValuesDo: [ :j :mt |
                (mt and: [pt y > j]) ifTrue: [ delta := delta + age - 1 ]
            ].
            pt y: pt y + delta
        ]
    ]

    sum [
        | n sum |
        n := galaxies size.
        sum := 0.
        1 to: n do: [ :i |
            | p1 |
            p1 := galaxies at: i.
            (i + 1) to: n do: [ :j |
                | p2 |
                p2 := galaxies at: j.
                sum := sum + (self distanceFrom: p1 to: p2)
            ]
        ].
        ^sum
    ]

    distanceFrom: pt1 to: pt2 [
        | delta |
        delta := (pt1 - pt2) abs.
        ^delta x + delta y
    ]


].

Day11 subclass: Part1 [
    age [ ^2 ]
    num [ ^1 ]
].

Day11 subclass: Part2 [
    age [ ^1000000 ]
    num [ ^2 ]
].

filename := Smalltalk arguments at: 1.
Part1 new solve: filename.
Part2 new solve: filename.

