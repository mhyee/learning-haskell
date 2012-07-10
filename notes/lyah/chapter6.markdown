# 6 Higher Order Functions

* **Note:** This section is where things start getting more difficult. Further sections depend on fully understanding this material!

* **Higher order functions** are another characteristic of functional programming

* **Higher order functions** are functions that can take functions as parameters, or return functions as return values (or both)

## Curried functions

* Functions in Haskell take only one parameter
  * To accept multiple parameters, Haskell uses **currying**
  * For convenience and simplicity, we say that functions can take multiple parameters. For this (sub)section only, we'll be pedantic, to explore how it actually works

* Consider `max` as an example
  * `max 4 5` creates a function that takes a single parameter, and returns `4` or that parameter
  * Then we call that function with `5`
  * So `max 4 5` is equivalent to `(max 4) 5`
    * `max 4` returns a function that we call with `5`

* Remember that spaces are used for function application

* Also recall the type of `max` is `max :: (Ord a) => a -> a -> a`
  * Before, we said that the last `a` is the return type, and that everything before the last `->` are the parameters
  * With currying, this makes more sense now
  * We can rewrite the type as `max :: (Ord a) => a -> (a -> a)`
    * `max` takes an `a`, and returns [a function that takes an `a` and returns an `a`]

* If we call a function with too few parameters, we get a **partially applied** function
  * This function takes as many parameters as we left out
  * It can be useful to pass partially applied functions around

### Some examples of partially applied functions

* Consider the following example:

```haskell
  multThree :: (Num a) => a -> a -> a -> a
  multThree x y z = x * y * z
```

* Note that `multThree 3 5 9` is equivalent to `((multThree 3) 5) 9`
  * Note that we could write the type as `multThree :: (Num a) => a -> (a -> (a -> a))`
  * Observe how `multThree 3` means we call `multThree` with `3`, and it returns a function, which we call with `5`, and that returns another function, which we call with `9`

* We can create partially applied functions
  * `multTwoWithNine = multThree 9` and `multWithEighteen = multTwoWithNine 2`
  * `multTwoWithNine 2 3` returns `54` and `multWithEighteen 10` returns `180`

* Consider a function that compares numbers to `100` and returns an Ordering (eg `GT`, `LT`, or `EQ`)

```haskell
  compareWithHundred :: (Num a, Ord a) => a -> Ordering
  compareWithHundred x = compare 100 x
```

* Note how `x` is in both the definition and the body
  * What does `compare 100` return?
  * It returns a function that takes a number and compares it to `100`
  * This is exactly what we wanted

* So we can rewrite our function

```haskell
  compareWithHundred :: (Num a, Ord a) => a -> Ordering
  compareWithHundred = compare 100
```

* **Note:** It seems to be common practice to rewrite functions this way, for brevity
  * This can be confusing at first, but it becomes automatic with practice

* We can partially apply infix functions with **sections**
  * **Sectioning** is to supply a parameter to one side of the function, and surround with parentheses

```haskell
  divideByTen :: (Floating a) => a -> a
  divideByTen = (/10)
```

* Note that `divideByTen 200` is now equivalent to `200 / 10`, which is equivalent to `(/10) 200`

* **Note:** There is a special case with subtraction (the `-` operator)
  * `(-4)` is *negative 4*
  * `(subtract 3)` is *a function that subtracts 4 from the given parameter*

* **Note:** Partially applied functions (eg `multThree 3 4`) cannot be printed out in GHCI
  * This is because functions aren't instances of the `Show` typeclass
  * There is no method for printing a function out

## More examples of higher order functions

### applyTwice

* Consider a function that takes a function and a parameter, and applies the function twice to the parameter

```haskell
  applyTwice :: (a -> a) -> a -> a
  applyTwice f x = f (f x)
```

* Note that ``->`` is right-associative, so we need to explicitly write out the parentheses in `(a -> a) -> a -> a`
  * That first parameter is a function that takes a type and returns that same type
  * The function also takes a parameter of that type, and returns a value of that type

* `applyTwice (+3) 10` returns `16`
  * Note that `(+3)` is a partially applied function that takes one parameter

### zipWith

* This is a standard library function that takes a function and two lists
  * It joins the two lists together with that function, to return a third list

