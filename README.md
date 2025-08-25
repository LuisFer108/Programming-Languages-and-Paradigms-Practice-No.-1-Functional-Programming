# Programming Languages and Paradigms Practice No.1 Functional Programming

**Students:** 

Miguel Martinez Gallego

Luis Fernando Bernal Ramirez

Jhon David Santamaria Cossio


---

## 1. Useful functions

### 1.1 Remove data outside an interval.

We're asked to, given a list of numbers, remove the data from it that falls outside a given interval and return it back.

#### Solution

```
remData :: [Int] -> Int -> Int -> [Int]
remData [] _ _ = [] -- case: empty list
remData (x:xs) low high
    | x >= low && x <= high = x : remData xs low high  -- keeps the element
    | otherwise = remData xs low high      -- skips it
```


#### Explanation

This function recieves a list of type Int, and two values(the low and high limits of the interval) to finally return a list of type Int.

It works by checking if 'x' (the first element of the list) is greater than the low limit and is smaller than the high limit, if it is, it's kept in the list and we add it to the recursion of the function with the rest of the list.

In case 'x' doesn't meet these conditions, it's skipped and it just applies recursion of the function with the rest of the list.

When the list is empty, it just adds an empty list and stops.

#### How to use
1. Save `practice1haskell.hs` in a folder.
2. Open a terminal in that folder.
3. Run `ghci practice1haskell.hs`.
4. Write `remData ['list'] 'lower limit interval' 'higher limit interval'`, then press enter.
5. Now you should see the list you entered without the data outside the interval you entered.
6. Alternatively you can run `testRemData` after step 3 for some preset examples.


#### Test results

You can run this tests by yourself in the program with the function `testRemData`

```
Input:
[0..10] 2 7
Output:
[2,3,4,5,6,7]

Input:
[1,25,5,-4] 1 5
Output:
[1,4]

Input:
[4,12,13,18,50,2] 10 20
Output:
[12,13,18]
```


---


### 1.2 Order a list of Floats in descendant order.

We're asked to, given a list of numbers, order it in descendant order and return it back.

#### Solution

```
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
```


#### Explanation

The `orderList` function works in a recursive way. It first takes the first element of the list and separates it from the rest. It repeatis this same process until it gets an empty list. When there are no more elements, it starts going back and inserting the values again, but in order.

To achieve that order, it uses the `insertList` function, which recieves a number and an ordered list. This function compares the number with the elements of the list: if it is greater than or equal to the first, it inserts it there; if it is less, it continues to compare until it positions it in the right position.

In this way, each time the list is reconstructed upon return from the recursion, it is formed in an orderly manner from largest to smallest.

#### Problems during development

- **Confusion with the recursive process**
  
    When analyzing the orderList function, there was confusion about whether the algorithm first emptied the entire list and then started “filling it” little by little.

    Solution: It was understood that the process indeed works that way: first, recursion brings us down to the empty list, and then the ordered list is reconstructed step by step by     inserting the elements in the correct position.

- **Doubts about the restriction on allowed functions**
  
    There was uncertainty about whether the use of | (guards) violated the rule of only using fundamental functions (+, -, *, /, mod, toEnum, fromEnum, fromIntegral, cos).

    Solution: It was clarified that | are not functions, but rather part of Haskell’s basic syntax (similar to if ... then ... else). Therefore, the code fully complies with the         restrictions of the exercise.

- **Error with the + operator instead of :**

    One of the mistakes I made when implementing the insertList function was trying to use the + operator to construct a list. I wrote something like:
  
    ```
    insertList x (y:ys)
      | x >= y    = x + y + ys
      | otherwise = y + insertList x ys
    ```
    The problem is that in Haskell the + operator is only used for adding numbers, not for constructing lists. What I actually needed was to place an element at the beginning of a       list, and for that the : operator (called cons) is used.

    The solution was to replace + with :, resulting in:
    ```
    insertList x (y:ys)
      | x >= y    = x : y : ys
      | otherwise = y : insertList x ys
    ```
    This way, the function correctly builds a new list in descending order.


#### How to use
1. Save `practice1haskell.hs` in a folder.
2. Open a terminal in that folder.
3. Run `ghci practice1haskell.hs`.
4. Write `orderList ['list']`, then press enter.
5. Now you should see the list you entered ordered from highest to lowest.
6. Alternatively you can run `testOrderList` after step 3 for some preset examples.


#### Test results

You can run this tests by yourself in the program with the function `testOrderList`

```
Input:
[1, 25, 5, -4]
Output:
[25.0,5.0,1.0,-4.0]

Input:
[32, 21, 17, 6, 5, 70]
Output:
[70.0,32.0,21.0,17.0,6.0,5.0]

Input:
[40, 12, 13, 18, 50, 20]
Output:
[50.0,40.0,20.0,18.0,13.0,12.0]
```


---


## 2. Numerical Methods

### 2.1 Exponential function

We're asked to implement the exponential function in Haskell using this formula:
<img width="532" height="107" alt="Screenshot 2025-08-24 at 8 53 04 PM" src="https://github.com/user-attachments/assets/36af3d04-e9e5-46cc-a677-1eae7fa30021" />

#### Solution

```
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
--It recieves the 'x' number to which eˣ is to be calculated and the 'n' amount of terms of the series that are going to be summed up
eulerSumatoria :: Double -> Integer -> Double
eulerSumatoria x 0 = euler x 0
eulerSumatoria x n = euler x (n-1) + eulerSumatoria x (n-1)

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
```


