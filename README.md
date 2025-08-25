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

The 'orderList' function works in a recursive way. It first takes the first element of the list and separates it from the rest. It repeatis this same process until it gets an empty list. When there are no more elements, it starts going back and inserting the values again, but in order.

To achieve that order, it uses the 'InsertList' function, which recieves a number and an ordered list. This function compares the number with the elements of the list: if it is greater than or equal to the first, it inserts it there; if it is less, it continues to compare until it positions it in the right position.

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



