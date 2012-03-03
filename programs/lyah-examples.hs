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
maximum' :: (Ord a) => [a] -> a
maximum' [x] = x
maximum' (x:xs) = max x (maximum' xs)

replicate' :: (Num i, Ord i) => i -> a -> [a]
replicate' n x
  | n <= 0    = []
  | otherwise = x:replicate' (n-1) x

take' :: (Num i, Ord i) => i -> [a] -> [a]
take' n _
  | n <= 0      = []
take' _ []      = []
take' n (x:xs)  = x:take' (n-1) xs

zip' :: [a] -> [b] -> [(a,b)]
zip' _ [] = []
zip' [] _ = []
zip' (x:xs) (y:ys) = (x,y):zip' xs ys

elem' :: (Eq a) => a -> [a] -> Bool
elem' a [] = False
elem' a (x:xs)
  | a == x    = True
  | otherwise = a `elem` xs

-- Quicksort
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) =
  let smallerSorted = quicksort [a | a <- xs, a <= x]
      biggerSorted  = quicksort [a | a <- xs, a > x]
  in  smallerSorted ++ [x] ++ biggerSorted
