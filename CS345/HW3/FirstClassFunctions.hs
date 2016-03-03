module FirstClassFunctions where

import Prelude hiding (LT, GT, EQ, id)
import Data.Maybe
import Data.List
import Operators

data Value = IntV  Int
           | BoolV Bool
           -- | ClosureV String Exp Env  -- new
           | ClosureV Pattern Exp Env
           | TupleV [Value]
  deriving (Eq, Show)

data Exp = Literal   Value
         | Unary     UnaryOp Exp
         | Binary    BinaryOp Exp Exp
         | If        Exp Exp Exp
         | Variable  String
         -- | Declare   String Exp Exp
         -- | Function  String Exp      -- new
         | Call      Exp Exp         -- changed
         | Declare   Pattern Exp Exp
         | Function  Pattern Exp
         | Tuple     [Exp]
  deriving (Eq, Show)

data Pattern = VarP String
             | TupleP [Pattern]
  deriving (Eq, Show)           
  
type Env = [(String, Value)]

match :: Pattern -> Value -> [(String, Value)]
match (TupleP [])(TupleV []) = []
match (TupleP [])(TupleV (v:vs)) = error "Error"
match (TupleP (p:ps))(TupleV []) = error "Error"
match (TupleP (p:ps))(TupleV (v:vs)) = match p v ++ match (TupleP ps)(TupleV vs)
match (VarP x) y = [(x,y)] 

fix :: Pattern -> [Char]
fix (VarP x) = x
fix (TupleP (p:ps)) = fix p ++ fix (TupleP ps)

evaluate :: Exp -> Env -> Value
evaluate (Literal v) env = v

evaluate (Unary op a) env = 
  unary op (evaluate a env)

evaluate (Binary op a b) env = 
  binary op (evaluate a env) (evaluate b env)

evaluate (If a b c) env = 
  let BoolV test = evaluate a env in
    if test then evaluate b env
            else evaluate c env

evaluate (Variable x) env = fromJust (lookup x env)

evaluate (Tuple es) env = TupleV [ evaluate e env | e <- es ] 

evaluate (Declare x exp body) env = evaluate body newEnv
  where newEnv = (match x (evaluate exp env)) ++ env

evaluate (Function x body) env = ClosureV x body env     -- new

evaluate (Call fun arg) env = evaluate body newEnv    -- changed
  where ClosureV x body closeEnv = evaluate fun env
        newEnv = (match x (evaluate arg env)) ++ closeEnv

execute exp = evaluate exp []

-- same as in IntBool.hs

unary Not (BoolV b) = BoolV (not b)
unary Neg (IntV i)  = IntV (-i)

binary Add (IntV a)  (IntV b)  = IntV (a + b)
binary Sub (IntV a)  (IntV b)  = IntV (a - b)
binary Mul (IntV a)  (IntV b)  = IntV (a * b)
binary Div (IntV a)  (IntV b)  = IntV (a `div` b)
binary And (BoolV a) (BoolV b) = BoolV (a && b)
binary Or  (BoolV a) (BoolV b) = BoolV (a || b)
binary LT  (IntV a)  (IntV b)  = BoolV (a < b)
binary LE  (IntV a)  (IntV b)  = BoolV (a <= b)
binary GE  (IntV a)  (IntV b)  = BoolV (a >= b)
binary GT  (IntV a)  (IntV b)  = BoolV (a > b)
binary EQ  a         b         = BoolV (a == b)


