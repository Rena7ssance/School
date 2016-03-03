-- Name: Riley Gibson
-- UT EID: Rdg766

fibs = [a | (a,b) <- iterate (\(a,b) -> (b, a+b)) (1,1)]

factors n = [k | k <- [1..n], n `mod` k == 0]

primes = filter isprime [2..]
             where
             isprime p = (factors p == [1,p])

partC = [fibs !! (k) | k <- primes]

partD = [primes !! k | k <- fibs]

main = do 
	print (take 10 fibs)
	print (take 10 primes)
	print (take 10 partC)
	print (take 10 partD)
