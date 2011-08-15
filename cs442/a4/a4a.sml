val callcc=SMLofNJ.Cont.callcc
val throw = SMLofNJ.Cont.throw

(* ('a -> 'b -> 'b ?.cont -> 'b) -> 'b -> 'a list -> 'b *)
fun scfoldl f i [] = i
|   scfoldl f i (x::xs) = (callcc (fn k => (scfoldl f (f x i k) xs)))

fun exists p L =
let
  fun f x i k =
    if p x then throw k true else false
in
  scfoldl f false L
end

fun even num = num mod 2 = 0;

exists even [1,3,5,7,9,2,3,5,7,9]; 
