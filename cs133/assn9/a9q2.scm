(define (my-foldl op base somelist)
  (local
      ;; acc represents the output list with the op performed on each element of somelist encountered so far
      ((define (fold somelist acc)
         (cond
           [(empty? somelist) acc]
           [else (fold (rest somelist) (op (first somelist) acc))])))
    (fold somelist base)))


;; testing my-foldl
;; 1.
(equal? (my-foldl * 1 '(1 2 3 4)) (foldl * 1 '(1 2 3 4)))

;; 2.
(equal? (my-foldl + 1 '(1 2 3 4)) (foldl + 1 '(1 2 3 4)))

;; 3.
(equal? (my-foldl (lambda (x y) (* (+ x y) (* x y))) 1 '(1 2 3 4)) (foldl (lambda (x y) (* (+ x y) (* x y))) 1 '(1 2 3 4)))


;; ====================================================================================================
(define (invert somelist)
  (my-foldl cons empty somelist))


;; testing invert
;; 1.
(equal? (invert empty) (reverse empty))

;; 2.
(equal? (invert '(1)) (reverse '(1)))

;; 3.
(equal? (invert '(1 2)) (reverse '(1 2)))

;; 4.
(equal? (invert '(1 2 3)) (reverse '(1 2 3)))

;; 5.
(equal? (invert '(1 2 2 4 6 9 9)) (reverse '(1 2 2 4 6 9 9)))