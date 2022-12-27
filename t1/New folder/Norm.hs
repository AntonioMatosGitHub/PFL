module Norm (removeZero, substituteExpZero, removeExpZero, fixExpZero, sortVars, sortPol, addSome, addMons, 
normalize, addPols, findVar, addExp, multVars,multi,multPols,findN,removeN,getExpN,derivateMon,derivatePol,
parse,parse',parseSentence,parseSentence',readPolynomial,readMonomial,isSign,parseCoef,readVarList,removeWhiteSpace) where

import Data.List
import System.IO
import Data.Char (isDigit, isSpace)

------------------------------------------------------------ TYPES---------------------------------------------------------------
-- par de uma incógnita e respetivo expoente
type Var = (Char, Int)   -- 1º elemento: incógnita
                         -- 2º elemento: expoente
--lista de incógnitas e respetivos expoentes
type Vars = [Var]
-- monómio
type Mon = (Int, Vars)  -- 1º elemento: quantificador
                         -- 2º elemento: lista de incógnitas e respetivos expoentes
-- polinómio
type Pol = [Mon]


------------------------------------------------------NORMALIZAÇÃO E ADIÇÃO-------------------------------------------------------
-- remove monómios de quantificador 0 de um polinómio
removeZero :: Pol -> Pol
removeZero [] = []
removeZero (x:xs)  | 0 == fst (x) = removeZero xs
                   | otherwise    = x : removeZero xs

-- (auxílio do fixExpZero) para quando a incógnita de expoente 0 é a única do monómio
substituteExpZero :: [Var] -> [Var]
substituteExpZero (xs) | (((length xs) == 1) && ((snd $ head xs) == 0)) = [(' ', 1)]      -- && ((fst $ head xs) /= ' ')
                       | otherwise                                      = removeExpZero xs

-- (auxílio do fixExpZero) para quando a incógnita de expoente 0 não é a única do monómio
removeExpZero :: [Var] -> [Var]
removeExpZero [] = []
removeExpZero (x:xs) | snd x == 0   = removeExpZero xs
                     | otherwise    = x : removeExpZero xs

-- corrige todos os monómios de um polinómio que tenham um expoente 0 numa incógnita
fixExpZero:: Pol -> Pol
fixExpZero [] = []
fixExpZero (x:xs) = (fst x, substituteExpZero $ snd x) : fixExpZero xs

-- ordena alfabeticamente as incógnitas dentro de cada monómio do polinómio
sortVars :: Pol -> Pol
sortVars[] = []
sortVars (x:xs) = (fst x, sort(snd x)) : sortVars xs

-- ordena os monómios de um polinómio por ordem alfabética de incógnitas, como critério secundário usa os expoentes
sortPol [] = []
sortPol p = sortOn(snd) p

-- (auxílio do addMons) descobre se o polinómio tem algum monómio x que possa ser somado ao monómio n
findX :: Mon -> Pol -> Bool
findX _ [] = False
findX n (x:xs)
  | snd n == snd x = True
  | otherwise      = findX n xs

-- (auxílio do addMons) soma os quantificadores de 2 monómios e retorna 1 só
addSome :: Mon -> Mon -> Mon
addSome x y = (fst x + fst y, snd y)

-- soma os todos os monómios possíveis de um polinómio
addMons :: Pol -> Pol
addMons[] = []
addMons (x:xs) | findX x (xs) = addMons $ (addSome x (head xs)) : tail xs
               | otherwise    = x : addMons xs

-- normaliza o polinómio
normalize :: Pol -> Pol
normalize p = removeZero $ addMons $ sortPol $ sortVars $ fixExpZero p

-- soma dois polinómios
addPols :: Pol -> Pol -> Pol
addPols x y = normalize(x ++ y)


-----------------------------------------------------------MULTIPLICAÇÃO-------------------------------------------------------
-- (auxílio do multMons) descobre se o monómio tem algum var x que possa ser somado ao var n
findVar :: Var -> [Var] -> Bool
findVar _ [] = False
findVar n (x:xs)
  | fst n == fst x = True
  | otherwise      = findVar n xs

