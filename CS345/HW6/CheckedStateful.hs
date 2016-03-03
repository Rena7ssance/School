module CheckedStateful where

import Prelude hiding (LT, GT, EQ, id)
import Base
import Operators
import Data.Maybe
import Stateful hiding (Stateful, evaluate)
import ErrorChecking hiding (evaluate)

data CheckedStateful t = CST (Memory -> (Checked t, Memory))

instance Monad CheckedStateful where
  return val = CST (\m -> (Good val, m))
  (CST c) >>= f = 
    CST (\m -> case c m of 
        (Error msg, m') -> (Error msg, m')
        (Good v, m') -> let CST f' = f v in 
                          f' m')

cs_error :: String -> CheckedStateful Value
cs_error e = CST (\m -> (Error e, m))
        
evaluate :: Exp -> Env -> CheckedStateful Value
-- basic operations
evaluate (Literal v) env = return v
evaluate (Unary op a) env = do
  av <- evaluate a env
  case c_unary op av of
    Good opv -> return (opv)
    Error msg-> cs_error msg
evaluate (Binary op a b) env = do
  av <- evaluate a env
  bv <- evaluate b env
  case c_binary op av bv of
    Good opv -> return (opv)
    Error msg -> cs_error msg
evaluate (If a b c) env = do
  av <- evaluate a env
  case av of
    (BoolV cond) -> evaluate (if cond then b else c) env
    _ -> cs_error ("Expected boolean but found " ++ show av)

-- variables and declarations
evaluate (Declare x e body) env = do    -- non-recursive case
  ev <- evaluate e env
  let newEnv = (x, ev) : env
  evaluate body newEnv
evaluate (Variable x) env = 
  case lookup x env of
    Nothing -> cs_error ("Variable " ++ x ++ " undefined")
    Just v -> return v

-- first-class functions
evaluate (Function x body) env = 
  return (ClosureV x body env)
evaluate (Call fun arg) env = do
  funv <- evaluate fun env
  case funv of
    ClosureV x body closeEnv -> do
      argv <- evaluate arg env
      let newEnv = (x, argv) : closeEnv
      evaluate body newEnv
    _ -> cs_error ("Expected function but found " ++ show funv)

-- mutation operations
evaluate (Seq a b) env = do
  evaluate a env
  evaluate b env
evaluate (Mutable e) env = do
  ev <- evaluate e env
  newMemory ev        
evaluate (Access a) env = do
  av <- evaluate a env
  case av of
    AddressV av -> readMemory av
    _ -> cs_error ("Expected Memory Address but found " ++ show av)
evaluate (Assign a e) env = do
  av <- evaluate a env
  ev <- evaluate e env
  case av of 
    AddressV av -> do
      updateMemory ev av
      return ev
    _ -> cs_error ("Cannot Assign " ++ show e ++ " to " ++ show a)

c_unary :: UnaryOp -> Value -> Checked Value
c_unary Not (BoolV b) = Good (BoolV (not b))
c_unary Neg (IntV i)  = Good (IntV (-i))
c_unary op   v         = 
    Error ("Unary " ++ show op ++ " called with invalid argument " ++ show v)

c_binary :: BinaryOp -> Value -> Value -> Checked Value
c_binary Add (IntV a)  (IntV b)  = Good (IntV (a + b))
c_binary Sub (IntV a)  (IntV b)  = Good (IntV (a - b))
c_binary Mul (IntV a)  (IntV b)  = Good (IntV (a * b))
c_binary Div _         (IntV 0)  = Error "Divide by zero"
c_binary Div (IntV a)  (IntV b)  = Good (IntV (a `div` b))
c_binary And (BoolV a) (BoolV b) = Good (BoolV (a && b))
c_binary Or  (BoolV a) (BoolV b) = Good (BoolV (a || b))
c_binary LT  (IntV a)  (IntV b)  = Good (BoolV (a < b))
c_binary LE  (IntV a)  (IntV b)  = Good (BoolV (a <= b))
c_binary GE  (IntV a)  (IntV b)  = Good (BoolV (a >= b))
c_binary GT  (IntV a)  (IntV b)  = Good (BoolV (a > b))
c_binary EQ  a         b         = Good (BoolV (a == b))
c_binary op  a         b         = 
    Error ("Binary " ++ show op ++ 
           " called with invalid arguments " ++ show a ++ ", " ++ show b)

-- might need to change these helpers, use Checked Values (add Good)
newMemory val = CST (\mem-> (Good (AddressV (length mem)), mem ++ [val]))

readMemory i = CST (\mem-> (Good (access i mem), mem))

updateMemory val i = CST (\mem-> (Good (), update i val mem))

runStateful (CST c) = 
   let (val, mem) = c [] in val

execute exp = runStateful (evaluate exp [])
