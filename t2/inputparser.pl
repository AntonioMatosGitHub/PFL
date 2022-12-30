%parses the input from the user and calls the appropriate function
:- use_module(library(lists)).
%read a number from the user between given bounds
read_number(Min, Max, Number) :-
    read(Number),
    Number >= Min,
    Number =< Max.

% Convert the letter to its ASCII code
convert_letter_to_number(Letter, Number) :-
    char_code(Letter, ASCII),
    Number is ASCII - 97.



% is piece on sight 
friendly_piece(R, C, PR, PC) :-
    % If they are in the same row
    R is PR, !;
    % If they in the same column
    C is PC, !;
    % If they share any diagonaly
    R - PR is C - PC, !.



% Predicate to count the number of friendly pieces in sight
count_friendly_pieces(Board, Row, Row1 , Column, Column1, Player, Acc, Count) :-
    write('Checking piece at row '), write(Row), write(' and column '), write(Column), nl,
    % Check the piece at the current position
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Piece),
    write('Piece is '), write(Piece), nl,
    write('P<layer is '), write(Player), nl,
    write(Piece is Player), nl,
    (Piece is Player ->
        % If it is a friendly piece, increment the count
        write('Incrementing count'), nl,
        NewAcc is Acc + 1;
        NewAcc is Acc
    ),
    % Move to the next position
    NextCol1 is Col1 + 1,
    (NextCol1 is length(Board) ->
     NextRow1 is Row1 + 1,
     NextCol1 is 0;
     NextRow1 is Row1,
     NextCol1 is Col1 + 1),
    count_friendly_pieces(Board, Row, NextRow1 , Column, NextColumn1, Player, NewAcc, Count).


