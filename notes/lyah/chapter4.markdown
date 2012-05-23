# 4 Syntax in Functions

## Pattern matching

* Can define different function bodies for different patterns (of arguments)
  * Patterns are matched from top to bottom
  * "Catch all" is always the last one (since nothing else is matched)

```haskell
  factorial :: (Integral a) => a -> a
  factorial 0 = 1
  factorial n = n * factorial (n - 1)
```

* If `factorial` is called with 0, return 1. Else return `n * factorial (n - 1)`
  * This is an example of recursion; more to come

* Pattern matching also works with tuples

* ``_`` (don't care) also works with pattern matching

```haskell
  first :: (a, b, c) -> a
  first (x, _, _) = x

  second :: (a, b, c) -> b
  second (_, y, _) = y

  third :: (a, b, c) -> c
  third (_, _, z) = z
```

* Pattern matching also works in list comprehensions

* Lists can be matched
  * `x:xs` is a common idiom for matching the head to `x` and the tail to `xs`
  * **Note:** Pattern matching with `:` fails on empty lists
  * Note syntactic sugar: `(x:[])` is the same as `([x])` and `(x:y:[])` is the same as `([x,y])`
  * There are also **as patterns** for lists, which uses `@`
    * `xs@(x:y:ys)` maps `x` to the head, `y` to the second element, `ys` to the rest, and `xs` to the entire list


## Guards

* Patterns are for matching values to a specific form (or value)

* Guards are used to test conditions, similar to if statements

```haskell
  funcName param
    | cond1     = statement1
    | cond2     = statement2
    ...
    | condN     = statementN
    | otherwise = statement
```

* Note the `otherwise` condition, which is a catch-all (`otherwise` evaluates to `True`)

* Note that `funcName param` declaration is not followed by `=`

## Where bindings

* **where** bindings can be used to improve readability by factoring out common code

* `where` can be used to define helper functions or constants

* Pattern matching also works in `where` bindings

* `where` bindings are local to the function, and work across the guards

* `where` can also be nested (eg helper functions for helper functions)

* Alignment is important

```haskell
  funcName param1 param2
    | helper >= high  = "High"
    | helper >= med   = "Medium"
    | helper >= low   = "Low"
    | otherwise       = "Whoops"
    where helper = param1 * param2
          (high, med, low) = (100, 50, 0)
```

## Let bindings

* Similar to `where` bindings, both are syntactic constructs
  * `where` bindings are at the end of a function, and visible to the entier function
  * `let` bindings can be done anywhere, are **expressions**, and are very local

* Form is `let <bindings> in <expression>`
  * The bindings are only visible in the expression

* Eg local functions
  * `[let sq x = x * x in (sq 1, sq 2, sq 3)]` returns `[(1,4,9)]`

* Pattern matching can be used
  * `(let (a,b,c) = (1,2,3) in a*b*c)` returns `6`

* Can be used in list comprehensions
  * `getBMI xs = [bmi | (w,h) <- xs, let bmi = w/h^2, bmi >= 25]`


## Case expressions

* Pattern matching works for case expressions
  * Pattern matching in function definitions is syntactic sugar for case expressions

```haskell
  factorial :: (Integral a) => a -> a
  factorial 0 = 1
  factorial n = n * factorial (n - 1)
  -- Is equivalent to
  factorial' :: (Integral a) => a -> a
  factorial' n = case n of 0 -> 1
                           n -> n * factorial (n - 1)
```

* General pattern is straightforward

```haskell
  case expression of pattern1 -> result1
                     pattern2 -> result2
                     ...
                     patternN -> resultN
```

* Case expressions are expressions, so can be used anywhere, not just in function definitions
