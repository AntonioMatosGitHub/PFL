:- use_module(library(random)). % random
consult('board_display.pl').
consult('board_creation.pl').

/*
  initial_state(+Size, ?GameState)
  GameState = Board-FirstPlayer
    - Return the initial state (GameState) for the game with a board of Size.
*/
initial_state(Size, GameState) :-
  create_board(Size,Board),
  player_selector(Player),
  GameState = Board-Player.

/*
  random_player(-PLayer)
    - Choose a random Player to start the game
*/
player_selector(Player) :-
  random(N), 
  (N < 0.5, Player = -1);
  (Player = 1).


% Predicate to check if the game has been won by a player
game_won(GameState,Winner) :-
    % Check if the center of the board is occupied by the player
    GameState = Board-Player,
    length(Board, Size),
    Center is div(Size, 2),
    nth0(Center, Board, Row),
    nth0(Center, Row, Player),
    Winner is Player.
