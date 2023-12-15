% vim: set ft=prolog:

:- use_module(library(main), []).
:- use_module(library(clpfd)).
:- use_module(library(lists), [sum_list/2]).
:- use_module(library(strings), [string_lines/2]).

:- initialization(main, main).

main([Filename]) :-
    access_file(Filename, read), !,
    setup_call_cleanup(
        open(Filename, read, In),
        read_string(In, _, Contents),
        close(In)),
    string_lines(Contents, Lines),
    maplist(parse_line, Lines, Arrangements1, Arrangements2),
    sum_list(Arrangements1, Sum1),
    sum_list(Arrangements2, Sum2),
    format("Part 1: ~w~nPart 2: ~w~n", [Sum1, Sum2]).
main([Filename]) :-
    format("Unable to access ~w~n", [Filename]).
main(_) :-
    format("Usage: dayXXX.pl <filename>~n").

unfold(Line, Ns, OutLine, OutNs) :-
    append([Line, ['?'], Line, ['?'], Line, ['?'], Line, ['?'], Line], OutLine),
    append([Ns, Ns, Ns, Ns, Ns], OutNs).

parse_line(Line, N1, N2) :-
    split_string(Line, " ,", "", [Springs | NumStrs]),
    maplist(number_string, Nums, NumStrs),
    string_chars(Springs, S),
    unfold(S, Nums, S2, Nums2),
    valid_line(S, Nums, N1),
    valid_line(S2, Nums2, N2),
    abolish_private_tables.

:- table valid_line/3.

valid_line([], [], 1).
valid_line([], [_ | _], 0).
valid_line(['.' | Rest], Groups, N) :-
    valid_line(Rest, Groups, N).
valid_line(['?' | Rest], Groups, N3) :-
    valid_line(['.' | Rest], Groups, N1),
    valid_line(['#' | Rest], Groups, N2),
    N3 is N1 + N2.
valid_line(['#' | _], [], 0).
valid_line(['#' | S], [G | Groups], N) :-
    Springs = ['#' | S],
    (
        split_at(G, Springs, Run, Rest)
    -> valid_run(Run, Rest, Groups, N)
    ;  N = 0
    ).

valid_run(['.' | _], _Springs, _Groups, 0) :- !.
valid_run([_ | Rest], Springs, Groups, N) :- valid_run(Rest, Springs, Groups, N).
valid_run([], [], [], 1).
valid_run([], [], [_ | _], 0).
valid_run([], ['#' | _], _, 0) :- !.
valid_run([], [_ | Springs], Groups, N) :- valid_line(Springs, Groups, N).

split_at(0, L, [], L) :- !.
split_at(N, [H|T], [H|L1], L2) :-
    M is N - 1,
    split_at(M, T, L1, L2).

