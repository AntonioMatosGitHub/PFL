%importing modules
:-consult('board_display.pl').
:-consult('board_creation.pl').
:-consult('inputparser.pl').
:- use_module(library(lists)).
:- use_module('game_utils.pl').
:- use_module('game_moves.pl').
:- use_module('states.pl').
:- use_module('pve.pl').

%% Predicate to start a game
%play(Size, Player,Board) :-
%    % Initialize the board
%    create_board(Size, Board),
%    % Display the board
%    display_board(GameState),nl,
%    % Make moves until the game is won
%    (game_won(Board, Size, Player) ->
%        write('Player '), write(Player), write(' wins!'), nl
%     ;  (game_won(Board, Size, OtherPlayer) ->
%            write('Player '), write(OtherPlayer), write(' wins!'), nl
%         ;  (NextPlayer is - Player),
%            write('Player '), write(Player), write(' turn. Enter row and column: '),
%            read(Row), read(Column),
%            %transform the input to integers
%            convert_letter_to_number(Column, Col),
%            covert_column_to_oposite_side(Row, Size, R),
%            make_move(Board, R, Col, Player, NewBoard),
%            display_board(NewBoard),nl,
%            play(Size, NextPlayer, NewBoard)
%         )over
%     ).


%game_cycle
/*
  game_cycle(+GameState-Players).
    - Handle game cycle
      - Get chosen move from current player
      - Update board with chosen move
      - Check if game over
*/
game_cycle(_, _, Gamestate-_):-
  write('\nCHECKING\n'),
  game_won(GameState, Winner),
  !,
  congratulate_winner(Winner).

game_cycle(Turn, Size,GameState-Player1:Player2):-
  repeat,
    (Turn < 0
    -> PlayerNow is Player1;
    PlayerNow is Player2),
    choose_move(Size, GameState,PlayerNow, Move),
    make_move(GameState, Move, NewGameState),
    display_game(NewGameState),
    !,
    New_Turn is -(Turn),
    game_cycle(New_Turn, Size, NewGameState-Player1:Player2).


/* Display Game */
/*
  display_game(+GameState)
  GameState = Board-FirstPiece
    - Display the game represented by GameState
*/
display_game(GameState) :-
  display_board(GameState).