%importing modules
:-consult('board_display.pl').
:-consult('board_creation.pl').
:-consult('inputparser.pl').
:- use_module(library(between)).
:- use_module(library(lists)).
:- use_module('game_utils.pl').
:- use_module('pve.pl').


% Predicate to check if a placement is valid
valid_placement(Board, Row:Column, Player) :-
    % Check if the placement is within the bounds of the board
    length(Board, NumRows),
    NR is NumRows - 1,
    between(0, NR, Row),
    between(0, NR, Column),
    % Check if the placement is N steps away from the perimeter
    % Calculate the number of friendly pieces in sight
    count_friendly_pieces(Board, Row, Column, Player, Count),
    %write('write'), write(Count), nl,
    % Calculate the distance from the perimeter
    distance(Row, Column, Distance, NR),
    %write('distance'), write(Distance), nl,
    % Check if there are at least N friendly pieces in sight
    Count >= Distance,
    % Check if the placement is empty
    %write('empty'), nl,
    nth0(Row, Board, RowList),
    nth0(Column, RowList, Element),
    Element =:= 0.

% Predicate to make a move
make_move(GameState, Move, NewGameState) :-
    GameState = Board-Player,
    %write(Move), nl,
    % Check if the move is valid
    valid_placement(Board, Move, Player),
    %write('valid bro'), nl,
    % Place the piece on the board
    replace_board_cell(Move, Player, Board, NewBoard),
    NewPlayer is - Player,
    %write(NewBoard), nl,
    nl,
    NewGameState = NewBoard-NewPlayer.

% Ask player to choose a move
choose_move(Size, Board-Player, 0, Move):-
  %Gamestate = Board-Player,
  convert(Player, Symbol),
  format('\nIt\'s ~p\'s turn.', [Symbol]), nl,
  write('Coordinates? (Row:Column) '),
  repeat,
    read_coordinates(Board,Move),
    !.
  %read_move(Board,Move).
   /* read_coordinates(Board,Move),
  repeat,
    write('Coordinates? (Row:Column) '),
    read_coordinates(Board,Move),
    !.*/

choose_move(Size, GameState, 1, Move):-
  sleep(0.5),
  generate_easy_move(Size, GameState, Move).

choose_move(Size, GameState, 2, Move):-
  sleep(0.5),
  generate_pro_move(Size, GameState, Move).
