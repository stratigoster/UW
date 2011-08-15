exception NOMORE

abstype 'a set = Set of unit -> unit -> 'a
with
  fun newset L = 
    let
      fun foo t () =
        let
          val tail = t
        in
          if null (!tail) then raise NOMORE
          else 
            let 
              val head = ref (hd (!tail))
            in
              (tail := tl (!tail); !head)
            end
        end
    in
      (Set (fn () => foo (ref L)))
    end

  fun mknext (Set f) =
    f ()

  fun member e S =
    let
      val iter_S = mknext S
      fun check () =
        e = iter_S () orelse check () handle NOMORE => false
    in
      check ()
    end 

  fun empty S =
    let
      fun check _ = false
    in
      check (mknext S ()) handle NOMORE => true
    end

  fun intersect S T =
    let
      val iter_S = mknext S
      fun check () =
        let
          val head = iter_S ()
        in
          if member head T handle NOMORE => false then head
          else check ()
        end
    in
      (Set (fn () => fn () => check ()))
    end

  fun diff S T =
    let
      val iter_S = mknext S
      fun check () =
        let
          val head = iter_S ()
        in
          if not (member head T) handle NOMORE => false then head
          else check ()
        end
    in
      (Set (fn () => fn () => check ()))
    end

  fun union S T =
    let
      fun u2 S T =
        let
          val iter_S = mknext S
          val iter_T = mknext T
        in
          (Set (fn () => fn () => iter_S () handle NOMORE => iter_T ()))
        end
    in
      diff (u2 S T) (intersect S T)
    end

  fun forall S f =
    let
      val iter_S = mknext (!S)
    in
      S := (Set (fn () => fn () => f (iter_S ())))
    end
end

(* some testcases
fun times2 x = x * 2;
val setA = newset [1,2,3];
val seqA = mknext setA;
val refA = ref setA;
forall refA times2;
val seqB = mknext (!refA);
val setB = newset [1,2,3]
val setC = newset [3,5,6]
val unionAB = union setA setB
val seqAB = mknext unionAB

val intAB = intersect setA setB
*)
