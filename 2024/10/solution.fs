#! /usr/bin/env -S gforth
\ vim ft=forth

." Day 10" CR

4 VALUE line-length
4096 CHARS CONSTANT buf-capacity
0 VALUE buf-size
buf-capacity BUFFER: buf-content

: strchr ( c-addr u x -- -1 | idx )
    SWAP 0 ?DO \ c-addr x
        ." I = " I . CR
        2DUP SWAP I + C@ = IF
            2DROP I UNLOOP EXIT
        THEN
    LOOP
    2DROP -1 ;

: init ( c-addr u -- )
    R/O OPEN-FILE ABORT" OPEN-FILE failed" >R
    buf-content buf-capacity R@ READ-FILE ABORT" READ-FILE failed" TO buf-size
    R> CLOSE-FILE ABORT" CLOSE-FILE failed"
    buf-content buf-size 10 strchr TO line-length ;

: height ( x y -- u )
    line-length 1+ * + buf-content + C@ [CHAR] 0 - ;

S" test.txt" init
\ 52 TO line-length S" input.txt" init

: pr-buf ( -- )
    ." buf-size = " buf-size . CR
    ." buf-capacity = " buf-capacity . CR
    ." line-length = " line-length . CR
    ." buf-content = " CR
    buf-content buf-size TYPE CR ;

\ pr-buf

BEGIN-STRUCTURE coord
    FIELD: coord.x
    FIELD: coord.y
END-STRUCTURE

0 VALUE cur-height
10 CONSTANT num-heights
128 CONSTANT num-coords
num-coords coord * CONSTANT height-workspace-size
height-workspace-size num-heights * BUFFER: workspace
num-heights CELLS BUFFER: workspace-sizes
workspace-sizes num-heights CELLS 0 FILL

: current-workspace ( -- a-addr )
    workspace height-workspace-size cur-height * + ;
: previous-workspace ( -- a-addr )
    workspace height-workspace-size cur-height 1- * + ;
: current-size ( -- u )
    workspace-sizes cur-height CELLS + @ ;

." workspace size: " height-workspace-size num-heights * . CR
." workspace: " workspace . CR

: mark-reachable ( x y -- )
    current-workspace current-size coord * +
    .s 2DROP DROP
    current-size 1+ workspace-sizes cur-height CELL + ! ;

: score ( x y -- )
    ;

." Height at 1, 2: " 1 2 height . CR

1 2 mark-reachable

BYE
