# 3 Types and Typeclasses

## Types

* Haskell is statically typed
	* Types errors are compile-time errors

* Haskell also has type inference, so it's not required to explicitly write the types of all functions

* In GHCI, can check the type of expressions with `:t expr`
	* `:t 'a'` returns `'a' :: Char` which means _'a' has type of Char_
	* `"HELLO"` has type `[Char]`, which means _list of Chars_
		* `String` is the same as `[Char]`

* Type names are always capitalized

* Functions also have types
	* Considered good practice to explicitly declare their types
	* `foo :: String -> String` means _foo is a function that takes a String and returns a String_
	* For multiple parameters: `Int -> Int -> Int -> Int` is a function that takes three Ints and returns an Int
		* Functions have only one return value, so everything before the last `->` is a parameter
		* This is actually a result of **currying**, which is discussed laster
	* `:t` also works on functions in GHCI

### Common types
* `Int`
* `Integer` is unbounded, but less efficient than `Int`
* `Float`
* `Double` is double precision floating point
* `Bool`
* `Char` is a character, which are delimited with single quotes
	* `[Char]`, a list of characters, is the same as `String`

## Type variables

* Consider the `head` function, which has type `[a] -> a`

* `a` is a **type variable**, which is sort of like generics

* `head` takes a list of any type, and returns a single instance of that type

* `head` has type variables, so it's a **polymorphic function**

* Convention is to use single letters as type variables

## Introduction to typeclasses

* More like interfaces than classes
	* Describes behaviours and functions for its member types

* `(==) :: (Eq a) => a -> a -> Bool`
	* Type signature of, `==`, the equality function
	* Takes two things of the same type and returns a `Bool`
	* `=>` means **class constraint**
	* The two types	must be a member of the `Eq` typeclass

### Some basic typeclasses
* `Eq` is for equality testing, and supports the functions `==` and `/=`

* `Ord` is for orderings, and supports `>`, `<`, `>=`, `<=`
	* `compare :: Ord a => a -> a -> Ordering`
		* `Ordering` is a type that can be `GT`, `LT`, or `EQ`
		* ``5 `compare` 3`` returns `GT`
	* A type needs to be a member of `Eq` before it can be a member of `Ord`

* `Show` is for types that can be presented as strings, and supports the method `show`
	* `show 3` returns the string `"3"`

* `Read` supports `read`, which takes a string and returns a member of `Read`
	* `read "5" - 2` returns `3`, thanks to type inference
	* Otherwise, need a **type annotation**
		* `read "5" :: Int` returns `5`
		* `read "5"` returns an error

* `Enum` members can be enumerated and used in list ranges
	* Supports `succ` and `pred` which gets the successor and predecessor
	* Member types: `()`, `Bool`, `Char`, `Ordering`, `Int`, `Integer`, `Float`, `Double`

* `Bounded` members have upper and lower bounds
	* Can get bounds with functions `minBound` and `maxBound`
	* `maxBound :: Bool` returns `True`

* `Num` is for all numbers, eg whole numbers and real numbers

* `Integral` is only for whole numbers, ie `Int` and `Integer` types
	* Useful function `fromIntegral :: (Num b, Integral a) => a -> b` which turns a whole number into a general number
		* `length` returns an `Int`, so `length [1] + 0.2` doesn't work
		* `fromIntegral (length [1]) + 0.2` works
		* Note how `fromIntegral` has multiple class constraints

* `Floating` is for types `Float` and `Double`
