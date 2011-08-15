(define (reduce base combine lst)
  (cond
    [(empty? lst) base]
    [else (combine (first lst) (reduce base combine (rest lst)))]))


(define (cross los lon)
  (reduce empty
          (lambda (x y)
            (append (map (lambda (n) (cons x (cons n empty))) lon) y))
          los))


;; testing cross
;; 1.
(equal? (cross empty '(1 2 3)) empty)

;; 2.
(equal? (cross '(a b c) empty) empty)

;; 3.
(equal? (cross empty empty) empty)

;; 4.
(equal? (cross '(a) '(1 2)) '((a 1) (a 2)))

;; 5.
(equal? (cross '(a b c) '(1 2)) '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2)))

;; 6.
(equal? (cross '(x y z) '(7 6 3 2))
        '((x 7) (x 6) (x 3) (x 2) (y 7) (y 6) (y 3) (y 2) (z 7) (z 6) (z 3) (z 2)))