```haskell
  zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
  zipWith' _ [] _ = []
  zipWith' _ _ [] = []
  zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys
```

* Note the first parameter of `zipWith'`
  * It's a function that takes types `a` and `b`, and returns type `c`
  * These are the types of the lists we're working with

* We are using recursion in this function
  * If either of the lists is empty, return an empty list
  * Otherwise, apply the function to the two heads, and recurse on the tails

### flip

* `flip` is another standard library function
  * It takes a function and returns a function with the first two parameters flipped

```haskell
  flip' :: (a -> b -> c) -> (b -> a -> c)
  flip' f = g
      where g x y = f y x
```

* We take a function that takes `a` and `b` (and returns `c`), and return a function that takes `b` and `a` (and returns `c`)
  * Note the types: `f :: a -> b -> c` and `g :: b -> a -> c`

* Note that ``->`` is right-associative, because of currying
  * Thus, `(a -> b -> c) -> (b -> a -> c)` is the same as `(a -> b -> c) -> (b -> (a -> c))`, which is the same as `(a -> b -> c) -> b -> a -> c`

* Also note that `g x y = f y x` is equivalent to `f y x = g x y`

```haskell
  flip' :: (a -> b -> c) -> b -> a -> c
  flip' f y x = f x y
```

* Note the types: `f :: a -> b -> c`, `y :: b`, `x :: a`, `f x y :: c`

* Because of currying, `flip' f` returns a function that takes `y` and `x` as parameters
  * However, this function calls `f x y` which flips the parameters

## map and filter

* Two characteristic functions of functional programming

* `map` takes a function and a list, and applies that function to every element in the list

* See the type and definition of `map`
  * `map` takes a function (that takes `a` and returns `b`) and a list of `a`'s, and returns a list of `b`'s

```haskell
  map :: (a -> b) -> [a] -> [b]
  map _ [] = []
  map f (x:xs) = f x : map f xs
```

* Example: ``map (*2) [1,2,3,4,5]`` returns `[2,4,7,8,10]`

* `filter` has a self-explanatory name
  * It takes a predicate (a function that returns a boolean) and a list
  * It returns a list of elements that satisfy the predicate

```haskell
  filter :: (a -> Bool) -> [a] -> [a]
  filter _ [] = []
  filter p (x:xs)
      | p x       = x : filter p xs
      | otherwise = filter p xs
```

* If `p x` returns `True` for any element `x` in the list, then `x` will be included in the returned list

* Example: `filter even [1..10]` returns `[2,4,6,8,10]`

* You can do the same thing with list comprehensions as you can with `map` and `filter` 
  * Eg ``map (*2) [1,2,3,4,5]`` is equivalent to ``[x*2 | x <- [1,2,3,4,5]]`
  * Use whatever you feel is more readable

* On the topic of predicates, consider `takeWhile`
  * It takes a predicate and a list
  * Starting from the beginning, it traverses the list *as long as* the predicate is true
  * Once the predicate evaluates to false, it stops
  * Example: `takeWhile (<=10) [1..]` returns `[1,2,3,4,5,6,7,8,9,10]`

### Some examples

* Find the sum of all odd squares that are smaller than 10,000
  * First, let's create an infinite list of squares
    * `map (^2) [1..]`
  * We only want the odd squares, so use `filter`
    * `filter odd (map (^2) [1..])`
  * We only want odd squares smaller than 10,000
    * `takeWhile (<10000) (filter odd (map (^2) [1..])))`
  * Finally, sum them
    * `sum (takeWhile (<10000) (filter odd (map (^2) [1..]))))`

* Note that a list comprehension could have been used
  * `sum (takeWhile (<10000) [n^2 | n <- [1..], odd (n^2)])`

* Thanks to currying, we can do this:
  * `listOfFuns = map (*) [0..]`
  * So `listOfFuns` is equivalent to `[(0*),(1*),(2*)..]`
  * Then `(listOfFuns !! 4)` takes the fourth element, which is `(4*)`
  * So `(listOfFuns !! 4) 5` is a very roundabout way of writing `4 * 5`

## Lambdas

* Another characteristic of functional programming

* Lambdas are anonymous functions
  * Typically it's when you only need to use a function once, so it's not worth the effort to explicitly define one
  * Passing functions around to higher-order functions is a good use case
  * Syntax: Start with `\` (because it supposedly looks like the Greek letter lambda -- `λ`), write the parameters, write `->`, and then the function body

* Note that currying and partial application can give us situations where we don't need lambdas
  * `map (+3) [1,2,3,4,5]` and `map (\x -> x + 3) [1,2,3,4,5]` are equivalent
    * But the first is clearer

* You can use any number of parameters in a lambda function

* You can also use pattern matching

## Folds

* Yet another characteristic of functional programming, though called **reduce** in some languages (or even **inject**)

* Recursion on lists usually have the edge/base case for the empty list
  * There is also the `x:xs` pattern where you operate on one element and then the rest of the list

* A **fold** is a function that works on patterns like this
  * It takes a binary function, a starting value (accumulator), and a list
  * The binary function operates on an element from the list (either the first or the last) and the accumulator, and the result becomes the new accumulator
  * In this way, the list gets smaller and smaller
  * The fold continues until the list has been completed folded up

* In other words, you traverse the list once, iterating over all the elements, and return a single value

### The left fold

* `foldl` is the **left fold**
  * It folds the list up from the left, ie it starts with the accumulator and the head of the list
  * Consider the following implementation of `sum`

```haskell
  sum' :: (Num a) => [a] -> a
  sum' xs = foldl (\acc x -> acc + x) 0 xs
