data Term = Var String | Abs String Term | App Term Term | Prim Primitive | INT Int
data Primitive = IsZero | Succ deriving Show

data SContents = Stack String Term [EContents] | StackTerm Term deriving Show
data EContents = Env String SContents deriving Show
data CContents = Control Term | Apply deriving Show
data DContents = Dump [SContents] [EContents] [CContents] deriving Show
data SECDConfig = SECD ([SContents], [EContents], [CContents], [DContents]) 

-- make Term printable in readable format
instance Show Term where 
  show (Var x) = x
  show (Abs x e) = "\\" ++ x ++ "." ++ show e
  show (App m n) = "(" ++ show m ++ ")(" ++ show n ++ ")"
  show (Prim p) = show p
  show (INT p) = show p

-- print contents of SECD machine
instance Show SECDConfig where
  show (SECD (s,e,c,d)) =
    "S = " ++ show s ++ "\nE = " ++ show e ++ "\nC = " ++ show c ++ "\nD = " ++ show d

-- lookup variable in environment; no free variables allowed
lookUp :: (String,[EContents]) -> SContents
lookUp (var,(Env v s):envs)
  | var==v = s
  | otherwise = lookUp(var,envs)

-- maps one step of the SECD configuration to the one that immediately follows it
secdOneStep :: SECDConfig -> SECDConfig

secdOneStep (SECD (s, e, (Control (Var x)):c', d))
  = SECD (lookUp(x,e):s, e, c', d)

secdOneStep (SECD (s, e, (Control (Abs x m)):c', d))
  = SECD ((Stack x m e):s, e, c', d)

secdOneStep (SECD (s, e, (Control (App m n)):c', d))
  = SECD (s, e, (Control n):(Control m):Apply:c', d)

secdOneStep (SECD ((StackTerm (Prim prim)):(StackTerm n):s', e, Apply:c', d))
  = SECD (s', e, (Control $ applyPrim prim n):c', d)

secdOneStep (SECD ((Stack x m e1):n:s', e, Apply:c', d))
  = SECD ([], (Env x n):e1, [Control m], (Dump s' e c'):d)

secdOneStep (SECD ([m], e, [], (Dump s' e' c'):d'))
  = SECD (m:s', e', c', d')

secdOneStep (SECD ([m], e, [], []))
  = SECD ([m], e, [], [])

-- handle primitives and integers
secdOneStep (SECD (s, e, (Control (INT i)):c', d))
  = SECD ((StackTerm (INT i)):s, e, c', d)

secdOneStep (SECD (s, e, (Control (Prim p)):c', d))
  = SECD ((StackTerm (Prim p)):s, e, c', d)

applyPrim :: Primitive -> Term -> Term

applyPrim IsZero (INT i) = (Abs "x" (Abs "y" (Var (if i==0 then "x" else "y"))))
applyPrim Succ (INT i) = (INT (i+1))

get :: SContents -> Term
get (StackTerm t) = t
get (Stack x t e) = foldl subst (Abs x t) e

-- performs lambda calculus substitution as described in notes
subst :: Term -> EContents -> Term
subst (Var y) (Env x t)
    | x == y    = (get t)
    | otherwise = Var y
subst (Abs y m) (Env x t)
    | x == y    = Abs x m 
    | otherwise = Abs y (subst m (Env x t))
subst (App m n) (Env x t) =
    App (subst m (Env x t)) (subst n (Env x t))

reduce :: Term -> Term
reduce x 
  = get $ stack $ r1 (SECD ([], [], [Control x], []))
    where
      r1 (SECD (s,e,[],[])) = SECD (s,e,[],[])
      r1 (SECD (s,e,c,d)) = r1 (secdOneStep (SECD (s,e,c,d)))
      stack (SECD ([s],_,_,_)) = s

s1 = secdOneStep

-- Test Cases
lc_true = Abs "x" (Abs "y" (Var "x"))
lc_false = Abs "x" (Abs "y" (Var "y"))
lc_not = Abs "b" (App (App (Var "b") lc_false) lc_true)
lc_iff = Abs "b" (Abs "t" (Abs "f" (App (App (Var "b") (Var "t")) (Var "f"))))
lc_cons = Abs "h" (Abs "t" (Abs "s" (App (App (Var "s") (Var "h")) (Var "t"))))
lc_car = Abs "l" (App (Var "l") lc_true)
lc_cdr = Abs "l" (App (Var "l") lc_false)
lc_nil = Abs "s" lc_true
lc_null = Abs "l" (App (Var "l") (Abs "h" (Abs "t" lc_false)))

cn_0 = (Abs "f" (Abs "z" (Var "z")))
cn_I = (Abs "f" (Abs "z" (App (Var "f") (Var "z"))))
cn_II = (Abs "f" (Abs "z" (App (Var "f") (App (Var "f") (Var "z")))))
cn_III = (Abs "f" (Abs "z" (App (Var "f") (App (Var "f") (App (Var "f") (Var "z"))))))
cn_plus = (Abs "m" (Abs "n" (Abs "s"
            (Abs "z" (App (App (Var "m") (Var "s"))
            (App (App (Var "n") (Var "s")) (Var "z")))))))
cn_mult = (Abs "m" (Abs "n" (Abs "f" (App (Var "n") (App (Var "m") (Var "f"))))))
cn_pow = (Abs "m" (Abs "n" (App (Var "n") (Var "m"))))
cn_zero = (Abs "m" (App (App (Var "m") (Abs "x" lc_false)) lc_true))
cn_zz = (App (App lc_cons cn_0) cn_0)
cn_ss = (Abs "p" (App (App lc_cons (App lc_cdr (Var "p")))
                      (App (App cn_plus cn_I) (App lc_cdr (Var "p")))))
cn_prd = (Abs "m" (App lc_car (App (App (Var "m") cn_ss) cn_zz)))
cn_sub = (Abs "m" (Abs "n" (App (App (Var "n") cn_prd) (Var "m"))))

-- converts church numeral to decimal format
to_Int = Abs "n" (App (App (Var "n") (Prim Succ)) (INT 0))

e1 = App to_Int (App (App cn_sub cn_III) cn_II)
e2 = App to_Int (App (App cn_mult cn_III) cn_III)
e3 = App to_Int (App (App cn_pow cn_II) cn_III)
e4 = App (Prim Succ) (INT 0)


