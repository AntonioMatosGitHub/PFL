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
               | otherwise   = x : addMons xs

-- soma dois polinómios
addPols :: Pol -> Pol -> Pol
addPols x y = addMons(x ++ y)

-- normaliza polinómio
normalize :: Pol -> Pol
normalize p = removeZero $ addMons $ sortPol p


-- valores aleatórios usados em testes
v1,v2,v3,v4 :: Var
m1,m2,m3 :: Mon

p1 :: Pol
v1 = ('a', 1)
v2 = ('a', 2)
v3 = ('a', 3)
v4 = ('a', 1)
m1 = (3, sort[v1])
m2 = (2, sort[v2])
m3 = (4, sort[v3])
m4 = (1, sort[v4])

p1 = [m1, m2, m3, m4]

normalize_mon = removeZero $ addMons $ sortPol p1
