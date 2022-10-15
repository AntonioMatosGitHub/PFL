import Data.List
import System.IO
-- example: in -2x^3
type Var = (Char, Int)      -- char is 'x' and int is 3

type Mon = (Int, [Var])  -- note: there is a list of variables

type Pol = [Mon]

--Int a = 0
--[Var] v = (a, b, c)
sortVar = sort [('z', 1), ('a', 3), ('b', 2)]


-- for example: in -4x^2y^3 there is
-- quantifier -4
-- variable with char 'x' and int 2
-- variable with 'y' and int 3
