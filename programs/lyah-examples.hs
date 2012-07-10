-- Examples made while following http://learnyouahaskell.com/chapters

doubleMe x = x + x
doubleUs x y = doubleMe x + doubleMe y
doubleSmallNumber x = if x > 100 then x else x*2
doubleSmallNumber' x = (if x > 100 then x else x*2) + 1

-- Given a list xs, check every element (x) that is odd
boomBangs xs = [ if x < 10 then "BOOM!" else "BANG!" | x <- xs, odd x]

-- Map every element in xs to 1 and then sum the list
length' xs = sum [1 | _ <- xs]

-- Map every character c of st that is an element of the capital letters
removeNonUpperCase st = [ c | c <- st, c `elem` ['A'..'Z'] ]

-- factorial is a function of type Integer -> Integer
-- ie factorial takes an Integer and maps it to an Integer
factorial :: Integer -> Integer
factorial n = product [1..n]

-- lucky is a function that takes an a and maps it to a String
-- a is constrained to the typeclass Integral
-- Note the two different definitions for lucky
lucky :: (Integral a) => a -> String
lucky 7 = "LUCKY NUMBER SEVEN!"
lucky x = "Sorry, you're out of luck."

-- Alternate implementation of factorial, using recursion
factorial' :: (Integral a) => a -> a
factorial' 0 = 1
factorial' n = n * factorial' (n - 1)

-- Another attempt at length, using recursion
length'' :: (Num b) => [a] -> b
length'' [] = 0
length'' (x:xs) = 1 + length'' xs

-- Implementation of sum using recursion
sum' :: (Num a) => [a] -> a
sum' [] = 0
sum' (x:xs) = x + sum' xs

-- Takes two RealFloats and returns a String
-- "| COND" is evaluated; if true, return that string
-- This is called a "guard"
-- Otherwise keep going
-- "otherwise" is a catch-all that always returns true
bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
  | bmi <= 18.5 = "You're underweight."
  | bmi <= 25.0 = "You're normal."
  | bmi <= 30.0 = "You're fat."
  | otherwise   = "You're REALLY fat."
  where bmi = weight / height^2

-- Defining an infix function `mycompare`
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
  | a > b     = GT
  | a == b    = EQ
  | otherwise = LT

-- Recursively find the max of a list
-- The maximum of a list is the max of the first head and the tail of the list
maximum' :: (Ord a) => [a] -> a
maximum' [] = error "empty list"
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

-- Takes an int N and an element, and returns a list with N copies of the element
-- If N <= 0, we return an empty list
-- Otherwise, we take the element and concatenate it with a list of N-1 copies of it
-- We recursively generate the list of N-1 copies
replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
  | n <= 0    = []
  | otherwise = x:replicate' (n-1) x

-- Take a certain number of elements from a list
-- In the base conditions, if we want <= 0 elements or if the list is empty, return an empty list
-- Otherwise return head, and recursively call take' with N-1 on the tail of the list
take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
  | n <= 0      = []
take' _ []      = []
take' n (x:xs)  = x:take' (n-1) xs

-- Zip two lists together, so they're as long as the shorter of the two
-- So if either list is empty, the result is empty
-- Otherwise, put the two heads in a tuple, and zip the tails
zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

-- Check if an element is in a list
-- The given element is obviously not in an empty list
-- If it's equal to the head, we've found it
-- Otherwise, check if it's in the tail
elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
  | a == x    = True
  | otherwise = a `elem` xs

-- Quicksort
-- Take the first element to be the pivot
-- Construct smallerSorted, which is sorted and has all the elements less than the pivot
-- Construct biggerSorted, which is sorted and has all the elements larger than the pivot
-- Concatenate the two lists and the pivot
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  let smallerSorted = quicksort [a | a <- xs, a <= x]
      biggerSorted  = quicksort [a | a <- xs, a > x]
  in  smallerSorted ++ [x] ++ biggerSorted

-- Partially applied functions
multThree :: (Num a) => a -> a -> a -> a
multThree x y z = x * y * z
-- multThree 9 returns a function which takes two parameters
multTwoWithNine = multThree 9
-- multTwoWithNine 2 returns a function which takes one parameter
multWithEighteen = multTwoWithNine 2

-- Compare a number with 100
compareWithHundred :: (Num a, Ord a) => a -> Ordering
-- compareWithHundred x = compare 100 x
-- Thanks to currying, we can remove the x
-- compare 100 returns a function which takes one parameter
compareWithHundred = compare 100

-- A function that applies a function twice to a param
applyTwice :: (a -> a) -> a -> a
applyTwice f x = f (f x)

-- Zip two lists together with a function
-- If either list is empty, return an empty list
-- Otherwise, apply the function to both heads, and recursively zip the rest of the list
zipWith' :: (a -> b -> c) -> [a] -> [b] -> [c]
zipWith' _ [] _ = []
zipWith' _ _ [] = []
zipWith' f (x:xs) (y:ys) = f x y : zipWith' f xs ys

-- Return a function that is like the original one, but with the arguments flipped
flip' :: (a -> b -> c) -> (b -> a -> c)
flip' f = g
    where g x y = f y x
-- Another implementation with currying
flip'' :: (a -> b -> c) -> b -> a -> c
flip'' f y x = f x y
-- Another implementation with a lambda
flip''' :: (a -> b -> c) -> b -> a -> c
flip''' f = \x y -> f y x

-- First, define a "chain" (of Collatz numbers)
-- If C_n is even, then C_{n+1} = C_n / 2
-- If C_n is odd, then C_{n+1} = 3*C_n + 1
-- Stop at C_k = 1
-- Given a number, return a list of the entire chain
chain :: (Integral a) => a -> [a]
chain 1 = [1]
chain n
    | even n = n : chain (n `div` 2)
    | odd n  = n : chain (n*3 + 1)

-- For all starting numbers 1..100, how many chains have length greater than 15?
numLongChains :: Int
numLongChains = length (filter isLong (map chain [1..100]))
    where isLong xs = length xs > 15

-- Alternate implementation of numLongChains with a lambda
numLongChains' :: Int
numLongChains' = length (filter (\xs -> length xs > 15) (map chain [1..100]))

-- Implementing sum with a left fold
sum'' :: (Num a) => [a] -> a
sum'' xs = foldl (\acc x -> acc + x) 0 xs

-- A variation of sum with a left fold, but simplified
sum''' :: (Num a) => [a] -> a
sum''' = foldl (+) 0

-- Implementing map with a right fold
map' :: (a -> b) -> [a] -> [b]
map' f xs = foldr (\x acc -> f x : acc) [] xs

-- Another implementation of sum, this time with an implicit starting value
sum'''' :: (Num a) => [a] -> a
sum'''' = foldl1 (+)
