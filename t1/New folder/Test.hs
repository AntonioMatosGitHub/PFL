import Norm
import Data.List
import System.IO
import Norm (parseSentence, removeZero)

-- normalize p = removeZero $ addMons $ sortPol $ sortVars $ fixExpZero p  

v1 = ('a', 0) --1
v2 = ('a', 1) --a
v3 = ('a', 3) --a^3
v4 = ('b', 4) --b^4
v5 = ('b', 2) --b^2
v6 = ('b', 1) --b
v7 = ('c', 1) --c
m1 = (3, [v1]) --3
m2 = (2, [v2]) --2a
m3 = (4, [v3]) --4a^3
m4 = (1, [v4]) --b^4
m5 = (2, [v6, v2, v7]) -- 2 a^2 b^4 c
m6 = (3, [v7, v3, v5]) -- 3 a^3 b^2 c
m7 = (3, [v7]) --3c
m8 = (2, [v5, v3]) --2 b^2 a^3
m9=  (0, [v5, v3]) --0
m10=  (6, [v2]) --6a


p1 = [m1, m2,m4,m10] --3+2a+b^4
p2 = [m1, m3]    -- 3a + 4a^3
p3 = [m7, m8]    -- 3c + 2(b^2a^3)
p4 = [m5, m1]    -- 2 a^2 b^4 c + 3
p5 = [m9,m2] --
p7 = [m1,m1, m2,m4,m10,m9,m2]
p8 = [m1,m1, m2,m4,m10,m9,m2,m10,m2,m4]

p6 = parseSentence $ normalize p8

gui :: IO ()
gui = do
  putStr "Insira o valor (1,2,3 ou 4) da operação quer efectuar:  \n 1: Normalizar polinomios \n 2: Somar polinomios \n 3: Multiplicar polinomios \n 4: Derivar polinomios\n"
  option <- getLine
  if option == "1" then 
    do putStr "Escreva o polinomio que quer simplificar:\n"
       poliStr <- getLine
       let poli = normalize $ readPolynomial $ removeWhiteSpace poliStr
       putStr ( (parseSentence $ poli) ++ "\n")
  else if option == "2" then 
    do putStr "Escreva 1º polinomio da soma:\n"
       poliStr <- getLine
       putStr "Escreva 2º polinomio da soma:\n"
       poliStr2 <- getLine
       let poli = readPolynomial $ removeWhiteSpace poliStr
       let poli2 = readPolynomial $ removeWhiteSpace poliStr2
       putStr ( (parseSentence $ addPols poli poli2) ++ "\n")
  else if option == "3" then 
    do putStr "Escreva 1º polinomio da multiplicaçao:\n"
       poliStr <- getLine
       putStr "Escreva 2º polinomio da multiplicaçao:\n"
       poliStr2 <- getLine
       let poli = readPolynomial $ removeWhiteSpace poliStr
       let poli2 = readPolynomial $ removeWhiteSpace poliStr2
       putStr ( (parseSentence $ multPols poli poli2) ++ "\n")
  else 
    do putStr "Escreva polinomio a derivar:\n"
       poliStr <- getLine
       putStr "Escreva escreva a que ordem quer derivar:\n"
       ordem <- getChar
       let poli = readPolynomial $ removeWhiteSpace poliStr
       putStr ( (parseSentence $ derivatePol ordem poli) ++ "\n")


main = do
  print ("polinomio com zeros ", (parseSentence . removeZero ) (p5) ==("2a"))
  print ("polinomio com somas internas ", (parseSentence . normalize  ) (p1) ==("3 + 8a + b^4"))
  print ("polinomio desordenado", (parseSentence . sortPol   ) (p3) ==("2*b^2*a^3 + 3c"))
  print ("variavais desordenado", (parseSentence . normalize ) (p3) ==("2*a^3*b^2 + 3c"))
  print ("converter variavel com expoente 0 em 1", (parseSentence . fixExpZero  ) (p1) ==("3 + 2a + b^4 + 6a"))
  print ("nomalizar polinomio grade", (parseSentence . normalize ) (p7) ==("6 + 10a + b^4"))
  print ("nomalizar polinomio grade", (parseSentence . normalize ) (p8) ==("6 + 18a + 2b^4"))
  print ("somar 2 polinomios", (parseSentence $ addPols p2 p1) ==("6 + 8a + 4a^3 + b^4"))
  print ("multiplicar 2 polinomios", (parseSentence $ multPols p2 p1  ) ==("2a"))
  print ("derivar", (parseSentence $ derivatePol 'a' p5) ==("2"))

  print $ "readVarList"
  print $ readVarList "x"
  print $ readVarList "xy"
  print $ readVarList "x^2"
  print $ readVarList "xy^2"
  print $ readVarList "x^2y"
  print $ readVarList "x^2y^2"

  print $ "parseCoef"
  print $ parseCoef "-" 
  print $ parseCoef "+" 
  print $ parseCoef "-1" 
  print $ parseCoef "+1" 
  print $ parseCoef "1"

  print $ "readMonomial"
  print $ readMonomial "x"
  print $ readMonomial "-x"
  print $ readMonomial "+x"
  print $ readMonomial "xy"
  print $ readMonomial "-xy"
  print $ readMonomial "+xy"
  print $ readMonomial "x^2y"
  print $ readMonomial "-x^2y"
  print $ readMonomial "x^2y"
  print $ readMonomial "-x^2y"
  print $ readMonomial "+x^2y"
  print $ readMonomial "x^2y^2"
  print $ readMonomial "-x^2y^2"
  print $ readMonomial "+x^2y^2"
  
  print $ "readPolynomial"
  print $ readPolynomial "x"
  print $ readPolynomial "-x"
  print $ readPolynomial "+x"
  print $ readPolynomial "xy"
  print $ readPolynomial "-xy"
  print $ readPolynomial "+xy"
  print $ readPolynomial "x^2y"
  print $ readPolynomial "-x^2y"
  print $ readPolynomial "x^2y"
  print $ readPolynomial "-x^2y"
  print $ readPolynomial "+x^2y"
  print $ readPolynomial "x^2y^2"
  print $ readPolynomial "-x^2y^2"
  print $ readPolynomial "-2x^2y^3+2y-7z"

  