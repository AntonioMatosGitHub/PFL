-- PFL-2022/23 - TP1 tests
-- By: Gonçalo Leão

module PFL2022TP1Tests where

intersperse' :: a -> [a] -> [a]
intersperse' _ [] = []
intersperse' _ [y] = [y]
intersperse' x (y1:y2:ys) = y1:x:(intersperse' x (y2:ys))

largePolyString :: Char -> Int -> [(Int, [(Char, Int)])]
largePolyString c a | a > 0 = [(b, [(c, b)]) | b <- [1..a]]
                    | a < 0 = [(b, [(c, (-b))]) | b <- [a..(-1)]]

str1 :: String
str1 = "-4"

str2 :: String
str2 = "2xyzw"

str3 :: String
str3 = "30a^10b^1c^3"

str4 :: String
str4 = "30a^10bc^3 -30z +    y        -yz"

str5 :: [(Int, [(Char, Int)])]
str5 = largePolyString 'x' 5000



str6 :: [(Int, [(Char, Int)])]
str6 = [(3,[('x',1)]),(4,[('x',1)]),(-2,[('y',1)]),(1,[('y',1)]),(2,[('x',2)]),(-1,[('x',2)])]


str7 :: [(Int, [(Char, Int)])]
str7 = [(-2, [('y', 1)]), (3, [('x', 1)]), (1, [('y', 1)]), (2, [('x', 2)]), (4, [('x', 1)]), (-1, [('x', 2)])]


str8 :: [(Int, [(Char, Int)])]
str8 = [(-2, [('x', 1), ('y', 1), ('z', 1)]), (3, [('x', 1), ('y', 1)]), (1, [('y', 1), ('z', 1), ('x', 1)]), (-5, [('y', 1), ('x', 1)]), (3, [('z', 1), ('y', 1), ('x', 1)])]


str9 :: [(Int, [(Char, Int)])]
str9 =  [(-2, [('x', 1), ('y', 1), ('z', 1)]), (0, [('x', 1), ('y', 1)]), (1, [('y', 1), ('z', 1), ('x', 1)]), (-5, [('y', 1), ('x', 1)]), (3, [('z', 1), ('y', 1), ('x', 1)])]

str10 :: [(Int, [(Char, Int)])]
str10 = (largePolyString 'x'  2000) ++ (largePolyString 'x' (-2000))

str11 :: [(Int, [(Char, Int)])]
str11 = [(1, [('x', 3),('z',1)]),(1, [('y', 1)])]

str12 :: [(Int, [(Char, Int)])]
str12 = [(1, [('y', 2)]),(1, [('x', 3),('z',1)])]

str13 :: [(Int, [(Char, Int)])]
str13 = largePolyString 'x' 2000

str14 :: [(Int, [(Char, Int)])]
str14 = largePolyString 'x' (-2000)

str15 :: [(Int, [(Char, Int)])]
str15 = largePolyString 'x' 4

str16 :: [(Int, [(Char, Int)])]
str16 = largePolyString 'x' (-4)

str17 :: [(Int, [(Char, Int)])]
str17 = [(-2, [('x', 1), ('y', 1), ('z', 1)]), (3, [('x', 1), ('y', 1)]), (7, [('y', 2), ('z', 1)]), (-5, [('z', 1), ('x', 1)]), (3, [('y', 1)]), (-2, [(' ', 1)])]
