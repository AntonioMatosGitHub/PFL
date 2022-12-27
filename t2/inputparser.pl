%parses the input from the user and calls the appropriate function

%read a number from the user between given bounds
read_number(Min, Max, Number) :-
    read(Number),
    Number >= Min,
    Number =< Max.
    