-- (auxílio do multMons) soma expoentes de 2 vars
addExp :: Var -> Var -> Var
addExp x y = (fst y, snd x + snd y)

-- (auxílio do multMons) multiplica vars compatíveis de um monómio
multVars :: [Var] -> [Var]
multVars[] = []
multVars (x:xs) | findVar x (xs) = multVars $ (addExp x (head xs)) : tail xs
                | otherwise      = x : multVars xs

-- multiplica monómios
multMons :: Mon -> Mon-> Mon
multMons x y = (fst x * fst y, multVars $ sort(snd x ++ snd y))

-- (auxílio do multPols) multiplica recursivamente 2 polinómios
multi :: Pol -> Pol -> Pol
multi [] _ = []
multi (x:xs) ys = [multMons x y| y <- ys] ++ multi xs ys

-- normaliza e multiplica 2 polinónios
multPols :: Pol -> Pol -> Pol
multPols x y = normalize $ multi (normalize x) (normalize y)


-----------------------------------------------------------DERIVAÇÃO---------------------------------------------------------
-- (auxílio do derivatePol) determina se existe na lista existe um var com incógnita n
findN :: Char -> [Var] -> Bool
findN _ [] = False
findN n (x:xs)
  | n == fst x = True
  | otherwise  = findN n xs

-- (auxílio do derivatePol) retorna a lista de vars sem o var de incógnita n
removeN :: Char -> [Var] -> [Var]
removeN _ [] = []
removeN n (x:xs)   | n == fst (x) = removeN n xs
                   | otherwise    = x : removeN n xs

-- (auxílio do derivatePol) retorna o expoente do var da lista que tem a incógnita n (já sabemos que ele existe algures na lista)
getExpN :: Char -> [Var] -> Int
getExpN _ [] = -69
getExpN n (x:xs)
  | n == fst x = snd x
  | otherwise  = getExpN n xs

-- (auxílio do derivatePol) deriva um monómio por uma incógnita
derivateMon :: Char -> Mon -> Mon
derivateMon n x | not (findN n $ snd x)                     = (0, [(' ', 1)])
                | (findN n $ snd x) && length (snd x) == 1  = (fst x * (snd $ head $ snd x), [(n, (snd $ head $ snd x) - 1)])
                | (findN n $ snd x) && length (snd x) > 1   = (fst x * (getExpN n $ snd x), sort $ (n, (getExpN n $ snd x) - 1) : (removeN n $ snd x))
--              | (length (snd x) == 1 && (fst $ head $ snd x) == n && (snd $ head $ snd x) == 1) = (fst x, [(' ', 1)])
--              | otherwise = x

-- deriva um polinómio por uma incógnita
derivatePol :: Char -> Pol -> Pol
derivatePol n xs = normalize [derivateMon n x | x <- (normalize xs)]

