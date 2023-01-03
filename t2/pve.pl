%importing modules
:-consult('board_display.pl').
:-consult('board_creation.pl').
:-consult('inputparser.pl').
:- use_module(library(lists)).
:- use_module('game_utils.pl').
:- use_module('game_moves.pl').
:- use_module('states.pl').
:- use_module('game_cycle.pl').
:- use_module(library(random)).


%Create a move for a Dumb AI
generate_easy_move(Size, GameState, Chosen_Move):-
    generate_all_moves(Size, GameState, Moves),
    length(Moves, How_many_moves),
    random(0, How_many_moves, Pos),
    nth0(Pos, Moves, Chosen_Move).

%Get all valid moves
generate_all_moves(Size, GameState, Moves):-
    put_rows([], 0, Size, GameState, Moves).

%Used to ask for the moves of every row
put_rows(Moves1, Current_row, Size, GameState, Moves2):-
    (Current_row >= Size
    -> (Moves2 = Moves1);
    (put_cols([], Current_row, 0, Size, GameState, Moves3),
    append(Moves1, Moves3, Moves4),
    New_row is (Current_row + 1),
    put_rows(Moves4, New_row, Size, GameState, Moves2)
    )).

%Used to get all moves per row
put_cols(MovesAux, _, Size, Size, _, MovesF):-
    MovesF = MovesAux.

put_cols(MovesAux, Row, Col, Size, Board-Player, MovesF):-
    New_Col is Col + 1,
    (valid_placement(Board, Row:Col, Player)
    -> (append(MovesAux,[Row:Col],New_Moves),
    put_cols(New_Moves, Row, New_Col, Size, Board-Player, MovesF)
    );
    put_cols(MovesAux, Row, New_Col, Size, Board-Player, MovesF)
    ).

%Create a move for a Smart AI
generate_pro_move(Size, GameState, Best_Move):-
    generate_all_moves(Size, GameState, Moves),
    length(Moves, Id_Limit),
    get_best_distance(Size, Moves, 0, Id_Limit, 0, Best_Distance),
    random_permutation(Moves, Random_Moves),
    get_best_move(Best_Distance, Size, Random_Moves, 0, Best_Move).

%Determine what the biggest distance from the border (aka closer to the center) in the next play can be
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

%Determine distance between piece and border
distance_(Row:Column, Size, Distance) :-
    Row_To_End is Size - Row,
    Column_To_End is Size - Column,
    Distance_to_End is min(Row_To_End, Column_To_End),
    Distance_to_Start is min(Row, Column),
    Distance is min(Distance_to_End,Distance_to_Start).

%Get a move with the best distance possible
get_best_move(Best_Distance, Size, Random_Moves, Id, Best_Move):-
    nth0(Id, Random_Moves, Move1),
    distance_(Move1, Size, Distance1),
    (Best_Distance is Distance1
    -> Best_Move = Move1;
    (New_Id is Id+1,
    get_best_move(Best_Distance, Size, Random_Moves, New_Id, Best_Move)   
    )).

