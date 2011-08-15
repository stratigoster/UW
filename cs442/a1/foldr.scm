(define (foldr f i L)
  (if (null? L)
      i
      (f (car L) (foldr f i (cdr L)))))
