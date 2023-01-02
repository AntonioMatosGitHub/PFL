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
  game_cycle(GameState-Players).