import Base
import Prelude hiding (LT, GT, EQ)
import FirstClassFunctions
import FirstClassFunctionsParse

p1 = parseExp ("var T = function(a) { function(b) { a } };"++
               "var F = function(a) { function(b) { b } };"++
               "var not = function(b) { b(F)(T) };"++
               "not(F)")
               
p2 = parseExp (
      "var x = 5;"++
      "var f = function(y) { x - y };"++
      "var x = f(9);"++
      "f(x)")

p3 = parseExp (
      "var x = 5;"++
      "var f = function(y) { var y = x * y; function(x) { x + y } };"++
      "var g = f(2);"++
      "g(5)")

p4 = parseExp (
      "var comp = function(f) { function(g) { function(x) { f(g(x)) }}};"++
      "var inc = function(x) { x + 1 };"++
      "var square = function(x) { x * x };"++
      "var f = comp(inc)(square);"++
      "f(5)")

p5 = parseExp (
      "var map = function(f) { function(x) { function(y) { f(x) + f(y) }}};"++
      "var g = function(x) { x + 1 };"++
      "map(g)(3)(4)")


p6 = parseExp (
      "var a = (1, 2); a")

p7 = parseExp (
      "var (a, b) = (1, 2); a + b")

p8 = parseExp (
      "var (a, b, c) = (1, 2, 3); a + b + c")

p9 = parseExp (
      "var (a, b, c, d) = (1, 2, 3, 4); a + b + c + d")

p10 = parseExp (
      "var ((a, b), c) = ((1, 2), 3); a + b + c")

p11 = parseExp (
      "var ((a, b), (c, d)) = ((1, 2), (3, 4)); a + b + c + d")

p12 = parseExp (
      "var (a, b) = (1, 2, 3); a + b")

p13 = parseExp (
      "var ((a, b), c) = (1, 2, 3); a + b + c")

p14 = parseExp (
      "var ((a, b), (c, d)) = (1, 2, 3, 4); a + b + c + d")

main = do
  tagged "FirstClassT1" (do
    test "execute" execute p1
    test "execute" execute p2
    test "execute" execute p3
    test "execute" execute p4
    test "execute" execute p5
    test "execute" execute p6
    test "execute" execute p7
    test "execute" execute p8
    test "execute" execute p9
    test "execute" execute p10
    test "execute" execute p11
    test "execute" execute p12
    test "execute" execute p13
    test "execute" execute p14
    )

       	