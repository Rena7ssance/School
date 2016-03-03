module CheckedStateful where

import Prelude hiding (LT, GT, EQ, id)
import Base
import Data.Maybe
import Stateful hiding (Stateful, evaluate)
import Operators

data CheckedStateful t = CST (Memory -> (Checked t, Memory))

data Checked a = Good a 
              | Error String
              | Returning Value
  deriving Show

instance Monad CheckedStateful where
  return val = CST (\m -> (Good val, m))
  (CST c) >>= f = 
    CST (\m -> case c m of
        (Returning v, m') -> (Returning v, m') 
        (Error msg, m') -> (Error msg, m')
        (Good v, m') -> let CST f' = f v in 
                          f' m')

handleReturn :: CheckedStateful Value -> CheckedStateful Value
handleReturn (CST f) = 
  CST (\m -> case f m of
    (Returning fv, m') -> (Good fv, m')
    (Error msg, m') -> (Error msg, m')
    (Good fv, m') -> (Good Undefined, m'))

evaluateReturn :: Value -> CheckedStateful Value
evaluateReturn v = 
  CST (\m -> (Returning v, m))

throwError :: String -> CheckedStateful Value
throwError e = CST (\m -> (Error e, m))
        
evaluate :: Exp -> Env -> CheckedStateful Value
-- basic operations
evaluate (Literal v) env = return v

evaluate (Unary op a) env = do
  av <- evaluate a env
  case checked_unary op av of
    Good opv -> return (opv)
    Error msg -> throwError msg

evaluate (Binary op a b) env = do
  av <- evaluate a env
  bv <- evaluate b env
  case checked_binary op av bv of
    Good opv -> return (opv)
    Error msg -> throwError msg

evaluate (If a b c) env = do
  av <- evaluate a env
  case av of
    (BoolV cond) -> evaluate (if cond then b else c) env
    _ -> throwError ("Expected boolean but found " ++ show av)

-- variables and declarations
evaluate (Declare x e body) env = do    -- non-recursive case
  ev <- evaluate e env
  let newEnv = (x, ev) : env
  evaluate body newEnv

evaluate (Variable x) env = 
  case lookup x env of
    Nothing -> throwError ("Variable " ++ x ++ " undefined")
    Just v -> return v

-- first-class functions
evaluate (Function x body) env = 
  return (ClosureV x body env)

-- TODO: add return functionality 
evaluate (Call fun arg) env = do
  funv <- evaluate fun env
  case funv of
    ClosureV x body closeEnv -> do
      argv <- evaluate arg env
      let newEnv = (x, argv) : closeEnv
      handleReturn (evaluate body newEnv)
    _ -> throwError ("Expected function but found " ++ show funv)

evaluate (Return a) env = do
  v <- evaluate a env 
  evaluateReturn v

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
    _ -> throwError ("Inavlid memory access.")

evaluate (Assign a e) env = do
  av <- evaluate a env
  ev <- evaluate e env
  case av of 
    AddressV av -> do
      updateMemory ev av --check ev?
      return ev
    _ -> throwError ("Invalid assignment.")

-- memory operations
newMemory val = CST (\mem-> (Good (AddressV (length mem)), mem ++ [val]))

readMemory i = CST (\mem-> (Good (access i mem), mem))

updateMemory val i = CST (\mem-> (Good (), update i val mem))

runStateful (CST c) = 
   let (val, mem) = c [] in val

execute exp = runStateful (evaluate exp [])

checked_unary :: UnaryOp -> Value -> Checked Value
checked_unary Not (BoolV b) = Good (BoolV (not b))
checked_unary Neg (IntV i)  = Good (IntV (-i))
checked_unary op  v         = 
    Error ("Unary " ++ show op ++ " called with invalid argument " ++ show v)

checked_binary :: BinaryOp -> Value -> Value -> Checked Value
checked_binary Add (IntV a)  (IntV b)  = Good (IntV (a + b))
checked_binary Sub (IntV a)  (IntV b)  = Good (IntV (a - b))
checked_binary Mul (IntV a)  (IntV b)  = Good (IntV (a * b))
checked_binary Div _         (IntV 0)  = Error "Divide by zero"
checked_binary Div (IntV a)  (IntV b)  = Good (IntV (a `div` b))
checked_binary And (BoolV a) (BoolV b) = Good (BoolV (a && b))
checked_binary Or  (BoolV a) (BoolV b) = Good (BoolV (a || b))
checked_binary LT  (IntV a)  (IntV b)  = Good (BoolV (a < b))
checked_binary LE  (IntV a)  (IntV b)  = Good (BoolV (a <= b))
checked_binary GE  (IntV a)  (IntV b)  = Good (BoolV (a >= b))
checked_binary GT  (IntV a)  (IntV b)  = Good (BoolV (a > b))
checked_binary EQ  a         b         = Good (BoolV (a == b))
checked_binary op  a         b         = 
    Error ("Binary " ++ show op ++ 
           " called with invalid arguments " ++ show a ++ ", " ++ show b)
