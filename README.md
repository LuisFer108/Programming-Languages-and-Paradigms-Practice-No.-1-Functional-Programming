# Programming Languages and Paradigms Practice No.1 Functional Programming

**Students:** 

Miguel Martinez Gallego

Luis Fernando Bernal Ramirez

Jhon Santamaria Cossio


---

## 1. Useful functions

### 1.Remove data outside an interval.
We're asked to, given a list of numbers, remove the data from it that falls outside a given interval.

**Solution**
`
remData :: [Int] -> Int -> Int -> [Int]
remData [] _ _ = [] -- case: empty list
remData (x:xs) low high
    | x >= low && x <= high = x : remData xs low high  -- keeps the element
    | otherwise = remData xs low high      -- skips it
`

**Explanation**
This function recieves a list of type Int, and two values(the low and high limits of the interval) to finally return a list of type Int.

It works by checking if 'x' (the first element of the list) is greater than the low limit and is smaller than the high limit, if it is, it's kept in the list and we add to it the recursion of the function with the rest of the list.
In case 'x' doesn't meet these conditions, it's skipped and it just applies recursion of the function with the rest of the list.
In case the list is empty, it just returns an empty list.

**Problems during the development**



## How to Run
1. Save `booleanos.hs` in a folder.
2. Open a terminal in that folder.
3. Write `ghci booleanos.hs`, then press enter.
4. Write `test`, then press enter.
5. Now you should see the program running.

---

## Solution Explanation

We already have the definition of a Church boolean, where a boolean is a function:
    true = \x y -> x (always picks the first value)
    false = \x y -> y (always picks the second value)

With that in mind, we can procede with the implementation of the logical operators using these definitions:

### ifThenElse
We need to return the first value if the boolean is true, and the second value if the boolean is false,
you can see that those are just the definitions of each boolean, so we just need to give the boolean the 
two values:

    ifThenElse :: (a -> a -> a) -> a -> a -> a --it receives one boolean of type a -> a -> a and two values of type a, and returns a value of type a--
    ifThenElse = \p x y -> p x y --if p is true, it returns x(first value), if p it is false, it returns y(second value)--

    
### churchAnd
We need to return true only if both booleans are true. We also know that if the first boolean `p` is true, the 
result is going to be the value of the second boolean `q`. So, we can say that:
    
    churchAnd :: (a -> a -> a) -> (a -> a -> a) -> a -> a -> a
    churchAnd = \p q -> p q false   --if `p` is true, it returns `q`(because that is the definition of true), and if `p` is false, it returns false--

This makes logical sense and it's correct in lambda calculus, nonetheles, in haskell this has a problem with 
the types, because you cannot use `q` or `false`(functions of the type a -> a -> a) as a parameter for `p`(a
function of the type a -> a -> a) because `p` only recieves parameters of the type a.

So we need to do this instead:

    churchAnd :: (a -> a -> a) -> (a -> a -> a) -> a -> a -> a
    churchAnd = \p q -> \x y -> p (q x y) y --When `p` is true, it returns `q x y` which is basically the value of `q`, and when `p`is false, it returns `y`, which represents false--

Here we use `x` and `y` as a kind of placeholder for true and false, so we can use them as arguments for `p` and 
`q`, and now the true is represented by `x`(as the first value) and the false is represented by `y`(as the second
value).


### churchOr
We need to return false only if both booleans are false. We also know that if the first boolean `p` is false,
then the result must be the value of the second boolean `q`. And if the first boolean `p` is true, then the 
result must be true regardless of the other boolean.
Based on all of this, we can say that:

    churchOr :: (a -> a -> a) -> (a -> a -> a) -> a -> a -> a
    churchOr = \p q -> p true q --When `p` is false, it returns `q`(the second parameter), and when `p` is true, it returns true(the first parameter)--

Again, this syntax is not correct given the types defined for the functions, so we do the same as before:

    churchOr :: (a -> a -> a) -> (a -> a -> a) -> a -> a -> a
    churchOr = \p q -> \x y -> p x (q x y)


### churchNot
We need to return false when the boolean `p` is true, and return true when the boolean `p`is false.
So we can theoretically just do this:

    churchNot :: (a -> a -> a) -> a -> a -> a
    churchNot = \p -> p false true

But again, because of the types defined, this causes problems, so we do the same as in every other logical operator:

    churchNot :: (a -> a -> a) -> a -> a -> a
    churchNot = \p x y -> p y x 

Here we use `x` and `y` as replacements for true and false respectively.

---

## References sources
-ChatGPT was used for research on Church logical operators and logic behind 'And' operator.

-Gemini and Copilot were used for troubleshooting, specifically the error we had with the types.

