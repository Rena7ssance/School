import Base
import FirstClassFunctions hiding (evaluate, execute)
import FirstClassFunctionsParse
import ErrorChecking

testUBV = execute (parseExp "x")
testDBZ2 = execute (parseExp "3 / 0")

test3 = execute (parseExp "-true") 
test4 = execute (parseExp "!4") 
test5 = execute (parseExp "4 + true")
test6 = execute (parseExp "4 && false")
test7 = execute (parseExp "if (7) 1 else 2")
test8 = execute (parseExp "var x = 3/0; x")
test9 = execute (parseExp "2(3)")

test10 = execute (parseExp "if (x) 3 else 4")
test11 = execute (parseExp "if(3 == 3) -true else 1")
test12 = execute (parseExp "if (1 == 2) 2 else y")
test13 = execute (parseExp "var x = 3; var y = t; x")
test14 = execute (parseExp "var y = 3; z")
test15 = execute (parseExp "var x = 2; if (x) 3 else 4")

p5 = execute (parseExp (
 "var map = function(f) { function(x) { function(y) { f(x) + f(y) }}};"++
 "var g = function(x) { x + 1 };"++
 "map(x)(3)(4)"))

p6 = execute (parseExp (
 "var map = function(f) { function(x) { function(y) { f(x) + f(y) }}};"++
 "var g = function(x) { x + 1 };"++
 "map(g)(-true)(4)"))

p7 = execute (parseExp (
 "var map = function(f) { function(x) { function(y) { f(x) + f(y) }}};"++
 "var g = function(x) { x + 1 };"++
 "map(3)(4)(4)"))
 
p8 = execute (parseExp (
 "var map = function(f) { function(x) { function(y) { f(x) + f(y) }}};"++
 "var g = function(x) { x + 1 };"++
 "map(g)(g)(4)"))

p9 = execute (parseExp ("try {x} catch {y}"))

main = do
  tagged "testUBV" (print testUBV)
  tagged "testDBZ2" (print testDBZ2)
  tagged "test3" (print test3)
  print test4
  print test5
  print test6
  print test7
  print test8
  print test9
  print test10
  print test11
  print test12
  print test13
  print test14
  print test15
  tagged "p5" (print p5)
  tagged "p6" (print p6)
  tagged "p7" (print p7)
  tagged "p9" (print p9)
  tagged "p8" (print p8)