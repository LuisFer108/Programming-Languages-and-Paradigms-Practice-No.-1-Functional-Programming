remData :: [Int] -> Int -> Int -> [Int]
remData [] _ _ = []
remData (x:xs) low high
    | x >= low && x <= high = x : remData xs low high  -- keep the element
    | otherwise             = remData xs low high      -- skip it


--It inserts a number into an ordered list mantaining the orden.
insertList :: Float -> [Float] -> [Float]
insertList x [] = [x] 
insertList x (y:ys)
  | x >= y = x : y : ys
  |otherwise = y : insertList x ys

--Separates each value of a given list and sends it to the orderlist function with a recursion of the remaining list.
orderList :: [Float] -> [Float]
orderList [] = []
orderList (x:xs) = insertList x (orderList xs)





--Calculates the factorial of a number
--It recieves an Integer 'n' and returns an Integer of the factorial of that number
factorial :: Integer -> Integer
factorial 0 = 1
factorial n = n * factorial(n-1)

--Calculates a term of the Taylor series eˣ
--It recieves the number 'x' to which eˣ is to be calculated and the index of the series 'n'
euler :: Double -> Integer -> Double
euler x 0 = 1
euler x n = (x^n)/(fromIntegral(factorial n))

--It calculates the sum of several terms of the series, giving an aproximation of eˣ
--It recieves the 'x' number to which eˣ is to be calculated and the 'n' amount of terms of the series thah are going to be summed up
eulerSumatoria :: Double -> Integer -> Double
eulerSumatoria x 0 = euler x 0
eulerSumatoria x n = euler x n + eulerSumatoria x (n-1)

--Function that returns the absolute value of a rational number
vabs :: Double -> Double
vabs x
  | x >= 0 = x
  | otherwise = -x

--Calculates the percentual error
--It recieves two doubles 'x'(the result we got) and 'y'(the expected value) and returns the percentual error of the value we got.
percentualError :: Double -> Double -> Double 
percentualError 0 0 = 0
percentualError x y = ((vabs (x - y)) / y) * 100

--It proximates the result of cosine for a certain value
--It recieves a double 'x'(The value of which we want to calculate cos) and an Integer 'n'(The degree of precition we want the approximation) and returns an aproximation of the result of cos for x.
coseno :: Double -> Integer -> Double
coseno x 0 = 0 --Stop condition
coseno x n = ((-1) ^ (n-1)) * (x ** fromIntegral (2*(n-1))) / 
  fromIntegral (factorial (2*(n-1))) + coseno x (n-1)



--Function that returns the power of a rational number. 
--Double (x) = Base, Int (n) = Exponent
expo :: Double -> Int -> Double
expo _ 0 = 1
expo x n = x * expo x (n-1) 

--Function that adds all the terms of a list. 
--It works the same as the built-in "sum" function
suma :: [Double] -> Double
suma [] = 0
suma (x:xs) = x + suma xs 

--Function that calculates the series by replicating the proposed summation. 
--Double (x) = x value of the series, Int (n) = N value of the summation
serie :: Double -> Int -> Double
serie x n = suma [((expo (-1) (i+1)) / fromIntegral i) * (expo x i) | i <- [1..n]]

--Function that reduces the argument of the logarithm to the interval (1,2].  
--If it is > 2, it is divided by 2 and 1 is added to the counter.  
--If it is between 0 and 1, it is multiplied by 2 and 1 is subtracted from the counter.
redarg :: Double -> Int -> (Double, Int)
redarg y c
  | y >= 1 && y <= 2 = (y,c)
  | y > 2 = redarg (y/2) (c+1)
  | y < 1 = redarg (y*2) (c-1)

--Function that returns the natural logarithm of a rational number. 
--Double (x) = Argument of the logarithm, Int (n) = Precision degree of the series
ln :: Double -> Int -> Double
ln z n =
  let (y,c) = redarg z 0
      x = y-1
      base = serie x n
      ln2 = serie 1 n
  in base + fromIntegral c * ln2



-- Function that counts the number of elements in a Double array.
arrSize :: [Double] -> Int
arrSize [] = 0
arrSize (_:xs) = 1 + arrSize xs

-- Summation of the formula.
dctSum :: [Double] -> Int -> Int -> Int -> Double
dctSum [] _ _ _ = 0
dctSum (x:xs) i k n =
  x * cosAux i k n + dctSum xs (i+1) k n

-- Inner cosine in the formula.
cosAux :: Int -> Int -> Int -> Double
cosAux i k n =
  cos (((fromIntegral i + 0.5) * pi * fromIntegral k) / fromIntegral n)

