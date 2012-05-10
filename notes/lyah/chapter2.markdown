# 2 Starting Out

* Ordinary arithmetic works as expected
	* Note required parentheses for `5 * (-3)`

* Boolean algebra works as expected
	* `True` and `False`
	* `&&` is **and**, `||` is **or**, `not` is negation
	* `==` tests for equality
	* **Note!** `/=` tests for inequality

* Haskell is strongly-typed, so `5 + "llama"` causes an exception

## Function application

* Most functions in Haskell are *prefix* functions
	* Some exceptions are math functions, eg `*` is an *infix* function

* Functions are called in the form `funcName param1 param2 … paramN`
	* Spaces (not parentheses) denote function application

* Function application has the highest precedence
	* Parentheses are used to change the precedence

* A function that takes two parameters can be called as an infix function
	* `div 92 10` is equivalent to the clearer ``92 `div` 10``

## Functions

* Functions are defined in the format `funcName param1 param2 … paramN = [definition]`
	* Function definition order doesn't matter

```haskell
	doubleUs x y = doubleMe x + doubleMe y
	doubleMe x = x + x
```

* If statements are expressions (they always return something), so the *else* is mandatory

```haskell
	doubleSmallNumber x = if x > 100
							then x
							else x*2
```

* Function and variable names
	* `` ` `` is a valid character
		* Convention: use as suffix to denote a strict (non-lazy) version of a function, or a slightly modified version of a function or variable
	* Functions can't begin with uppercase letters

* A function with no parameters is a *definition* or a *name*
	* Can be used interchangeably with its definition

## Lists

* **Note:** `let a = 1` in GHCI is the same as loading a script with `a = 1` in it

* Lists are a **homogenous** data structure
	* All elements of a list must be of the same type
	* `let fibonacciNums = [1,1,2,3,5]`

* Strings are lists of characters
	* `"hello"` is equivalent to `['h','e','l','l','o']`

* The `++` operator joins lists
	* `"hello" ++ "world"` results in `"hello world"`
	* **Implementation detail:** `++` has a runtime of O(n)

* The `:` operator (aka cons) prepends an element to a list
	* `'h':"ello"` results in `"hello"`
	* **Implementation detail:** `:` has a runtime of O(1)

* `[1,2,3]` is syntactic sugar for `1:2:3:[]` where `[]` is the empty list

* `!!` is like the array subscript operator, with lists being 0-indexed
	* `[3,4,29,0] !! 1` returns `4`

* Nested lists are allowed

* Lists are compared lexicographically with `<`, `<=`, `>`, and `>=`

### Common list functions
* `head`
* `tail` takes all but the head
* `last`
* `init` takes all but the last
* `length`
* `null` returns `True` if the list is empty, `False` otherwise
* `reverse`
* `take n` extracts the first n elements from a list
* `drop n` drops the first n elements from a list
* `maximum`
* `minimum`
* `sum`
* `product`
* `elem` checks if an element is in a list
	* Commonly used as an infix function
	* ``0 `elem` [1,2,3]`` returns `False`

## Ranges and infinite lists

* Making lists that are sequences of enumerated elements
	* Numbers and characters can be enumerated
	* `['a'..'e']` is a shorthand for `"abcde"`
	* `[2,4..10]` is shorthand for `[2,4,6,8,10]`
	* `[5,4..1]` is shorthand for `[5,4,3,2,1]`
	* Generally want to avoid floating points

* Can make infinite lists, thanks to laziness
	* `[10,20,..10*12]` is the same as `take 12 [10,20..]`

### Functions for infinite lists

* `cycle` takes a list and turns it into an infinite list by repeating it
* `repeat` takes an element and turns it into an infinite list by repeating it
	* For a list of N of the same elements, use `replicate N elt`

## List comprehensions

* Sort of like set notation

* `[x*2 | x <- [1..10], x*2 >= 12]` generates the list `[12,14,16,18,20]`
	* For all elements x in [1..10] with the condition x * 2 >= 12, write x * 2
	* We bind the elements of [1..10] to `x`
	* We call `x*2 >= 12` a **predicate**
		* Multiple predicates, separated by commas, are allowed
		* We say that we **filter** by the predicate(s)

* We can draw from multiple lists
	* `[ x * y | x <- [1,2,3], y <- [4,5,6] ]` returns `[4,5,6,8,10,12,12,15,18]`

* Nested list comprehensions are also allowed

* Example: creative implementation of `length`
	* `length' xs = sum [1 | _ <- xs]`
	* We use `_` to denote a variable that we won't use
	* We don't care what the element is, we're just going to turn it into 1 and then sum the list up

## Tuples

* Have a specific number of elements

* Can contain different types

* Type of tuple depends on what what type of elements and how many elements it has

* Tuple syntax uses parentheses
	* `(1, 4, 9)`
	* `("John Smith", 5551234)`


### Some functions relating to 2-tuples (pairs)

* `fst` returns the first element of a pair

* `snd` returns the second element of a pair

* `zip` takes two lists and creates a list of pairs
	* Combines Nth element of list A with Nth element of list B
	* `zip [1,2,3] ['a','b','c']` returns `[(1,'a'),(2,'b'),(3,'c')]`
	* If the lists have different lengths, the longer one is truncated