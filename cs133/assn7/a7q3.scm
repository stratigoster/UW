(define (reduce base combine lst)
  (cond
    [(empty? lst) base]
    [else (combine (first lst) (reduce base combine (rest lst)))]))


(define (my-filter pred lst)
  (reduce empty
          (lambda (x y)
            (cond
              [(pred x) (cons x y)]
              [else y]))
          lst))


;; testing my-filter
;; 1.
(equal? (my-filter odd? empty) empty)

;; 2.
(equal? (my-filter even? '(1 2 3 4 5 6 7 8)) '(2 4 6 8))

;; 3.
(equal? (my-filter (lambda (x) (zero? (remainder x 3))) '(1 2 3 4 5 6)) '(3 6))

;; 4.
(equal? (my-filter (lambda (x) (equal? 2 x)) '(1 2 3 4 2 4)) '(2 2))


;;  Yes, reduce is essentially the same as foldr. If one looks at the contract for
;;  foldr, it is essentially the same as that of reduce (only the 'function' and 'base'
;;  parameters are 'passed in' in different orders). In addition, the list items are
;;  processed in the same order as that of reduce ie. from the first item on the list
;;  to the last, and at each step of the recursion, the same processing takes place
;;  in both functions, thus they produce the same result and so are essentially the same.