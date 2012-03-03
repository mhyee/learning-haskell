-- Problem 1: Find the last element of a list

-- myLast takes a list of a's and returns a single a
-- The last element of a single-element list is that element
-- Otherwise recursively call myLast on the list with the head removed
myLast :: [a] -> a
myLast [x] = x
myLast (_:xs) = myLast xs
