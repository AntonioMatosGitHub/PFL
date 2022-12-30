%importing modules
:-consult('board_display.pl').
:-consult('board_creation.pl').
:-consult('inputparser.pl').
:- use_module(library(lists)).



% Predicate to check if the game has been won by a player
game_won(Board, Size, Player) :-
    % Check if the center of the board is occupied by the player
    Center is div(Size, 2),
    nth0(Center, nth0(Center, Board, Row), Player).

% Predicate to check if a placement is valid
valid_placement(Board, Row, Column, Player) :-
    % Check if the placement is within the bounds of the board
    length(Board, NumRows),
    Row < NumRows,
    Column < NumRows,
    Row >= 0,
    Column >= 0,
    % Check if the placement is N steps away from the perimeter
    (Row is 0; Row is NumRows - 1; Column is 0; Column is NumRows - 1 ->
        % Calculate the number of friendly pieces in sight
        count_friendly_pieces(Board, Row, Column, Player, 0, Count),
        % Calculate the distance from the perimeter
        (Row is 0; Row is NumRows - 1 -> Distance is abs(Row - (NumRows - 1))
         ;  Distance is abs(Column - (NumRows - 1))
        ),
        % Check if there are at least N friendly pieces in sight
        Count >= Distance
     ;  true
    ),
     % Check if the placement is empty
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Element),
    Element is 0.

%Predicate to see if a piece is in sight
% Predicate to count the number of friendly pieces in sight
count_friendly_pieces(Board, Row, Row1 , Column, Column1 Player, Acc, Count) :-
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
        NewAcc is Acc + 1
     ;  NewAcc is Acc
    ),
    % Move to the next position
    NewRow1 is Row1 + 1,
    count_friendly_pieces(Board, Row, NewRow1 , newColumn, Column1 Player, Acc, Count).

% Predicate to make a move
make_move(Board, Row, Column, Player, NewBoard) :-
    % Check if the move is valid
    valid_placement(Board, Row, Column, Player),
    % Place the piece on the board
    replace(Row, Column, Board, Player, NewBoard).

% Predicate to replace an element in a matrix
replace(0, Column, [Row|Rest], Value, [NewRow|Rest]) :-
    replace_in_list(Column, Row, Value, NewRow).
replace(Row, Column, [H|T], Value, [H|NewT]) :-
    Row > 0,
    NewRow is Row - 1,
    replace(NewRow, Column, T, Value, NewT).

% Predicate to replace an element in a list
replace_in_list(0, [_|T], Value, [Value|T]).
replace_in_list(Column, [H|T], Value, [H|NewT]) :-
    Column > 0,
    NewColumn is Column - 1,
    replace_in_list(NewColumn, T, Value, NewT).

% Predicate to start a game
play(Size, Player, Board) :-
    % Initialize the board
    create_board(Size, Board),
    % Display the board
    display_board(Board),nl,
    % Make moves until the game is won
    (game_won(Board, Size, Player) ->
        write('Player '), write(Player), write(' wins!'), nl
     ;  (game_won(Board, Size, OtherPlayer) ->
            write('Player '), write(OtherPlayer), write(' wins!'), nl
         ;  (Player is 1 ->
                NextPlayer is -1
             ;  NextPlayer is 1
            ),
            write('Player '), write(Player), write(' turn. Enter row and column: '),
            read(Row), read(Column),
            %transform the input to integers
            integer(Row),
            integer(Column),
            make_move(Board, Row, Column, Player, NewBoard),
            play(Size, NextPlayer, NewBoard)
         )
     ).