-- a(k) function from the formula (normalization factor).
a :: Int -> Int -> Double
a k n
  | k == 0    = sqrt (1 / fromIntegral n)
  | otherwise = sqrt (2 / fromIntegral n)

-- Function that builds the resulting list
dctAux :: [Double] -> Int -> Int -> [Double]
dctAux xs n k
  | k == n    = []
  | otherwise = a k n * dctSum xs 0 k n : dctAux xs n (k+1)

-- Main DCT function
dct :: [Double] -> [Double]
dct xs =
  let n = arrSize xs
  in dctAux xs n 0



--Test functions (presets of some examples)
testRemData :: IO ()
testRemData = do
  putStrLn "Input:"
  putStrLn "[0..10] 2 7" 
  putStrLn "Output:"
  print(remData [0..10] 2 7)

  putStrLn "Input:"
  putStrLn "[1,25,5,-4] 1 5"
  putStrLn "Output:"
  print(remData [1,25,4,-4] 1 5)

  putStrLn "Input:"
  putStrLn "[4,12,13,18,50,2] 10 20"
  putStrLn "Output:"
  print(remData [4,12,13,18,50,2] 10 20)

testCos :: IO ()
testCos = do

    putStrLn  "coseno 1.5 6:"
    print(coseno 1.5 6)
    putStrLn "cos 1.5:" 
    print(cos 1.5)
    putStrLn "Percentual error:"
    print (percentualError (coseno 1.5 6) (cos 1.5))

    putStrLn "------------------"
    putStrLn  "coseno 1.5 10:"
    print(coseno 1.5 10)
    putStrLn "cos 1.5:" 
    print(cos 1.5)
    putStrLn "Percentual error:"
    print (percentualError (coseno 1.5 10) (cos 1.5))

    putStrLn "------------------"
    putStrLn  "coseno 1.5 20:"
    print(coseno 1.5 20)
    putStrLn "cos 1.5:" 
    print(cos 1.5)
    putStrLn "Percentual error:"
    print (percentualError (coseno 1.5 20) (cos 1.5))

testOrderList :: IO ()
testOrderList = do
  putStrLn "Input:"
  putStrLn "[1, 25, 5, -4]" 
  putStrLn "Output:"
  print(orderList [1,25,5,-4])

  putStrLn "Input:"
  putStrLn "[32, 21, 17, 6, 5, 70]"
  putStrLn "Output:"
  print(orderList [32, 21, 17, 6, 5, 70])

  putStrLn "Input:"
  putStrLn "[40, 12, 13, 18, 50, 20]"
  putStrLn "Output:"
  print(orderList [40, 12, 13, 18, 50, 20])

testExp :: IO ()
testExp = do

    putStrLn  "eulerSumatoria 2 10:"
    print(eulerSumatoria 2 10)
    putStrLn "exp 2:" 
    print(exp 2)
    putStrLn "Percentual error:"
    print (percentualError (eulerSumatoria 2 10) (exp 2))

    putStrLn "------------------"
    putStrLn  "eulerSumatoria 2 20:"
    print(eulerSumatoria 2 10)
    putStrLn "exp 2:" 
    print(exp 2)
    putStrLn "Percentual error:"
    print (percentualError (eulerSumatoria 2 20) (exp 2))

    putStrLn "------------------"
    putStrLn  "eulerSumatoria 2 50:"
    print(eulerSumatoria 2 50)
    putStrLn "exp 2:" 
    print(exp 2)
    putStrLn "Percentual error:"
    print (percentualError (eulerSumatoria 2 50) (exp 2))
  
testLn :: IO ()
testLn = do
    putStrLn  "ln 7.23 20:"
    print(ln 7.23 20)
    putStrLn "log 7.23:" 
    print(log 7.23)
    putStrLn "Percentual error:"
    print (percentualError (ln 7.23 20) (log 7.23))

    putStrLn "------------------"
    putStrLn  "ln 7.23 100:"
    print(ln 7.23 100)
    putStrLn "log 7.23:" 
    print(log 7.23)
    putStrLn "Percentual error:"
    print (percentualError (ln 7.23 100) (log 7.23))

    putStrLn "------------------"
    putStrLn  "ln 7.23 400:"
    print(ln 7.23 400)
    putStrLn "log 7.23:" 
    print(log 7.23)
    putStrLn "Percentual error:"
    print (percentualError (ln 7.23 400) (log 7.23))

testDCT :: IO ()
testDCT = do
    putStrLn  "dct [1..10]:"
    print(dct [1..10])
    putStrLn "------------------"
    putStrLn  "dct [10..20]:"
    print(dct [10..20])