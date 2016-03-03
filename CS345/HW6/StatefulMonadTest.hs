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

main = do
  test "evaluate" execute t1
  test "evaluate" execute t2
  test "evaluate" execute t3
  test "evaluate" execute t4
  test "evaluate" execute t5
  test "evaluate" execute t6
  test "evaluate" execute t7