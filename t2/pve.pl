%importing modules
:-consult('board_display.pl').
:-consult('board_creation.pl').
:-consult('inputparser.pl').
:- use_module(library(lists)).
:- use_module('game_utils.pl').
:- use_module('game_moves.pl').
:- use_module('states.pl').
:- use_module('game_cycle.pl').
/*
pve(Size, Difficulty):-
    initial_state(Size, GameState),
    display_board(GameState),
    !,
    game_cycle(GameState-Players).
*/

pve_easy(Size, Difficulty):-
    initial_state(Size, GameState),
    display_board(GameState),
    !,
    game_cycle(GameState-Players).

pve_hard(Size, Difficulty):-
    initial_state(Size, GameState),
    display_board(GameState),
    !,
    game_cycle(GameState-Players).




generate_easy_move(Size, Chosen_Move):-
    generate_all_moves(Size, Moves),
    length(Moves, How_many_moves),
    random(0, How_many_moves, Pos),
    nth0(Pos, Moves, Chosen_Move).

generate_all_moves(Size, Moves):-
    put_rows([], 0, Size, Moves).

put_rows(Moves1, Current_row, Size, Moves2):-
    (Curret_row is Size
    -> Moves2 is Moves1;    
    (put_cols([], Current_row, 0, Size, Moves3),
    append(Moves1, Moves3, Moves4),
    New_row is Current_row + 1,
    put_rows(Moves4, New_row, Size, Moves2)
    )).

put_cols(MovesAux, Row, Col, Size, Moves3):-
    (Col is Size
    -> Moves3 is MovesAux;    
    (Coord is Row:Col,
    New_Col is Col + 1,
    /*(valid_placement(Board, Coord, Player) -> append(MovesAux,[Coord],MovesAux)),*/
    append(MovesAux,[Coord],New_Moves),
    put_cols(New_Moves, Row, New_Col, Size, Moves3)
    )).
    

generate_pro_move(Size, Best_Move):-
    generate_all_moves(Size, Moves),
    length(Moves, Id_Limit),
    get_best_distance(Size, Moves, 0, Id_Limit, 0, Best_Distance),
    random_permutation(Moves, Random_Moves),
    get_best_move(Best_Distance, Size, Random_Moves, 0, Best_Move).

get_best_move(Best_Distance, Size, Random_Moves, Id, Best_Move):-
    nth0(Id, Random_Moves, Move1),
    distance_(Move1, Size, Distance1),
    (Best_Distance is Distance1
    -> Best_Move is Move1;
    (New_Id is Id+1,
    get_best_move(Best_Distance, Size, Random_Moves, New_Id, Best_Move)   
    )).


/*
get_best_distance(Size, Moves, Id_Limit, Id_Limit, Distance, Best_Distance):-
    Best_Distance is Distance.
*/
get_best_distance(Size, Moves, Id, Id_Limit, Distance, Best_Distance):-
    (Id is Id_Limit
    -> Best_Distance is Distance;
    (
    nth0(Id, Moves, Coord),
    distance_(Coord, Size, Distance2),
    ((Distance > Distance2) ->
        New_Distance is Distance;
        New_Distance is Distance2
    ),
    New_Id is Id + 1,
    get_best_distance(Size, Moves, New_Id, Id_Limit, New_Distance, Best_Distance)
    )).


distance_(Row:Column, Size, Distance) :-
    %max between column and row
    Row_To_End is Size - Row,
    Column_To_End is Size - Column,
    Distance_to_End is min(Row_To_End, Column_To_End),
    Distance_to_Start is min(Row, Column),
    Distance is min(Distance_to_End,Distance_to_Start).


/*
put_rows(Moves1, Size, Size, Moves2):-
    Moves2 is Moves1.
*/

/*
put_cols(MovesAux, Row, Size, Size, Moves3):-
    Moves3 is MovesAux.
*/