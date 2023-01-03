%importing modules
:-consult('board_display.pl').
:-consult('board_creation.pl').
:-consult('inputparser.pl').
:- use_module(library(lists)).
:- use_module('game_utils.pl').
:- use_module('game_moves.pl').
:- use_module('states.pl').
:- use_module('game_cycle.pl').

%start pvp game with a board of a certain size
pvp(Size):-
  initial_state(Size, GameState),
  display_board(GameState),
  !,
  game_cycle(-1, Size, GameState-0:0).

%start pve game against Dumb AI with a board of a certain size
pve_easy(Size):-
  initial_state(Size, GameState),
  display_board(GameState),
  !,
  game_cycle(-1, Size, GameState-0:1).

%start pve game against Smart AI with a board of a certain size
pve_hard(Size):-
  initial_state(Size, GameState),
  display_board(GameState),
  !,
  game_cycle(-1, Size, GameState-0:2).

%start eve game with a board of a certain size
eve(Size):-
  initial_state(Size, GameState),
  display_board(GameState),
  !,
  game_cycle(-1, Size, GameState-1:2).