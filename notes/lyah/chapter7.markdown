# 7 Modules

## Loading modules

* A module is a collection of functions, types, and typeclasses
  * Good for organizing pieces of related code, and also allows code reuse
  * All the examples so far have been using the `Prelude` module, which is loaded by default

```haskell
  import Data.List

  numUniques :: (Eq a) => [a] -> Int
  numUniques = length . nub
```

* `import <module>` is the simplest way of importing a module
  * Imports are usually done at the beginning of a file
  * To import multiple modules, just write one line for each module to import
  * In the example above, we imported the `Data.List` module, which, as its name implies, has functions for working with lists
    * All the functions in `Data.List` are imported into the global namespace
    * `nub` is a function from `Data.List` that removes duplicates

* To import in GHCI, use `:m + Data.List`
  * GHCI syntax for importing multiple modules: `:m + Data.List Data.Map Data.Set`

* To import only specific functions from a module, use `import Data.List (nub, sort)`
  * This imports `nub` and `sort` from `Data.List`

* To import all functions *except* the specified ones, use `import Data.List hiding (nub)`
  * This imports all functions from `Data.List` **except** `nub`
  * One reason for doing this is if you have a different function with the same name

* A **qualified** import can be done with `import qualified Data.Map`
  * In this case, `Data.Map` has functions like `filter`, which has the same name as `filter` from `Prelude`
  * By using a qualified import, `filter` refers to the function from `Prelude`, while `Data.Map.filter` refers to the one we just imported
  * A shorthand is `import qualified Data.Map as M` which allows us to call functions with `M.filter` instead of `Data.Map.filter`

* [Here][modules] is a list of modules in the standard library

* [Hoogle][] is a Haskell API search engine, and can be used to search for functions

[modules]: http://www.haskell.org/ghc/docs/latest/html/libraries/
[Hoogle]: http://www.haskell.org/hoogle/

## Data.List

* Some functions, like `map` and `filter`, have already been imported by `Prelude`

* `Data.List` does not need a qualified import

### Some functions from Data.List

* `intersperse` takes an element and a list, and intersperses that element between all the elements in the list
  * `intersperse 0 [1,2,3,4,5]` returns `[1,0,2,0,3,0,4,0,5]`

* `intercalate` takes a list and a list of lists, and returns a single flattened list
  * `intercalate [0,9] [[1,2],[3,4],[5,6]]` returns `[1,2,0,9,3,4,0,9,5,6]`

* `transpose` transposes a list of lists (ie a matrix), so the rows become columns and vice versa
  * `transpose [[1,2,3],[4,5,6],[7,8,9]]` returns `[[1,4,7],[2,5,8],[3,6,9]]`

* `foldl'` and `foldl1'` are strict versions of `foldl` and `foldl1` (which are lazy)
  * Lazy folds might cause a stack overflow on large lists, because instead of updating the accumulator, **thunks** (like "promises" that it will eventually calculate the value) are placed on the stack and can overflow
  * The strict folds have no thunks, and update the accumulator every step of the fold

* `concat` flattens a list of lists, but only one level at a time
  * `concat ["abc","def","ghi"]` returns `"abcdefghi"`

* `concatMap` maps a function, and then flattens the list with `concat`
  * `concatMap (replicate 2) [1..3]` returns `[1,1,2,2,3,3]`

* `and` takes a list of boolean values, and returns `True` only if every element in the list is `True`
  * `and $ map (> 2) [1,2,3,4]` returns `False`

* `or` is similar, and returns `True` if one (or more) element is `True`
  * `or $ map (> 2) [1,2,3,4]` returns `True`

* `all` takes a predicate and a list, and returns `True` if any of the elements satisfy the predicate
  * `all (> 2) [1,2,3,4]` returns `False`
  * This is more convenient than the above example with `and`, which requires mapping the predicate over the list

* `any` is the counterpart to `all` (or `or`)
  * `any (> 2) [1,2,3,4]` returns `True`
