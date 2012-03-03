-- http://www.haskell.org/haskellwiki/H-99:_Ninety-Nine_Haskell_Problems

-- Problem 1: Find the last element of a list
--   myLast takes a list of a's and returns a single a
--   The last element of a single-element list is that element
--   Otherwise recursively call myLast on the list with the head removed
myLast :: [a] -> a
myLast [x] = x
myLast (_:xs) = myLast xs

-- Problem 2: Find the last but one element of a list
--  myButLast takes a list of a's and returns a single a
--  If the list has two elements, return the first one
--  Otherwise apply myButLast to the list with the head removed
myButLast :: [a] -> a
myButLast [x,_] = x
myButLast (_:xs) = myButLast xs

-- Problem 3: Find the K'th element of a list (1-indexed)
--  elementAt takes a list of b's and a Num, and returns a b
--  elementAt with a list and 1 returns the first element
--  Otherwise take the "rest" of the list and decrement the number
elementAt :: Num a => [b] -> a -> b
elementAt (x:_) 1 = x
elementAt (_:xs) n = elementAt xs (n - 1)

-- Problem 4: Find the number of elements of a list
--  myLength takes a list and returns an Integer
--  An empty list has length =
--  Otherwise, length is 1 + the length of the "rest" of the list
myLength :: [a] -> Integer
myLength [] = 0
myLength (_:xs) = 1 + myLength xs
