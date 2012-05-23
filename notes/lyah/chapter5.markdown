# 5 Recursion

## Introduction to recursion

* Function is defined in terms of itself
  * Eg Fibonacci numbers: F(n) = F(n-1) + F(n-2), F(1) = 1, F(0) = 0

* Need an **edge condition** or **base case** which is where the recursion stops

* Recursion is a hallmark of functional programming
  * Program by declaring what it *is*, not *how* to get it

## Some examples of recursion

### maximum

* What is the maximum of a list with only one element? That element is the max

* What if there are more elements in the list?
  * The maximum is the max of the head and the max of the tail

```haskell
  maximum' :: (Ord a) => [a] -> a
  maximum' [] = error "empty list"
  maximum' [x] = x
  maximum' (x:xs) = max x (maximum' xs)
```

* Example trace of `maximum' [9,2,4]

```
  maximum' [9,2,4] = max 9 (maximum' [2, 4])
                   = max 9 (max 2 (maximum' [4]))
                   = max 9 (max 2 4)
                   = max 9 4
                   = 9
```

### quicksort

* This is the infamous Haskell quicksort example

```haskell
  quicksort :: (Ord a) => [a] -> [a]
  quicksort [] = []
  quicksort (x:xs) =
    let smallerSorted = quicksort [a | a <- xs, a <= x]
        biggerSorted  = quicksort [a | a <- xs, a > x]
    in smallerSorted ++ [x] ++ biggerSorted
```

* If you sort an empty list, you get an empty list (base case)

* Otherwise, take the first element as the pivot, and construct two other lists:
  * One (sorted) list with elements less than or equal to the pivot
  * One (sorted) list with elements greater than the pivot

* Do the sorting by recursively calling `quicksort`

* Then concatenate the lists in the correct order

## Recursion summary

* Basic pattern for recursion is to identify a base case

* Then get what you want by applying the function to an element, and the result of applying that same function to the rest of the elements

* The base case is usually where recursion would fail to work on it
  * Or consider the simplest (or smallest) possible case
  * For lists, it's usually the empty list
