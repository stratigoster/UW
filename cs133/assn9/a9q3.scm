(define (total numlist)
  (local ((define (myfn z)
            (cond
              [(empty? z) 0]
              [else (first z)])))
  (reverse (foldl (lambda (x y) (cons (+ x (myfn y)) y)) empty numlist))))


;; testing total
;; 1.
(equal? (total empty) empty)

;; 2.
(equal? (total '(1)) '(1))

;; 3.
(equal? (total '(1 2)) '(1 3))

;; 4.
(equal? (total '(1 2 3)) '(1 3 6))

;; 5.
(equal? (total '(1 2 0 8)) '(1 3 3 11))

;; 6.
(equal? (total '(4 3 2)) '(4 7 9))