#### Explanation

The `factorial` function calculates the factorial of a number 'n' by multiplying it by the recursion of 'n-1' in the same function, until 'n' reaches 0, where it is set to be just 1 and stop.

The `euler` function calculates a term of the Taylor serie eˣ applying the formula provided before. It recieves the number 'x' to which eˣ is to be calculated and the index of the series 'n'.

The `eulerSumatoria` function calculates the sum of several terms 'n' of the series, giving an aproximation of eˣ. It recieves the number 'x' to which eˣ is to be calculated and the amount 'n' of terms that need to be calculated.

The `vabs` function returns the absolute value of a number. If a provided number 'x' is greater than or equal to 0, then it returns 'x', otherwise, it returns '-x'

The `percentualError` function returns the percentual error of an 'x' approximate value, compared to a 'y' real value.It's just the implementation of this formula:

<img width="566" height="118" alt="Screenshot 2025-08-24 at 9 39 56 PM" src="https://github.com/user-attachments/assets/12f4912a-debe-4942-a6c8-aa8bfb09b894" />


#### Problems during development
- I tried to define the base case of the euler function as:
    `euler 0 = 1`
    This was incorrect, since the euler function receives two arguments, and in this base case only one was being used.
  
    The solution was to change the base case to:
    `euler x 0 = 1`
  
- When attempting to divide x^n (of type Double) by factorial n (of type Integer), Haskell generated a type error because the / operator only accepts floating-point values, and    Double cannot be directly mixed with Integer.
 
    Solution: Use the function fromIntegral to convert the Integer returned by factorial into a Double. In this way, the division is carried out between values of the same type, and     the program compiles correctly.


#### How to use
1. Save `practice1haskell.hs` in a folder.
2. Open a terminal in that folder.
3. Run `ghci practice1haskell.hs`.
4. Write `eulerSumatoria 'number to which eˣ is to be calculated' 'amount of terms to be calculated'`, then press enter.
5. Now you should see the result of the exponential function applied to the number you provided.
6. Alternatively you can run `testExp` after step 3 for some preset examples.


#### Test results

You can run this tests by yourself in the program with the function `testExp`

```
eulerSumatoria 2 10:
7.388994708994708
exp 2:
7.38905609893065
Percentual error:
8.308224368687552e-4
------------------
eulerSumatoria 2 20:
7.388994708994708
exp 2:
7.38905609893065
Percentual error:
6.250497655727703e-13
------------------
eulerSumatoria 2 50:
7.389056098930649
exp 2:
7.38905609893065
Percentual error:
2.4040375598952705e-14
```


---


### 2.2 Cosine function

We're asked to implement the exponential function in Haskell using this formula:
<img width="234" height="105" alt="Screenshot 2025-08-24 at 9 52 37 PM" src="https://github.com/user-attachments/assets/4731e214-5aab-4569-acf4-7e82688bb7de" />

#### Solution

```
--It proximates the result of cosine for a certain value
--It recieves a double 'x'(The value of which we want to calculate cos) and an Integer 'n'(The degree of precition we want the approximation) and returns an aproximation of the result of cos for x.
coseno :: Double -> Integer -> Double
coseno x 0 = 0 --Stop condition
coseno x n = ((-1) ^ (n-1)) * (x ** fromIntegral (2*(n-1))) / fromIntegral (factorial (2*(n-1))) + coseno x (n-1)
```

#### Explanation

We use the `factorial` function defined before at 'Exponential function' to calculate the factorial.

The `coseno` function just applies the formula provided before, but the sum is applied backwards to make the recursion easier. Since we're going backwards in the sum, we start at 'n-1' instead of 'n=0'. For that reason, we need to stop when our function n equals 1, because it's the equivalent of the formula n when it equals 0 since our 'n' is really 'n-1'.


#### Problems during development
- **Problems with the order of operation**
  I tried to do this `-1 ^ (n-1)`. Which was the reason the function was giving me a different result than it should have. Because Haskell interprets that as `-(1 ^ (n-1))`

  The solution was just to put a parenthesis so there wasn't any ambiguity: `(-1) ^ (n-1)`.

- **Type mis-matching problems**
  Since I was using a variety of types I had trouble converting them correctly to whichever type was needed for the operations. My main problem was with the `/` operator, since it     only works with fractional types and I was trying to use it to divide by an Integer.

  The solution was to use `fromIntegral` to convert the Integer to a fractional type.


#### How to use
1. Save `practice1haskell.hs` in a folder.
2. Open a terminal in that folder.
3. Run `ghci practice1haskell.hs`.
4. Write `coseno 'number to which apply the cosine function' 'amount of terms to be calculated'`, then press enter.
5. Now you should see the result of the cosine function applied to the number you provided.
6. Alternatively you can run `testCos` after step 3 for some preset examples.


#### Test results

You can run this tests by yourself in the program with the function `testCos`

```
coseno 1.5 6:
7.073693411690848e-2
cos 1.5:
7.07372016677029e-2
Percentual error:
3.782320873803493e-4
------------------
coseno 1.5 10:
7.073720166770155e-2
cos 1.5:
7.07372016677029e-2
Percentual error:
1.9226420795590705e-12
------------------
coseno 1.5 20:
7.07372016677029e-2
cos 1.5:
7.07372016677029e-2
Percentual error:
0.0
``
  

  
