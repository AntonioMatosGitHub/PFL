% Predicate to create an empty board of the given size
create_board(Size, Board) :-
    create_board(Size, Size, Board).

% Predicate to create an empty board of the given size and number of rows
create_board(0, _, []) :- !.
create_board(Rows, Columns, [Row|Rest]) :-
    create_row(Columns, Row),
    NewRows is Rows - 1,
    create_board(NewRows, Columns, Rest).

% Predicate to create an empty row of the given size
create_row(0, []) :- !.
create_row(Columns, [0|Rest]) :-
    NewColumns is Columns - 1,
    create_row(NewColumns, Rest).