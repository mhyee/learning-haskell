-- http://www.haskell.org/haskellwiki/H-99:_Ninety-Nine_Haskell_Problems

-- Problem 1: Find the last element of a list ----------------------------------
--   myLast takes a list of a's and returns a single a
--   The last element of a single-element list is that element
--   Otherwise recursively call myLast on the list with the head removed
myLast :: [a] -> a
myLast [x] = x
myLast (_:xs) = myLast xs

-- Variation: Reverse the list and take the first element, using composition
myLast' = head . reverse


-- Problem 2: Find the last but one element of a list --------------------------
--  myButLast takes a list of a's and returns a single a
--  If the list has two elements, return the first one
--  Otherwise apply myButLast to the list with the head removed
myButLast :: [a] -> a
myButLast [x,_] = x
myButLast (_:xs) = myButLast xs

-- Variation: Reverse the list and take the second element (note zero-indexed)
myButLast' xs = reverse xs !! 1

-- Variation: Take the last of `init` (which is everything except the last elt)
myButLast'' = last . init

-- Variation: Reverse the list, take the tail (which drops the last element
--  from the original), and then take the head
myButLast''' = head . tail . reverse


-- Problem 3: Find the K'th element of a list (1-indexed) ----------------------
--  elementAt takes a list of b's and a Num, and returns a b
--  elementAt with a list and 1 returns the first element
--  Otherwise take the "rest" of the list and decrement the number
elementAt :: (Num a, Eq a, Show a) => [b] -> a -> b
elementAt (x:_) 1 = x
elementAt (_:xs) n = elementAt xs (n - 1)

-- Variation: Use the "element at" function already provided
--   Note that the list is zero-indexed
elementAt' xs n = xs !! (n - 1)


-- Problem 4: Find the number of elements of a list ----------------------------
--  myLength takes a list and returns an Integer
--  An empty list has length =
--  Otherwise, length is 1 + the length of the "rest" of the list
myLength :: [a] -> Integer
myLength [] = 0
myLength (_:xs) = 1 + myLength xs

-- Variation: Map every element to 1, then sum the list
myLength' = sum . map (\x -> 1)

-- Variation: Using a fold, increase the accumulator
myLength'' = foldl (\n _ -> n + 1) 0


-- Problem 5: Reverse a list ---------------------------------------------------
--  myReverse takes a list and returns an empty list
--  The reverse of an empty list is the empty list
--  Take the first element and append it to the reversed portion of the rest
--  This is actually pretty inefficient
myReverse :: [a] -> [a]
myReverse [] = []
myReverse (x:xs) = myReverse xs ++ [x]

-- Variation: Using a left fold, start prepending elements from the beginning of
--   the left end of the list
myReverse' = foldl (\acc x -> x:acc) []


-- Problem 6: Find out whether a list is a palindrome --------------------------
isPalindrome :: (Eq a) => [a] -> Bool
isPalindrome xs = (reverse xs) == xs

-- Variation: Do it recursively, match the head and the tail, then call
--   recursively on the "middle" of the list
--   Base case is the empty list, or the list containing one element
isPalindrome' [] = True
isPalindrome' [_] = True
isPalindrome' xs = (head xs == last xs) && (isPalindrome' $ tail $ init xs)


-- Problem 7: Flatten a nested list structure ----------------------------------


-- Problem 8: Eliminate consecutive duplicates of list elements ----------------
--   We start from the right of the list, with an empty list as the accumulator
--   Then we call `group`. If the element matches the head of the accumulator,
--   throw the element away.
--   Otherwise, prepend it to the accumulator
compress :: (Eq a) => [a] -> [a]
compress = foldr group []
    where group x [] = [x]
          group x xs
              | x == head xs = xs
              | otherwise    = x:xs

-- Variation: Use the `pack` function below, and simply take the head of each
--   sublist
compress' xs = map head $ pack xs


-- Problem 9: Pack consecutive duplicates of list elements into sublists -------
--   We use a right fold and start with an empty accumulator
--   In our helper function, if the accumulator is empty, we create a list of a
--   list of that element
--   Next, we compare the element to the head of the first sublist in the
--   accumulator.
--   If they're equal, add the element to that sublist
--   Otherwise, create a new sublist and prepend it
pack :: (Eq a) => [a] -> [[a]]
pack = foldr packIt []
    where packIt x [] = [[x]]
          packIt x lis@(y:xs)
              | x == head y = (x:y):xs
              | otherwise   = [x]:lis


-- Problem 10: Run-length encoding of a list -----------------------------------
--   Make use of the `pack` function above
--   We first pack the list, and then map over it, creating pairs
--   The pair will contain the length and the head of the sublist
encode :: (Eq a) => [a] -> [(Int, a)]
encode = map (\x -> (length x, head x)) . pack
