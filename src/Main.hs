module Main where


type Name = String
data Expr =  Var Name
           | Lam Name Type Expr
           | App Expr Expr
           | Lit T

data Type =  TInt
           | TBool
           | TErr
           | TArr Type Type
           deriving (Show, Eq, Ord)

data T = LInt Int
            | LBool Bool
            deriving (Show, Eq, Ord)

-- G
type Env = [(Name, Type)]

-- add to G
extend :: Env -> (Name, Type) -> Env
extend env x = x : env

--check expression on valid typed. It isn't valid if we have type "TErr" else other type.
checkExpr :: Env -> Expr -> Type
-- if it is literal
checkExpr _ (Lit (LInt a)) = TInt
checkExpr _ (Lit (LBool a)) = TBool
-- if it is application
checkExpr env (App a b) = let 
                              t1 = checkExpr env a
                              t2 = checkExpr env b
                              go = if (t1 == TErr || t2 == TErr) 
                                        then TErr 
                                     else 
                                        checkOnTArr t1 t2
                          in go
-- if it is lambda function
checkExpr env (Lam n t ex) = if (t == TErr) 
                                 then TErr
                             else if (a /= TErr) 
                                      then TArr t a 
                                  else TErr
                                  where a = (checkExpr (extend env (n,t)) ex) 
-- if it is variable
checkExpr env (Var x) = case (lookup x env) of
                            Just e -> e
                            Nothing -> TErr

-- check on type "TArr" from application
checkOnTArr :: Type -> Type -> Type
checkOnTArr (TArr t1a t1r) t2 = if (t1a == t2 && t1a /= TErr && t1r /= TErr) then t1r else TErr
checkOnTArr _ _ = TErr

-- check on valid type expression. If type is "TErr" - False, else "True" 
check :: Type -> Bool
check t = if (t == TErr)
              then False
          else True

main = print ("o")
--some examples
--print (checkExpr [] (App (Lam "x" (TArr (TArr TBool TBool) (TArr TBool TBool)) (Var "x")) (Lam "y" (TArr TBool TBool) (Var "y"))) )
--print(checkExpr [] (Lam "x" (TArr (TArr TBool TBool) TBool) (Var "x")))
--print (checkExpr [] (App (Lam "x" (TArr (TArr TBool TBool) TBool) (Var "x")) (Lam "y" TBool (Var "y"))))
--print (check (checkExpr [] (Lam "y" (TArr TBool TBool) (Var "y"))))
--print (check (checkExpr [] (App (App (Lam "x" (TArr TInt TInt) (Var "x")) (Lam "y" TInt (Var "y"))) (Lit (LInt 3))) ))
--print (check (checkExpr [] (App (App (Lam "x" (TArr TInt TInt) (App (Lam "w" TBool (Var "w")) (Lit (LInt 3)) )) (Lam "y" TInt (Var "y"))) (Lit (LInt 3))) ))
--print (checkExpr [] (Lam "x" TBool (Lam "y" TBool (App (Var "z") (Var "w")))) )

