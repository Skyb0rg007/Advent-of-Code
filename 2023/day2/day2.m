% vim: set ft=mercury ts=4 sw=4:

:- module day2.

:- interface.
:- import_module io.
:- pred main(io::di, io::uo) is det.

:- implementation.
:- import_module require.
:- import_module parsing_utils.
:- import_module string.
:- import_module list.
:- import_module assoc_list.
:- import_module int.
:- import_module pair.

:- func color_chars = string.
color_chars = "abcdefghijklmnopqrstuvwxyz".

:- pred parse_color : parser(pair(string, int)).
:- mode parse_color(in, out, in, out) is semidet.
parse_color(Src, pair(Color, N)) -->
    int_literal(Src, N),
    identifier(color_chars, color_chars, Src, Color).

:- pred parse_set : parser(assoc_list(string, int)).
:- mode parse_set(in, out, in, out) is semidet.
parse_set(Src, Colors) -->
    separated_list(",", parse_color, Src, Colors).

:- pred parse_line : parser({int, list(assoc_list(string, int))}).
:- mode parse_line(in, out, in, out) is semidet.
parse_line(Src, {Id, Xs}) -->
    punct("Game", Src, _),
    int_literal(Src, Id),
    punct(":", Src, _),
    separated_list(";", parse_set, Src, Xs).

:- pred parse_line(string, int, list(assoc_list(string, int))).
:- mode parse_line(in, out, out) is det.
parse_line(Str, Id, Sets) :-
    new_src_and_ps(Str, Src, PS0),
    ( if parse_line(Src, Res, PS0, _PS1) then
        {Id, Sets} = Res
    else
        error("Unable to parse \"" ++ Str ++ "\"")
    ).

:- pred possible_set(assoc_list(string, int)::in) is semidet.
possible_set(Xs) :-
    Pred = (pred(P::in) is semidet :-
        Color = fst(P),
        N = snd(P),
        (
            Color = "red",
            N =< 12
        ;
            Color = "green",
            N =< 13
        ;
            Color = "blue",
            N =< 14
        )
    ),
    all_true(Pred, Xs).

:- pred possible_game(list(assoc_list(string, int))::in) is semidet.
possible_game(Sets) :-
    all_true(possible_set, Sets).

:- pred power(list(assoc_list(string, int))::in, int::out) is det.
power(Sets, Res) :-
    P = (pred(Set::in, {R0, G0, B0}::in, {R1, G1, B1}::out) is det :-
        ( if assoc_list.search(Set, "red", R) then
            R1 = max(R0, R)
        else
            R1 = R0
        ),
        ( if assoc_list.search(Set, "green", G) then
            G1 = max(G0, G)
        else
            G1 = G0
        ),
        ( if assoc_list.search(Set, "blue", B) then
            B1 = max(B0, B)
        else
            B1 = B0
        )
    ),
    foldl(P, Sets, {0, 0, 0}, {Red, Green, Blue}),
    Res = Red * Green * Blue.

:- pred part1(list(string)::in, int::out) is det.
part1(Lines, Sum) :-
    P = (pred(Line::in, Acc0::in, Acc1::out) is det :-
        parse_line(Line, Id, Sets),
        ( if possible_game(Sets) then
            Acc1 = Acc0 + Id
        else
            Acc1 = Acc0
        )
    ),
    foldl(P, Lines, 0, Sum).

:- pred part2(list(string)::in, int::out) is det.
part2(Lines, Sum) :-
    P = (pred(Line::in, Acc0::in, Acc1::out) is det :-
        parse_line(Line, _Id, Sets),
        power(Sets, Pow),
        Acc1 = Acc0 + Pow
    ),
    foldl(P, Lines, 0, Sum).

main(!IO) :-
    io.command_line_arguments(Args, !IO),
    Filename = det_head(Args),
    io.read_named_file_as_lines(Filename, Result, !IO),
    (
        Result = ok(Lines),
        part1(Lines, Part1),
        part2(Lines, Part2),
        write_string("Part 1: ", !IO),
        write_int(Part1, !IO),
        nl(!IO),
        write_string("Part 2: ", !IO),
        write_int(Part2, !IO),
        nl(!IO)

    ;
        Result = error(E),
        write_strings(["[ERROR] ", error_message(E), "\n"], !IO)
    ).
