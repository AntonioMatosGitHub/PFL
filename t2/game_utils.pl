% Check if a certain piece is in sight 
friendly_piece(R, C, PR, PC, Player,Piece) :- 
    %if player is the owner of piece
    Piece =:= Player,
    % If they are in the same row
    (R =:= PR, !;
    % If they in the same column
    C =:= PC, !;
    % If they share any diagonay
    abs(R - PR) =:= abs(C - PC), !).

% Predicate to count the number of friendly pieces in sight
count_friendly_pieces(Board, Row, Column, Player, Count) :-
    length(Board, Size),
    findall(X-Y,  
        (between(0, Size, X),
        between(0, Size, Y),
        nth0(Y, Board, RowList),
        nth0(X, RowList, Piece),
        friendly_piece(Row, Column, Y, X, Player, Piece))
    ,L),
    write(L),
    length(L, Count).

%Predicate to calculate distante from a piece to border of board
distance(Row, Column, Distance, Size) :-
    %max between column and row
    Row_To_End is Size - Row,
    Column_To_End is Size - Column,
    Distance_to_End is min(Row_To_End, Column_To_End),
    Distance_to_Start is min(Row, Column),
    Distance is min(Distance_to_End,Distance_to_Start).

% replace 
/*
  replace(?List, ?Index, ?OldElem, ?NewElem, ?NewList).
  - Create NewList/List with NewElem/OldElem at Index of List/NewList (replacing OldElem/NewElem)
  - Get Index of OldElem/NewElem at List/NewList
  - Get OldElem/NewElem at Index of List/NewList
*/
replace(List, Index, OldElem, NewElem, NewList) :-
   nth0(Index, List, OldElem, Transfer),
   nth0(Index, NewList, NewElem, Transfer).


% replace_board_cell
/*
  replace_board_cell(?Position, ?Cell, ?OldBoard, ?NewBoard).
    Position = Line:Column
  - Create NewBoard replacing cell at Position with Cell
  - Get Cell at Position in OldBoard
*/
replace_board_cell(Line:Column, Cell, OldBoard, NewBoard) :-
  replace(OldBoard, Line, OldRow, NewRow, NewBoard),
  replace(OldRow, Column, _, Cell, NewRow).


% congratulate winner of the game
congratulate_winner(Player) :-
    write('Congratulations, Player '),
    write(Player),
    write(' won the game!').

    