-------------------------------------------------------------------------------------------------------------------------
-- @desc
-- @example
parse :: Mon -> String
parse (y, x)
  | y == 0 = "0"
  | length x > 1 && y == 1 = tail (parse' x)
  | length x > 1 = show y ++ parse' x
  | fst (head x) == ' ' && y == 0 = "0"
  | fst (head x) == ' ' = show y
  | y < 0 && snd (head x) == 1 = " - " ++ tail (show y) ++ "" ++ [fst (head x)]
  | snd (head x) == 1 && y == 1 = [fst (head x)]
  | snd (head x) == 1 = show y ++ "" ++ [fst (head x)]
  | snd (head x) == 1 = show y ++ "" ++ [fst (head x)]
  | y == -1 = " -" ++ [fst (head x)] ++ "^" ++ show (snd (head x))
  | y == 1 = [fst (head x)] ++ "^" ++ show (snd (head x))
  | y < 0 && snd (head x) > 1 = show y ++ "" ++ [fst (head x)] ++ "^" ++ show (snd (head x))
  | otherwise = show y ++ "" ++ [fst (head x)] ++ "^" ++ show (snd (head x))



-- parse every variable multiplying each other
parse' :: Vars -> String
parse' [] = []
parse' (x:xs) = if snd x == 1 then "" ++ [fst x] ++ parse' xs else "*" ++ [fst x] ++ "^" ++ show (snd x) ++ parse' xs

-- @desc
-- @example
parseSentence :: Pol -> String
parseSentence l =  parse (head l) ++ parseSentence' (tail l)


-- @desc
-- @example
parseSentence' :: Pol -> String
parseSentence' [] = []
parseSentence' (x : xs)
  | length (snd x) > 1 && fst x < 0 = " - " ++ tail (show(snd x)) ++ parse' (snd x) ++ parseSentence' xs
  | length (snd x) > 1 = " + " ++ show (snd x) ++ parse' (snd x) ++ parseSentence' xs
  | fst x == 0 = parseSentence' xs
  | fst x < 0 = parse x ++ parseSentence' xs
  | otherwise = " + " ++ parse x ++ parseSentence' xs


---------------------------------------VALORES ÚTEIS PARA TESTAGEM RÁPIDA NO MOMENTO------------------------------------------
-- valores aleatórios usados em testes
v1,v2,v3,v4,v5,v6,v7 :: Var
m1,m2,m3,m4,m5,m6,m7,m8 :: Mon
p1,p2,p3 :: Pol

v1 = ('a', 0)
v2 = ('a', 1)
v3 = ('a', 3)
v4 = ('b', 4)
v5 = ('b', 2)
v6 = ('b', 1)
v7 = ('c', 1)
m1 = (3, sort[v1])
m2 = (2, sort[v2])
m3 = (4, sort[v3])
m4 = (1, sort[v4])
m5 = (2, [v6, v2, v7]) -- 2 a^2 b^4 c
m6 = (3, sort[v7, v3, v5]) -- 3 a^3 b^2 c
m7 = (3, [v7])
m8 = (2, [v5, v3])


p1 = [m1, m2, m3, m4]
p2 = [m1, m3]    -- 3a + 4a^3
p3 = [m7, m8]    -- 3c + 2(b^2a^3)
p4 = [m5, m1]
p5 = [m3]


normalize_mon = normalize p1
multa = multMons m5 m6
multPolsa = multPols p1 (multPols p2 p3)

varssss = sortVars p3


-- Retirar espaços da input;
-- Dividir a input em monómios (sempre delimitados por +/- ou sozinhos)
-- Processar cada monómio

-- Logo:


removeWhiteSpace :: String -> String
removeWhiteSpace = filter (not . isSpace)

-- Processar monómios:
checkEmptyList:: String -> [(Char, Int)]
checkEmptyList "" = [(' ',1)]
checkEmptyList x = list 
  where
    list = readVarList x

readVarList :: String -> [(Char, Int)]
readVarList "" = []
readVarList (x:'^':xs) = (x, read $ takeWhile isDigit xs :: Int) : readVarList (dropWhile isDigit xs)
readVarList (x:xs) = (x, 1) : readVarList xs

parseCoef [] = 1
parseCoef ('-':xs) = -parseCoef xs
parseCoef ('+':xs) = parseCoef xs
parseCoef x = read x :: Int

isSign '-' = True
isSign '+' = True
isSign _ = False

readMonomial :: String -> (Int, [(Char, Int)])
readMonomial s = (coef, varList) 
    where
        coefText = takeWhile (\c -> isDigit c || isSign c) s
        coef = parseCoef coefText
        varListText = drop (length coefText) s
        varList = checkEmptyList varListText

readPolynomial :: String -> [(Int, [(Char, Int)])]
readPolynomial "" = []
readPolynomial s@(x:xs) = readMonomial l : readPolynomial r
    where
        l = x:takeWhile (not . isSign) xs
        r = drop (length l) s
