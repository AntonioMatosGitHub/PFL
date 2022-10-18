import Data.List
import System.IO

-- par de uma incógnita e respetivo expoente
type Var = (Char, Int)   -- 1º elemento: incógnita
                         -- 2º elemento: expoente
-- monómio
type Mon = (Int, [Var])  -- 1º elemento: quantificador
                         -- 2º elemento: lista de incógnitas e respetivos expoentes
-- polinómio
type Pol = [Mon]


-- remove monómios de quantificador 0 de um polinómio
removeZero [] = []
removeZero (x:xs)  | 0 == fst (x) = removeZero xs
                   | otherwise = x : removeZero xs

-- ordena os monómios de um polinómio por ordem alfabética de incógnitas, como critério secundário usa os expoentes
sortPol [] = []
sortPol p = sortOn(head . snd) p

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

-- normaliza polinómio
normalize :: Pol -> Pol
normalize p = removeZero $ addMons $ sortPol p

-- soma dois polinómios
addPols :: Pol -> Pol -> Pol
addPols x y = normalize(x ++ y)

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

-- valores aleatórios usados em testes
v1,v2,v3,v4,v5,v6,v7 :: Var
m1,m2,m3 :: Mon
p1 :: Pol

v1 = ('a', 1)
v2 = ('a', 2)
v3 = ('a', 3)
v4 = ('a', 1)
v5 = ('b', 2)
v6 = ('b', 4)
v7 = ('c', 1)
m1 = (3, sort[v1])
m2 = (2, sort[v2])
m3 = (4, sort[v3])
m4 = (1, sort[v4])
m5 = (2, sort[v6, v2, v7]) -- 2 a^2 b^4 c
m6 = (3, sort[v7, v3, v5]) -- 3 a^3 b^2 c
                           -- 6 a^5 b^6 c^2

p1 = [m1, m2, m3, m4]

normalize_mon = normalize p1
multa = multMons m5 m6

--multPol :: Pol -> Pol -> Pol
--multPol x y = normalize $
