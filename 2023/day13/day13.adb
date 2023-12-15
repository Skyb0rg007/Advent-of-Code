with Ada.Command_Line, Ada.Strings.Bounded, Ada.Text_IO;

procedure Day13 is
    package IO renames Ada.Text_IO;
    package CL renames Ada.Command_Line;
    package BS is new Ada.Strings.Bounded.Generic_Bounded_Length(Max => 20);

    type Pattern is (Ash, Rock);

    MaxSize : constant Natural := 256;

    Terrain : array (1 .. MaxSize, 1 .. MaxSize) of Pattern;
    NumRows, NumCols : Natural;

    F : IO.File_Type;
    Line : BS.Bounded_String;
    I : Natural;
    Part1, Part2 : Natural;

    function Is_Vert_Reflection_Point(Left, Right, Lim : Natural) return Boolean is
        L, R, N : Natural;
    begin
        L := Left; R := Right; N := Lim;
        while 0 < L and R <= NumRows loop
            for Idx in 1 .. NumCols loop
                if Terrain(L, Idx) /= Terrain(R, Idx) then
                    N := N - 1;
                    if N <= 0 then
                        return false;
                    end if;
                end if;
            end loop;
            L := L - 1;
            R := R + 1;
        end loop;
        return N = 1;
    end Is_Vert_Reflection_Point;

    function Is_Horiz_Reflection_Point(Left, Right, Lim : Natural) return Boolean is
        L, R, N : Natural;
    begin
        L := Left; R := Right; N := Lim;
        while 0 < L and R <= NumCols loop
            for Idx in 1 .. NumRows loop
                if Terrain(Idx, L) /= Terrain(Idx, R) then
                    N := N - 1;
                    if N <= 0 then
                        return false;
                    end if;
                end if;
            end loop;
            L := L - 1;
            R := R + 1;
        end loop;
        return N = 1;
    end Is_Horiz_Reflection_Point;

    function Reflection_Point(Lim : Natural) return Natural is
    begin
        for Col in 1 .. NumCols - 1 loop
            if Is_Horiz_Reflection_Point(Col, Col + 1, Lim) then
                return Col;
            end if;
        end loop;
        for Row in 1 .. NumRows - 1 loop
            if Is_Vert_Reflection_Point(Row, Row + 1, Lim) then
                return 100 * Row;
            end if;
        end loop;
        return 0;
    end Reflection_Point;
begin
    if CL.Argument_Count /= 1 then
        IO.Put_Line ("Usage: ./day13 <filename>");
        return;
    end if;

    IO.Open(F, IO.In_File, CL.Argument(1));
    I := 1;
    Part1 := 0; Part2 := 0;
    while not IO.End_Of_File(F) loop
        Line := BS.To_Bounded_String(IO.Get_Line(F));
        if BS.Length(Line) = 0 then
            NumRows := I - 1;
            Part1 := Part1 + Reflection_Point(1);
            Part2 := Part2 + Reflection_Point(2);
            I := 1;
        else
            NumCols := BS.Length(Line);
            for J in 1 .. BS.Length(Line) loop
                if BS.Element(Line, J) = '#' then
                    Terrain(I, J) := Ash;
                else
                    Terrain(I, J) := Rock;
                end if;
            end loop;
            I := I + 1;
        end if;
    end loop;

    NumRows := I - 1;
    Part1 := Part1 + Reflection_Point(1);
    Part2 := Part2 + Reflection_Point(2);

    IO.Put_Line ("Part 1:" & Integer'Image(Part1));
    IO.Put_Line ("Part 2:" & Integer'Image(Part2));
    IO.Close(F);
end Day13;
