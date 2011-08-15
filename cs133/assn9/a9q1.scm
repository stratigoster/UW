;; Contract-
;;   prime-factors: num[>=1] -> lon
;; Purpose-
;;   consumes a natural number n and produces a list of numbers
;;   in descending order representing its prime factorization
;; Examples-
;;   1. (prime-factors 1) => empty
;;   2. (prime-factors 2) => '(2)
;;   3. (prime-factors 6) => '(3 2)
;;   4. (prime-factors 60) => '(5 3 2 2)


(define (prime-factors n)
  (local
      ;; Contract-
      ;;  ifactor: num num lon -> lon
      ;;  where lon is the 'accumulator invariant'; it is the prime factorization of n found so far.
      ((define (ifactor num count numlist)
         (cond
           [(equal? 1 num) numlist]
           [else
            (cond
              [(zero? (remainder num count)) (ifactor (/ num count) count (cons count numlist))]
              [else (ifactor num (add1 count) numlist)])])))
    (ifactor n 2 empty)))


;; testing prime-factors
;; 1.
(equal? (prime-factors 1) empty)

;; 2.
(equal? (prime-factors 2) '(2))

;; 3.
(equal? (prime-factors 4) '(2 2))

;; 4.
(equal? (prime-factors 6) '(3 2))

;; 5.
(equal? (prime-factors 12) '(3 2 2))

;; 6.
(equal? (prime-factors 60) '(5 3 2 2))