```

* Example: `sum' [1,3,5,7]`
* The binary function is the lambda `\acc x -> acc + x`
  * The function starts with `0` as the accumulator, and the head, `1`, as `x`
  * Then the new accumulator is `1` and the working list is now `[3,5,7]`
  * This continues until the entire list is "folded" into the accumulator
  * Note that the type of the return value and the type of the accumulator are the same
    * After all, at the very end, you're returning the final value of the accumulator

* Also, note how we can simplify the function
  * Because of currying, we can eliminate `xs` from both sides and get `sum' = foldl (\acc x -> acc + x) 0`
  * Also, note `(\acc x -> acc + x)` which is a function that takes two arguments and adds them. This is equivalent to `(+)` thanks to partial application
  * So we can write the function as

```haskell
  sum'' :: (Num a) => [a] -> a
  sum'' = foldl (+) 0
```

### The right fold

* The **right fold**, `foldr`, works similarly but folds up from the right
  * Also, the accumulator is on the right, eg `(\x acc -> ... )` is the function in `foldr`

* Consider an implementation of `map` with `foldr`

```haskell
  map' :: (a -> b) -> [a] -> [b]
  map' f xs = foldr (\x acc -> f x : acc) [] xs
```

* Note how we start with the empty list as our accumulator
  * Then we apply the function `f` to the last element of the list, and prepend it to the accumulator
  * So we take elements from the list, starting from the right, apply the function to them, and then stick them onto the front of the accumulator

### Right vs left folds

* Why use `foldr` instead of `foldl`?
  * In this case, using `foldl` means we would have to **append** elements to the accumulator, which is more expensive
    * `map' f xs = foldl (\acc x -> acc ++ [f x]) [] xs`
  * In general, though, you can rewrite a function that uses `foldr` by reversing it, and then applying `foldl`. And vice versa
  * But the main reason for using `foldr` is that it works on infinite lists, but `foldl` doesn't
    * `foldr` starts from the right, and will eventually reach the beginning of the list
    * `foldl` starts from the left, and never reaches the end of the list

* Another way to visualize the difference: suppose we're folding with the function `f`, accumulating with `acc`, and folding on the list `[1,2,3,4]`
  * The left fold is essentially: `f (f (f (f z 1) 2) 3) 4`
  * The right fold is essentially: `f 1 (f 2 (f 3 (f 4 z)))`

### Folds with implicit starting values

* These are the `foldl1` and `foldr1` functions
  * Note that the last character is the number `1`, not the letter `l`
  * They use the first (or last) element of the list as the starting value
  * Thus, `foldl1` and `foldr1` will fail on empty lists, while `foldl` and `foldr` don't care

* Here's one more implementation of `sum`

