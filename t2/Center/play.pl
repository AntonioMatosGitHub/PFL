%importing modules
:-consult('board_display.pl').
:-consult('board_creation.pl').
:-consult('inputparser.pl').
:-consult('menus.pl').
:- use_module(library(lists)).
:- use_module('game_utils.pl').
:- use_module('game_moves.pl').
:- use_module('states.pl').
:- use_module('game_cycle.pl').
/*
  play/0
    - Start a game from the start menu
*/
play :- main_menu_selection.
