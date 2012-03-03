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
