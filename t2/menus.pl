% Description: Menus for the game

%importing modules
:-consult('inputparser.pl').
:-consult('pvp.pl').

%clear screen 
clear :- write('\e[2J').

%ascii art of the game logo
game_logo :- 
  write('   /$$$$$$                        /$$                        \n'),
  write('  /$$__  $$                      | $$                        \n'),
  write(' | $$  \\__/  /$$$$$$  /$$$$$$$  /$$$$$$    /$$$$$$   /$$$$$$ \n'),
  write(' | $$       /$$__  $$| $$__  $$|_  $$_/   /$$__  $$ /$$  /$$|\n'),
  write(' | $$      | $$$$$$$$| $$  \\ $$  | $$    | $$$$$$$$| $$  \\__/\n'),
  write(' | $$    $$| $$_____/| $$  | $$  | $$ /$$| $$_____/| $$      \n'),
  write(' |  $$$$$$/|  $$$$$$$| $$  | $$  |  $$$$/|  $$$$$$$| $$      \n'),
  write('  \\______/  \\_______/|__/  |__/   \\___/   \\_______/|__/      \n').

%main menu
main_menu :- 
  clear,
  game_logo, nl,
  write('-------------------------- Main Menu ------------------------- \n'),
  write('|                                                            | \n'),   
  write('|                      1. Start Game PvP                     | \n'),
  write('|                      2. Start Game PvE                     | \n'), 
  write('|                      3. Game Rules                         | \n'),  
  write('|                      4. Exit Game                          | \n'),
  write('|                                                            | \n'),
  write('-------------------------------------------------------------- \n').                                 


%PvP menu board size
pvp_menu :- 
  clear,
  game_logo, nl,
  write('--------------------------- PvP Menu ------------------------- \n'),
  write('|                                                            | \n'),   
  write('|                      1. Board size 7x7                     | \n'),
  write('|                      2. Board Size 9x9                     | \n'),
  write('|                      3. Board Size 11x11                   | \n'),   
  write('|                      4. Exit Game                          | \n'),
  write('|                                                            | \n'),
  write('|                                                    0.Back  | \n'),
  write('-------------------------------------------------------------- \n').

%PvE menu 1 board size
pve_menu_1 :- 
  clear,
  game_logo, nl,
  write('--------------------------- PvE Menu ------------------------- \n'),
  write('|                                                            | \n'),   
  write('|                      1. Board size 7x7                     | \n'),
  write('|                      2. Board Size 9x9                     | \n'),
  write('|                      3. Board Size 11x11                   | \n'),   
  write('|                      4. Exit Game                          | \n'),
  write('|                                                            | \n'),
  write('|                                                    0.Back  | \n'),
  write('-------------------------------------------------------------- \n').

%PvE menu 2 difficulty
pve_menu_2 :- 
  clear,
  game_logo, nl,
  write('--------------------------- PvE Menu ------------------------- \n'),
  write('|                                                            | \n'),   
  write('|                        1. Easy                             | \n'),
  write('|                        2. Medium                           | \n'),
  write('|                        3. Hard                             | \n'),   
  write('|                        4. Exit Game                        | \n'),
  write('|                                                            | \n'),
  write('|                                                    0.Back  | \n'),
  write('-------------------------------------------------------------- \n').

% game rules menu
game_rules :-
  clear,
  game_logo, nl,
  write('------------------------- Game Rules ------------------------- \n'),
  write('|                                                            | \n'),   
  write('|  Players take turns placing one stone at a time.           | \n'),
  write('|  A placement N steps away from the perimeter must have at  | \n'),
  write('|  least N friendly pieces in sight.                         | \n'),
  write('|  On the square board, pieces see in all 8 directions       | \n'),
  write('|  The winner is the player who places a stone on the very   | \n'),
  write('|  center of the board.                                      | \n'),
  write('|                                                            | \n'),
  write('|                                                    0.Back  | \n'),
  write('-------------------------------------------------------------- \n').

% game over menu
game_over :-
  clear,
  game_logo, nl,
  write('--------------------------- Game Over ------------------------ \n'),
  write('|                                                            | \n'),   
  write('|  The game is over!                                         | \n'),
  write('|  Do you want to play again?                                | \n'),
  write('|                                                            | \n'),
  write('|                      1. Yes                                | \n'),
  write('|                      2. No                                 | \n'),
  write('|                                                            | \n'),
  write('-------------------------------------------------------------- \n').

%main menu selection interface
main_menu_selection :-
  main_menu,
  write('Please select an option: '),
  read_number(1, 4, Option),
  main_menu_selection(Option).

%pvp_menu selection interface
pvp_menu_selection :-
  pvp_menu,
  write('Please select an option: '),
  read_number(0, 4, Option),
  pvp_menu_selection(Option).

%pve_menu_1 selection interface
pve_menu_1_selection :-
  pve_menu_1,
  write('Please select an option: '),
  read_number(0, 4, Option),
  pve_menu_1_selection(Option).

%pve_menu_2 selection interface
pve_menu_2_selection :-
  pve_menu_2,
  write('Please select an option: '),
  read_number(0, 4, Option),
  pve_menu_2_selection(Option).

%game_rules selection interface
game_rules_selection :-
  game_rules,
  write('Please select an option: '),
  read_number(0, 0, Option),
  game_rules_selection(Option).

%game_over selection interface
game_over_selection :-
  game_over,
  write('Please select an option: '),
  read_number(1, 2, Option),
  game_over_selection(Option).

%main menu selection
main_menu_selection(1) :- pvp_menu_selection.
main_menu_selection(2) :- pve_menu_1_selection.
main_menu_selection(3) :- game_rules_selection.
main_menu_selection(4) :- halt.

%pvp_menu selection
pvp_menu_selection(0) :- main_menu_selection.
pvp_menu_selection(1) :- pvp(7).
pvp_menu_selection(2) :- pvp(9).
pvp_menu_selection(3) :- pvp(11).
pvp_menu_selection(4) :- halt.

%pve_menu_1 selection
pve_menu_1_selection(0) :- main_menu_selection.
pve_menu_1_selection(1) :- pve_menu_2_selection.
pve_menu_1_selection(2) :- pve_menu_2_selection.
pve_menu_1_selection(3) :- pve_menu_2_selection.
pve_menu_1_selection(4) :- halt.

%pve_menu_2 selection
pve_menu_2_selection(0) :- pve_menu_1_selection.
pve_menu_2_selection(1) :- pve(7, easy).
pve_menu_2_selection(2) :- pve(9, medium).
pve_menu_2_selection(3) :- pve(11, hard).
pve_menu_2_selection(4) :- halt.

%game_rules selection
game_rules_selection(0) :- main_menu_selection.

%game_over selection
game_over_selection(1) :- main_menu_selection.
game_over_selection(2) :- halt.
