# Programming Languages and Paradigms Practice No.1 Functional Programming

**Students:** 

Miguel Martinez Gallego

Luis Fernando Bernal Ramirez

Jhon David Santamaria Cossio


---

## 1. Useful functions

### 1.1 Remove data outside an interval.

We're asked to, given a list of numbers, remove the data from it that falls outside a given interval.

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
4. Write `remData ['list'] 'lower limit interval' higher limit interval'`, then press enter.
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