```haskell
  sum''' :: (Num a) => [a] -> a
  sum''' = foldl1 (+)
```

### scanl and scanr, scanl1 and scanr1

* These are very similar to their counterparts, `foldl` and `foldr`, `foldl1` and `foldr1`
  * The difference is that they keep track of the intermediate values of the accumulator in a list
  * `foldl1 (+) [1,2,3,4]` and `foldr1 (+) [1,2,3,4]` both return `10`
  * `scanl1 (+) [1,2,3,4]` returns `[1,3,6,10]`
  * `scanr1 (+) [1,2,3,4]` returns `[10,9,7,4]`

* As an example, consider determining how many elements it takes for the sum of the roots of all natural numbers to exceed 1000
  * First, we use `map` to get the square roots of all natural numbers
    * `map sqrt [1..]`
  * To get the sum, we would use a fold. But in this case, we want to keep track of the sum as it builds up, so we use a scan
    * We use `scanl1` because we're starting from the left
    * `scanl1 (+) (map sqrt [1..])`
  * Now we need to count how many elements are less than 1000
    * We use `takeWhile` to get a list of all the elements less than 1000
    * `takeWhile (< 1000) (scanl1 (+) (map sqrt [1..]))`
  * Now we take the length of that list, and add 1 because we want to just exceed 1000
    * `length (takeWhile (< 1000) (scanl1 (+) (map sqrt [1..]))) + 1`

## Function application with $

* The `$` function is **function application**

* Here is its implementation:

```haskell
  ($) :: (a -> b) -> a -> b
  f $ x = f x
```

* What's the difference between `$` and normal function application, done with a space?
  * Normal function application has high precedence, thus it is left-associative
    * `f a b c` is the same as `((f a) b) c`
  * `$` has low precedence, thus it is right-associative
    * `f $ a $ b c` is the same as `f (a (b c))`

* Some examples:
  * `sum (map sqrt [1..100])` is the same as `sum $ map sqrt [1..100]`
  * `sqrt 9 + 4 + 3` is equivalent to `(sqrt 9) + 4 + 3` which returns `10`
  * `sqrt $ 9 + 4 + 3` is equivalent to `sqrt (9 + 4 + 3)` which returns `4`

* One other reason for using `$` is that we can *treat function application as a function*
  * Example, mapping function application over a list of functions
    * `map ($ 4) [(4+), (^2), sqrt]` returns `[8.0,16.0,2.0]`

## Function composition

* This is notation for combining (or composing) two functions to create a new function
  * In Haskell, function composition is done with the `.` function
  * Example: `f . g x` is the same as `f (g x)`
  * See the implementation below:

```haskell
  (.) :: (b -> c) -> (a -> b) -> a -> c
  f . g = \x -> f (g x)
```

* Note that `f`'s parameter type must be the same as `g`'s return type

* Function composition is useful because it can be clearer than using a lambda
  * With a lambda: `map (\x -> negate (abs x)) [1,-2,3,-4,5]`
  * With composition: `map (negate . abs) [1,-2,3,-4,5]`

* Also note that function composition is right-associative
  * `f (g (h x))` is equivalent to `f . g . h x`
  * This allows us to chain functions together

* For composing functions that take multiple parameters, we need to partially apply the functions
  * For example, `sum (replicate 5 (max 6.7 8.9))` can be rewritten as `(sum . replicate 5 . max 6.7) 8.9` or `sum . replicate 5 . max 6.7 $ 8.9`
  * Note that the last parameter (`8.9`) of the innermost function (`max`) is placed at the very end, after `$`, and then everything else is composed with `.`
  * This is handy for rewriting expressions with a lot of parentheses

* One final use of function composition is writing functions in **point free style**, or **pointless style**
  * `sum' xs = foldl (+) 0 xs` when written in point free style becomes `sum' = fold (+) 0`
    * Notice how the `xs` has been removed from both sides, because of currying
  * It's less obvious to remove the parameter `x` in `fn x = ceiling (negate (tan (cos (max 50 x))))`
    * However, we can use function composition to get `fn = ceiling . negate . tan . cos . max 50`
  * Note that point free style is usually more concise and clear, but at some point, it will actually make the function less clear
