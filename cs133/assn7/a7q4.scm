(define (reduce base combine lst)
  (cond
    [(empty? lst) base]
    [else (combine (first lst) (reduce base combine (rest lst)))]))


;; Contract-
;;   keep-until: (X --> Boolean) (listof X) -> (listof X)
;; Purpose-
;;   consumes a predicate and a list, and produces a list which is the largest prefix
;;   of the consumed list such that the predicate is false for all items in the prefix
;; Examples-
;;   1. (keep-until even? '(1 2 3 4)) => '(1)
;;   2. (keep-until odd? '(2 4 6 3 9 5 10)) => '(2 4 6)
;;   3. (keep-until even? empty) => empty
;;   4. (keep-until even? '(2 3 4)) => empty


(define (keep-until pred lst)
  (reduce empty
          (lambda (x y)
            (cond
              [(not (pred x)) (cons x y)]
              [else empty]))
          lst))


;; testing keep-until
;; 1.
(equal? (keep-until even? empty) empty)

;; 2.
(equal? (keep-until even? '(1 3 5 7 8 9 11)) (list 1 3 5 7))

;; 3.
(equal? (keep-until odd? '(2 4 6 3 9 5 10)) '(2 4 6))

;; 4.
(equal? (keep-until even? '(2 3 4 5)) empty)

;; 5.
(equal? (keep-until (lambda (x) (zero? (remainder x 5))) '(1 2 3 4 6 8)) '(1 2 3 4 6 8))

;; 6.
(equal? (keep-until (lambda (x) (zero? (remainder x 5))) '(1 2 3 4 5)) '(1 2 3 4))