(define (reduce base combine lst)
  (cond
    [(empty? lst) base]
    [else (combine (first lst) (reduce base combine (rest lst)))]))


(define (remove-duplicates lon)
  (reduce empty (lambda (x y) (cons x (filter (lambda (a) (not (equal? x a))) y))) lon))


;; testing remove-duplicates
;; 1.
(equal? (remove-duplicates empty) empty)

;; 2.
(equal? (remove-duplicates '(1 2 3)) '(1 2 3))

;; 3.
(equal? (remove-duplicates '(1 1 2 3)) '(1 2 3))

;; 4.
(equal? (remove-duplicates '(1 2 3 1 2 3 2 3 9 8 7 2)) '(1 2 3 9 8 7))

;; 5.
(equal? (remove-duplicates '(6 8 9 9 1 2 6)) '(6 8 9 1 2))

;; 6.
(equal? (remove-duplicates '(1 4 2 1 5 4)) '(1 4 2 5))