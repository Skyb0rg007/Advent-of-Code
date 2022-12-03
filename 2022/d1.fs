
20 CONSTANT max-line
CREATE leaderboard  3 CELLS ALLOT  leaderboard 3 CELLS 0 FILL
CREATE line-buffer  max-line CHARS ALLOT
0 VALUE file

: init-file ( c-addr u -- ) R/O OPEN-FILE THROW TO file ;
: free-file ( -- ) file CLOSE-FILE THROW  0 TO file ;

: step ( -- u f ) line-buffer max-line 2 - file READ-LINE THROW ;

: update-leaderboard ( u -- )
    DUP leaderboard @ > IF
        leaderboard leaderboard CELL+ 2 CELLS MOVE
        leaderboard !
    ELSE
        DUP leaderboard CELL+ @ > IF
            leaderboard CELL+ @ leaderboard 2 CELLS + !
            leaderboard CELL+ !
        ELSE
            DUP leaderboard 2 CELLS + @ > IF
                leaderboard 2 CELLS + !
            ELSE
                DROP
            THEN
        THEN
    THEN ;

: process ( -- )
    0 BEGIN
        step
    WHILE
        ?DUP IF
            line-buffer SWAP 0. 2SWAP >NUMBER 2DROP D>S +
        ELSE
            update-leaderboard  0
        THEN
    REPEAT 2DROP ;

: part1 ( -- )
    ." Max: " leaderboard @ . CR ;

: part2 ( -- )
    ." Sum: "
    leaderboard @  leaderboard CELL+ @  leaderboard 2 CELLS + @  + + .
    CR ;

: run ( c-addr u -- )
    init-file
    process
    part1
    part2
    free-file ;

S" d1.txt" run
