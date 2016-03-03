import Base
import CheckedStateful
import StatefulParse

t1 = parseExp ("var x = mutable 3;"++
     "var y = mutable true;"++
     "if (@y) { x = @x + 1 } else { x };"++
     "@x")

t2 = parseExp ("var x = mutable 3;"++
     "var y = mutable 7;"++
     "x = @x + @y;"++
     "y = @y * @x")

t3 = parseExp ("var x = mutable 0;"++
	 "var y = mutable 7;"++
	 "x = @y / @x")

t4 = parseExp ("@99")

t5 = parseExp ("@true = 34")

t6 = parseExp ("var x = 34; x = 8")

t7 = parseExp("var x = true; -x")

t8 = parseExp ("var x = mutable 3;"++
     "var y = mutable true;"++
     "if (@y) { x = @x + 1 } else { x };"++
     "@x")

t9 = parseExp ("var x = mutable 3;"++
     "var y = mutable 7;"++
     "x = @x + @y;"++
     "y = @y * @x")

t10 = parseExp("var id = function (x) { return x };"++
   "id(3)")

t11 = parseExp("var proc = function (z) { z };"++
   "proc(2)")

t12 = parseExp("var early = function (x) { return x; x / 2 };"++
   "early(2)")

t13 = parseExp("var v = undefined; var f = function(x) { x };"++
   "v == f(3)")

t14 = parseExp("var x = mutable 3; var f = function (ptr) { ptr = 1 + @ptr; (return @ptr); ptr = 0 }; f(x);"++
   "@x")

main = do
  test "evaluate" execute t1
  test "evaluate" execute t2
  test "evaluate" execute t3
  test "evaluate" execute t4
  test "evaluate" execute t5
  test "evaluate" execute t6
  test "evaluate" execute t7
  test "evaluate" execute t8
  test "evaluate" execute t9
  test "evaluate" execute t10
  test "evaluate" execute t11
  test "evaluate" execute t12
  test "evaluate" execute t13
  test "evaluate" execute t14