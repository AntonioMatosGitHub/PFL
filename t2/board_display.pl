top_grid('\x252c\').
right_grid('\x2524\').
bottom_grid('\x2534\').
left_grid('\x251c\').
center_grid('\x253c\').
horizontal_separator('\x2500\').
vertical_separator('\x2502\').
top_left_corner('\x250c\').
bottom_right_corner('\x2518\').
bottom_left_corner('\x2514\').
top_right_corner('\x2510\').

% Predicate to convert an element to its corresponding character
convert(-1, '\x25b2\').
convert(1, '\x25cb\').
convert(0, ' ').

% Predicate to display the board
display_board(GameState) :-
    % Get the board from the game state
    GameState = Board-_,
    % Get the size of the board
    length(Board, Rows),
    (Rows > 0
     -> length(Board, Size),
        % Display the column labels
        display_column_labels(Size),
        % Display the top of the board
        top_left_corner(TopLeftCorner),
        top_right_corner(TopRightCorner),
        horizontal_separator(HorizontalSeparator),
        write('   '),
        write(TopLeftCorner),
        write(HorizontalSeparator),
        write(HorizontalSeparator),
        write(HorizontalSeparator),
        TopSize is Size - 1,
        display_top_separator(TopSize),
        write(TopRightCorner),
        nl,
        % Display the rows
        display_rows(Board, Size)
     ;  true
    ).

% Predicate to display the top separator of the board
display_top_separator(0) :-
    !.
display_top_separator(Size) :-
    top_grid(TopGrid),
    write(TopGrid),
    horizontal_separator(HorizontalSeparator),
    write(HorizontalSeparator),
    write(HorizontalSeparator),
    write(HorizontalSeparator),
    NewSize is Size - 1,
    display_top_separator(NewSize).

% Predicate to display the column labels
display_column_labels(Size) :-
    write('     '),
    % Display the labels from 'a' to Size
    NewASize is Size + 96,
    display_labels(97, NewASize),
    nl.

% Predicate to display the labels from Start to End
display_labels(Start, End) :-
    Start > End,
    !.
display_labels(Start, End) :-
    char_code(Label, Start),
    write(Label),
    write('   '),
    NewStart is Start + 1,
    display_labels(NewStart, End).

% Predicate to display each row of the board
display_rows([], _).
display_rows([Row|Rest], Size) :-
    % Display a row
    length(Rest, RowsRemaining),
    RowNumber is RowsRemaining + 1,
    display_row(Row, RowNumber, Size),
    % Display the rest of the rows
    (Rest \= []
     -> display_rows(Rest, Size)
     ;  display_bottom(Size)
    ).


% Predicate to display a row
display_row(Row, Column, Size) :-
    % Check if it is the first row
    (Column is Size
     -> true % Do not display the row separator
     ;  (left_grid(LeftGrid),
         center_grid(CenterGrid),
         right_grid(RightGrid),
         write('   '),
         write(LeftGrid),
         GridSize is Size - 1,
         display_row_separator(GridSize, CenterGrid),
         horizontal_separator(HorizontalSeparator),
         write(HorizontalSeparator),
         write(HorizontalSeparator),
         write(HorizontalSeparator),
         write(RightGrid),
         nl)
    ),
    % Display the row label
    (Column is Size
     -> write(Column);
        write(Column)
    ),
    write('  '),
    vertical_separator(VerticalSeparator),
    write(VerticalSeparator),
    % Display the row elements
    display_row_elements(Row, Size),
    nl.


% Predicate to display the row separator
display_row_separator(0, _) :-
    !.
display_row_separator(Size, Separator) :-
    horizontal_separator(HorizontalSeparator),
    write(HorizontalSeparator),
    write(HorizontalSeparator),
    write(HorizontalSeparator),
    write(Separator),
    NewSize is Size - 1,
    display_row_separator(NewSize, Separator).

% Predicate to display the elements of a row
display_row_elements([], _) :-
    !.
display_row_elements([Element|Rest], Size) :-
    convert(Element, ConvertedElement),
    write(' '),
    write(ConvertedElement),
    write(' '),
    vertical_separator(VerticalSeparator),
    write(VerticalSeparator),
    display_row_elements(Rest, Size).



% Predicate to display the bottom of the board
display_bottom(Size) :-
    bottom_left_corner(BottomLeftCorner),
    bottom_grid(BottomGrid),
    bottom_right_corner(BottomRightCorner),
    write('   '),
    write(BottomLeftCorner),
    Bottomsize is Size - 1,
    display_row_separator(Bottomsize, BottomGrid),
    horizontal_separator(HorizontalSeparator),
    write(HorizontalSeparator),
    write(HorizontalSeparator),
    write(HorizontalSeparator),
    write(BottomRightCorner).
