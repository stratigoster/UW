signature NFASIG = sig
  eqtype Q
  eqtype Sigma
  val init : Q
  val delta : Q * Sigma -> Q list 
  val accepting : Q list
end

functor NFA (Spec : NFASIG) : sig
  val run : Spec.Sigma list -> bool
end =
struct
  fun run l =
    let
      fun run' s [] = s
      |   run' s (x::xs) =
            run' (foldl (fn (state, i) => (Spec.delta(state, x)) @ i) nil s) xs

      val final = run' [Spec.init] l

      fun member _ [] = false
      |   member x (y::ys) = x = y orelse member x ys

      fun intersect x y =
        foldl (fn (a,b) => a orelse b) false (map (fn a => member a y) x)
    in
      intersect final Spec.accepting
    end
end

signature DFASIG = sig
  eqtype Q
  eqtype Sigma
  val init : Q
  val delta : Q * Sigma -> Q
  val accepting : Q list
end

functor DFA (Spec : DFASIG) : sig
  val run : Spec.Sigma list -> bool
end =
struct
  fun run l =
    let
      fun run' s [] = s
      |   run' s (x::xs) = run' (Spec.delta(s, x)) xs

      val final = run' Spec.init l

      fun member _ [] = false
      |   member x (y::ys) = x = y orelse member x ys
    in
      member final Spec.accepting
    end
end

functor DFAtoNFA (Spec : DFASIG) : NFASIG =
struct
  type Q = Spec.Q
  type Sigma = Spec.Sigma
  val init = Spec.init
  fun delta (state, x) = [Spec.delta (state, x)]
  val accepting = Spec.accepting
end

(* NFA to recognize binary strings that end in zero *)
structure EndsInZero_NFA : NFASIG =
struct
  exception Bad
  type Sigma = int
  datatype Q = A | B | C
  val init = A
  val accepting = [B]

  fun delta (A, 1) = [A]
  |   delta (A, 0) = [B,C]
  |   delta (B, 1) = [A]
  |   delta (B, 0) = [B]
  |   delta (C, 1) = [A]
  |   delta (C, 0) = [C]
  |   delta _ = raise Bad
end

(* DFA to recognize binary strings with an even number of zeros
   and an odd number of ones *)
structure Even0sOdd1s_DFA : DFASIG =
struct
  exception Bad
  type Sigma = int
  datatype QAux = ODD | EVEN
  type Q = QAux * QAux
  val init = (EVEN, EVEN)
  val accepting = [(EVEN, ODD)]

  fun toggle ODD = EVEN
  |   toggle _ = ODD

  fun delta ((x,y), 0) = (toggle x, y)
  |   delta ((x,y) , 1) = (x, toggle y)
  |   delta _ = raise Bad
end

(* computes cartesian product of lists A and B *)
fun cartprod A B =
  foldr (fn (a,b) => (foldr (fn (c,d) => (a,c) :: d) nil B) @ b) nil A

functor Intersection (structure Spec1 : DFASIG
                            and Spec2 : DFASIG
(*                      sharing type Spec1.Q = Spec2.Q*)
                      sharing type Spec1.Sigma = Spec2.Sigma) : DFASIG =
struct
  type Q = Spec1.Q * Spec2.Q
  type Sigma = Spec1.Sigma
  val init = (Spec1.init, Spec2.init)
  fun delta ((s1, s2), x) = (Spec1.delta(s1, x), Spec2.delta(s2, x))
  val accepting = cartprod Spec1.accepting Spec2.accepting
end

(* DFA to recognize binary strings with an even number of zeros *)
structure Even0s_DFA : DFASIG =
struct
  exception Bad
  type Sigma = int
  datatype Q = EVEN | ODD | START
  val init = START
  val accepting = [EVEN]

  fun delta (START, 1) = EVEN
  |   delta (START, 0) = ODD
  |   delta (ODD, 1) = ODD
  |   delta (ODD, 0) = EVEN
  |   delta (EVEN, 1) = EVEN
  |   delta (EVEN, 0) = ODD
  |   delta _ = raise Bad
end

structure foo = Intersection (structure Spec1=Even0s_DFA and Spec2=Even0sOdd1s_DFA)
structure fooInterp = DFA(foo)
