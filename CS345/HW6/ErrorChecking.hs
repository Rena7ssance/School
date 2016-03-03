module ErrorChecking where

import Prelude hiding (LT, GT, EQ, id)
import FirstClassFunctions hiding (evaluate)
import Operators

data Checked a = Good a | Error String
  deriving Show

evaluate :: Exp -> Env -> Checked Value
evaluate (Literal v) env = Good v
evaluate (Variable x) env =
  case lookup x env of
    Nothing -> Error ("Variable " ++ x ++ " undefined")
    Just v  -> Good v
evaluate (Unary op a) env =
  case evaluate a env of
    Error msg -> Error msg
    Good av ->   checked_unary op av
evaluate (Binary op a b) env =
  case evaluate a env of
    Error msg -> Error msg
    Good av ->
      case evaluate b env of
        Error msg -> Error msg
        Good bv ->
          checked_binary op av bv
evaluate (If a b c) env =
  case evaluate a env of
    Error msg -> Error msg
    Good av ->
      case av of
        BoolV av -> do
          case evaluate b env of
            Error msg -> Error msg
            Good bv ->
              case evaluate c env of
                Error msg -> Error msg
                Good cv -> do
                  if av then Good bv
                    else Good cv
        _ -> Error "non-boolean value used as condition in an if expression" 
evaluate (Declare str a b) env =
  case evaluate a env of
    Error msg -> Error msg
    Good av -> (evaluate b ((str, av) : env))
evaluate (Function str x) env = Good (ClosureV str x env)
evaluate (Call fun arg) env = 
  case evaluate fun env of
    Error msg -> Error msg
    Good funV -> 
      case funV of    
        ClosureV x body closeEnv -> 
          case evaluate arg env of
            Good argV -> evaluate body ((x,argV) : closeEnv)
            Error msg -> Error msg
        _ -> Error (show funV ++ " is not a function")   
evaluate (Try a b) env =
  case evaluate a env of
    Good av -> Good av
    Error msg ->
      case evaluate b env of
        Good bv -> Good bv
        Error msg -> Error msg

execute exp = evaluate exp []

checked_unary :: UnaryOp -> Value -> Checked Value
checked_unary Not (BoolV b) = Good (BoolV (not b))
checked_unary Neg (IntV i)  = Good (IntV (-i))
checked_unary op   v         = 
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
