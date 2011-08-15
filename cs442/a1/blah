(define Yprime
  '(fun f ((fun x (f (fun y ((x x) y)))) (fun x (f (fun y ((x x) y)))))))

(define lc-if
  '(fun b (fun t (fun f (((b (fun x t)) (fun x f)) x)))))

(define lc-sum 
  `(,Yprime 
      (fun s
        (fun x 
          (fun y 
            (((,lc-if (,lc-zero? x)) y) ((s (,lc-pred x)) (,lc-succ y))))))))
