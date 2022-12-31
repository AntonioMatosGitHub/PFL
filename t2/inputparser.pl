%parses the input from the user and calls the appropriate function
:- use_module(library(lists)).
:- use_module(library(between)).
:- use_module(library(system)).
%read a number from the user between given bounds
read_number(Min, Max, Number) :-
    read(Number),
    Number >= Min,
    Number =< Max.

% Convert the letter to its ASCII code
convert_letter_to_number(Letter, Number) :-
    char_code(Letter, ASCII),
    Number is ASCII - 97.

% Covert number to oposite side of list
covert_column_to_oposite_side(Number, Length, OpositeNumber) :-
    N is Length - Number,
    OpositeNumber is abs(N).

read_move(Board,Move) :-
  repeat,
    write('Coordinates (Line:Column)? '),
    read_coordinates(Board,Move),
    !.

read_coordinates(Board,Coordinates) :-
    read_line(CoordinateString),
    CoordinateString \= end_of_file,
    parse_coordinates(Board, CoordinateString, Coordinates).

parse_coordinates(Board, CoordinateString, Row:Column) :-
    length(Board, Length),
    append([RowString, ":", ColumnString], CoordinateString),
    number_codes(Row1, RowString),
    covert_column_to_oposite_side(Row1, Length, Row),
    atom_codes(Column1, ColumnString),
    convert_letter_to_number(Column1,Column).
    
