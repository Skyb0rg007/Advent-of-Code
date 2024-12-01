comment vim: set ft=algol ts=2 sw=2: ;

procedure printarray(rocks, size);
  value size; integer array rocks; integer size;
begin
  integer i, j;
  for i := 1 step 1 until size do begin
    for j := 1 step 1 until size do begin
      if rocks[i,j] = 1 then
        outstring(1, ".")
      else if rocks[i,j] = 2 then
        outstring(1, "O")
      else
        outstring(1, "#")
    end;
    outstring(1, "\n")
  end;
  outstring(1, "\n")
end;

procedure tiltup(rocks, size);
  value size; integer array rocks; integer size;
begin
  boolean done;
  integer i, j;

  START:
  done := true;

  for i := 2 step 1 until size do begin
    for j := 1 step 1 until size do begin
      if rocks[i, j] = 2 then
        if rocks[i-1, j] = 1 then begin
          rocks[i-1, j] := 2;
          rocks[i, j] := 1;
          done := false
        end
    end
  end;

  if ! done then
    goto START
end;

procedure tiltdown(rocks, size);
  value size; integer array rocks; integer size;
begin
  boolean done;
  integer i, j;

  START:
  done := true;

  for i := size - 1 step -1 until 1 do begin
    for j := 1 step 1 until size do begin
      if rocks[i, j] = 2 then
        if rocks[i+1, j] = 1 then begin
          rocks[i+1, j] := 2;
          rocks[i, j] := 1;
          done := false
        end
    end
  end;

  if ! done then
    go to START
end;

procedure tiltleft(rocks, size);
  integer array rocks; integer size;
begin
  boolean done;
  integer i, j;

  START:
  done := true;

  for j := 2 step 1 until size do begin
    for i := 1 step 1 until size do begin
      if rocks[i, j] = 2 then
        if rocks[i, j-1] = 1 then begin
          rocks[i, j-1] := 2;
          rocks[i, j] := 1;
          done := false
        end
    end
  end;

  if ! done then
    go to START
end;

procedure tiltright(rocks, size);
  integer array rocks; integer size;
begin
  boolean done;
  integer i, j;

  START:
  done := true;

  for j := size - 1 step -1 until 1 do begin
    for i := 1 step 1 until size do begin
      if rocks[i, j] = 2 then
        if rocks[i, j+1] = 1 then begin
          rocks[i, j+1] := 2;
          rocks[i, j] := 1;
          done := false
        end
    end
  end;

  if ! done then
    go to START
end;

integer procedure load(rocks, size);
  value size; integer array rocks; integer size;
begin
  integer i, j, sum;

  sum := 0;
  for i := 1 step 1 until size do begin
    for j := 1 step 1 until size do begin
      if rocks[i, j] = 2 then
        sum := sum + 1 + size - i
    end
  end;
  load := sum
end load;

procedure copyarray(rocks, rocks2, size);
  value size; integer array rocks, rocks2; integer size;
begin
  integer i, j;

  for i := 1 step 1 until size do
    for j := 1 step 1 until size do begin
      rocks2[i, j] := rocks[i, j]
    end
end copyarray;

boolean procedure samearray(rocks, rocks2, size);
  value size; integer array rocks, rocks2; integer size;
begin
  integer i, j;

  for i := 1 step 1 until size do begin
    for j := 1 step 1 until size do begin
      if rocks2[i, j] != rocks[i, j] then begin
        samearray := false;
        goto DONE
      end
    end
  end;
  samearray := true;
  DONE:
end samearray;

begin
  integer array rocks[1:100, 1:100];
  integer array rocks2[1:100, 1:100];
  integer i, j, rock;
  integer starti, endi, remaining, delta;
  integer N;

  N := 100;

  comment Load the rocks array from stdin;
  for i := 1 step 1 until N do begin
    for j := 1 step 1 until N do begin
      inchar(0, ".O#", rock);
      rocks[i, j] := rock
    end;
    inchar(0, "\n", rock)
  end;

  outstring(1, "Input:\n");
  printarray(rocks, N);
  outstring(1, "\n");
  tiltup(rocks, N);
  printarray(rocks, N);

  comment
    For part 1, simply tilt the rocks upwards;
  tiltup(rocks, N);

  outstring(1, "Part 1: ");
  outinteger(1, load(rocks, N));
  outstring(1, "\n");

  comment
    For part 2, we first tilt up, left, down, right a bunch of times.
    Hopefully by this point we've hit a fixpoint;
  for i := 1 step 1 until 10000 do begin
    tiltup(rocks, N);
    tiltleft(rocks, N);
    tiltdown(rocks, N);
    tiltright(rocks, N)
  end;

  i := 1000;
  starti := i;
  copyarray(rocks, rocks2, N);
  begin
    REDO:
    tiltup(rocks, N);
    tiltleft(rocks, N);
    tiltdown(rocks, N);
    tiltright(rocks, N);
    if !samearray(rocks, rocks2, N) then begin
      i := i + 1;
      go to REDO
    end
  end;
  endi := i;

  remaining := 1000000000 - endi;
  delta := endi - starti;
  remaining := remaining - (remaining % delta) * delta;

  outstring(1, "starti = "); outinteger(1, starti); outstring(1, "\n");
  outstring(1, "endi   = "); outinteger(1, endi); outstring(1, "\n");
  outstring(1, "remaining = "); outinteger(1, remaining); outstring(1, "\n");

  for i := 1 step 1 until remaining + 2 do begin
    tiltup(rocks, N);
    tiltleft(rocks, N);
    tiltdown(rocks, N);
    tiltright(rocks, N)
  end;

  outstring(1, "Part 2: ");
  outinteger(1, load(rocks, N));
  outstring(1, "\n");

  outstring(1, "Part 2: ");
  tiltup(rocks, N);
  tiltleft(rocks, N);
  tiltdown(rocks, N);
  tiltright(rocks, N);
  outinteger(1, load(rocks, N));
  outstring(1, "\n");

  outstring(1, "Part 2: ");
  tiltup(rocks, N);
  tiltleft(rocks, N);
  tiltdown(rocks, N);
  tiltright(rocks, N);
  outinteger(1, load(rocks, N));
  outstring(1, "\n");

  outstring(1, "Part 2: ");
  tiltup(rocks, N);
  tiltleft(rocks, N);
  tiltdown(rocks, N);
  tiltright(rocks, N);
  outinteger(1, load(rocks, N));
  outstring(1, "\n");

  outstring(1, "Part 2: ");
  tiltup(rocks, N);
  tiltleft(rocks, N);
  tiltdown(rocks, N);
  tiltright(rocks, N);
  outinteger(1, load(rocks, N));
  outstring(1, "\n");

  outstring(1, "Part 2: ");
  tiltup(rocks, N);
  tiltleft(rocks, N);
  tiltdown(rocks, N);
  tiltright(rocks, N);
  outinteger(1, load(rocks, N));
  outstring(1, "\n");

  comment 111 is too low;
  comment 90580 is too high;
  comment 90574 is too high;
  comment 90567 is too high;
  comment 90563 is not right;
  comment 90566 is not right;
  comment 90560 is not right;

  EXIT:
  ;
end
