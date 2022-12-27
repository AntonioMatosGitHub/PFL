%display header of board with size of n x n board (n = 7,9,11)  

header_display(N):-
    N =:= 7 -> 
        write('             _                  _           __               \n'),
        write('            | |                | |         / _|              \n'),
        write('      __ _  | |__     ___    __| |   ___  | |_    __ _       \n'),
        write('     / _` | | \'_ \\   / __|  / _` |  / _ \\ |  _|  / _` |   \n'),
        write('    | (_| | | |_) | | (__  | (_| | |  __/ | |   | (_| |      \n'),
        write('     \\__,_| |_|__/   \\___|  \\__,_|  \\___| |_|    \\__, | \n'),
        write('                                                 __ / |      \n'),
        write('                                                |___ /       \n'),
        write('------------------------------------------------------------\n') ;

    N =:= 9 -> 
        write('            _                  _           __           _       _        \n'),
        write('           | |                | |         / _|         | |     (_)       \n'),
        write('     __ _  | |__     ___    __| |   ___  | |_    __ _  | |__    _        \n'),
        write('    / _` | | \'_ \\   / __|  / _` |  / _ \\ |  _|  / _` | | \'_ \\  | |  \n'),
        write('   | (_| | | |_) | | (__  | (_| | |  __/ | |   | (_| | | | | | | |       \n'),
        write('    \\__,_| |_|__/   \\___|  \\__,_|  \\___| |_|    \\__, | |_| |_| |_|  \n'),
        write('                                                __ / |                   \n'),
        write('                                               |___ /                    \n'),
        write('-------------------------------------------------------------------------\n') ;
    N =:= 11 -> 
        write('            _                  _           __           _       _     _   _            \n'),
        write('           | |                | |         / _|         | |     (_)   (_) | |           \n'),
        write('     __ _  | |__     ___    __| |   ___  | |_    __ _  | |__    _     _  | | __        \n'),
        write('    / _` | | \'_ \\   / __|  / _` |  / _ \\ |  _|  / _` | | \'_ \\  | |   | | | |/ /   \n'),
        write('   | (_| | | |_) | | (__  | (_| | |  __/ | |   | (_| | | | | | | |   | | |   <         \n'),
        write('    \\__,_| |_|__/   \\___|  \\__,_|  \\___| |_|    \\__, | |_| |_| |_|   | | |_|\\_\\ \n'),
        write('                                                __ / |              _/ |               \n'),
        write('                                               |___ /              |__/                \n'),
    write('--------------------------------------------------------------------------------------- \n').


      







