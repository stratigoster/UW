;; contract- add: num num -> num
;; purpose- to consume 2 natural numbers, n and x, and produce n+x without using Scheme's +
;; examples- (add 5 3) => 8
;; (add 5 0) => 5
(define (add n x)
  (cond
    [(zero? x) n]
    [else (add1 (add n (sub1 x)))]))

;; testing add
(equal? (add 5 3) 8)
(equal? (add 5 0) 5)
(equal? (add 0 0) 0)
(equal? (add 0 10) 10)

;; contract- mul: num num -> num
;; purpose- to consume 2 natural numbers, n and x, and produce n*x without using the built-in functions +,-,*,/
;; examples- (mul 5 4) => 20
;; (mul 5 0) => 0
(define (mul n x)
  (cond
    [(or (zero? x) (zero? n)) 0]
    [else (add (max n x) (mul (max n x) (sub1 (min n x))))]))

;; testing mul
(equal? (mul 3 5) 15)
(equal? (mul 10 10) 100)
(equal? (mul 5 0) 0)
(equal? (mul 0 5) 0)

;; contract- minus: num num -> num
;; purpose- to consume 2 natural numbers, n and x, and produce their difference: n-x without using the built-in functions +,-,*,/
;; examples- (minus 5 4) => 1
;; (minus 5 0) => 0
(define (minus n x)
  (cond
    [(zero? x) n]
    [else (sub1 (minus n (sub1 x)))]))

;; testing minus
(equal? (minus 5 3) 2)
(equal? (minus 5 0) 5)

;; contract- div: num num -> num
;; purpose- to consume 2 natural numbers, n and x, and produce the quotient of n/x without using the built-in functions +,-,*,/
;; examples- (div 15 4) => 3
;; (div 4 4) => 1
(define (div n x)
  (cond
    [(zero? x) (error 'Error "Cannot divide by zero")] ;; cannot divide by 0
    [(< n x) 0]
    [else (add1 (div (minus n x) x))]))

;; testing div
(equal? (div 15 4) 3)
(equal? (div 4 4) 1)
(equal? (div 20 5) 4)