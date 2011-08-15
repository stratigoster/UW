(define (foldl f i L)
  (if (null? L)
      i
      (foldl f (f (car L) i) (cdr L))))
