\ vim: set ft=forth ts=2 sw=2:

\ A simple string atomizer
700 CONSTANT max-atoms
CREATE atom-table  max-atoms 2* CELLS ALLOT
VARIABLE #atoms  0 #atoms !

\ Allocate a new atom for the given string
: atom ( c-addr u -- n )
  #atoms @ 0 ?DO
    2DUP
    atom-table I 2* CELLS + 2@
    2 PICK OVER = IF
      COMPARE 0= IF
        2DROP I UNLOOP EXIT
      THEN
    THEN
  LOOP
  atom-table #atoms @ 2* CELLS + 2!
  #atoms @ DUP 1+ #atoms !  ;

\ Convert an atom back to its string representation
: atom>string ( n -- c-addr u )
  atom-table SWAP 2* CELLS + 2@ ;

\ Maps an atom name to an execution token
max-atoms CONSTANT max-states
CREATE state-table  max-states CELLS ALLOT

VARIABLE x
VARIABLE m
VARIABLE a
VARIABLE s

: accept-token -1 ;
: reject-token -2 ;

: xt-px ( -- -1 | -2 | state )
  a @ 2006 < IF
    [ s" qkq" atom ] LITERAL EXIT
  THEN
  m @ 2090 > IF
    accept-token EXIT
  THEN
  [ s" rfg" atom ] LITERAL ;

\ 256 CONSTANT bufsize
\ CREATE buf bufsize ALLOT
\ VARIABLE #chars

\ 3 arg R/O OPEN-FILE THROW CONSTANT file
\ 
\ : refill-line ( -- )
\   buf bufsize file READ-LINE THROW DROP #chars ! ;
\ 
\ : run ( -- )
\   refill-line
\   BEGIN #chars @ 0<> WHILE
\     [CHAR] " EMIT buf #chars @ TYPE [CHAR] " EMIT CR
\     refill-line
\   REPEAT
\   ;
\ 
\ run
\ 
\ file CLOSE-FILE THROW
