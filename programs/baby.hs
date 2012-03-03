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
-- Otherwise keep going
-- "otherwise" is a catch-all that always returns true
bmiTell :: (RealFloat a) => a -> a -> String
bmiTell weight height
  | weight / height^2 <= 18.5 = "You're underweight."
  | weight / height^2 <= 25.0 = "You're normal."
  | weight / height^2 <= 30.0 = "You're fat."
  | otherwise                 = "You're REALLY fat."

-- Defining an infix function
myCompare :: (Ord a) => a -> a -> Ordering
a `myCompare` b
  | a > b     = GT
  | a == b    = EQ
  | otherwise = LT
