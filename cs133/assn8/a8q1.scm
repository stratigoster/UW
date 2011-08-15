;; Contract-
;;   tabulate-div: num[>=1] -> lon
;; Purpose-
;;   consumes a number n and tabulates the list of all its divisors,
;;   starting with 1 and ending in n.
;; Examples-
;;   1. (tabulate-div 1) => '(1)
;;   2. (tabulate-div 2) => '(1 2)
;;   3. (tabulate-div 3) => '(1 3)
;;   4. (tabulate-div 4) => '(1 2 4)
;;   5. (tabulate-div 13) => '(1 13)


(define (tabulate-div n)
  (local
      ((define (tab-div d)
         (cond
           [(equal? 1 n) (list 1)]
           [(equal? d (add1 (quotient n 2))) (list n)]
           [else
            (cond
              [(equal? (remainder n d) 0) (cons d (tab-div (add1 d)))]
              [else (tab-div (add1 d))])])))
    (tab-div 1)))


;; testing tabulate-div
;; 1.
(equal? (tabulate-div 1) '(1))

;; 2.
(equal? (tabulate-div 2) '(1 2))

;; 3.
(equal? (tabulate-div 3) '(1 3))

;; 4.
(equal? (tabulate-div 4) '(1 2 4))

;; 5.
(equal? (tabulate-div 5) '(1 5))

;; 6.
(equal? (tabulate-div 12) '(1 2 3 4 6 12))

;; 7.
(equal? (tabulate-div 13) '(1 13))