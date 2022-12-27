import Data.Char

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
        varList = readVarList varListText

readPolynomial :: String -> [(Int, [(Char, Int)])]
readPolynomial "" = []
readPolynomial s@(x:xs) = readMonomial l : readPolynomial r
    where
        l = x:takeWhile (not . isSign) xs
        r = drop (length l) s


main = do
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

