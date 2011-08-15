;; Contract-
;;   keepfirst: alon N -> alon
;; Purpose-
;;   consumes a list of numbers (alon) and a natural number (n),
;;   and produces a list containing only the first n entries of alon.
;;   If n is greater than the length of alon, the list produced is just alon.
;; Examples-
;;   1. (keep-first empty 5) => empty
;;   2. (keep-first (list 1 2 3 4) 2) => (list 1 2)
;;   3. (keep-first (list 1 2 3 4) 5) => (list 1 2 3 4)
;;   4. (keep-first (list 1 2 3) 0) => empty


(define (keep-first alon n)
  (cond
    [(empty? alon) empty]
    [(zero? n) empty]
    [else (cons (first alon) (keep-first (rest alon) (- n 1)))]))


;; testing keep-first
;; 1.
(equal? (keep-first empty 5) empty)

;; 2.
(equal? (keep-first (list 1 2 3 4) 2) (list 1 2))

;; 3.
(equal? (keep-first (list 1 2 3) 5) (list 1 2 3))

;; 4.
(equal? (keep-first (list 1 2 3 1 6) 5) (list 1 2 3 1 6))

;; 5.
(equal? (keep-first (list 1 2 3) 0) empty)


;;--------------------------------------------------------------------------------
;; Contract-
;;   drop-first: alon N -> alon
;; Purpose-
;;   consumes a list of numbers (alon) and a natural number (n),
;;   and removes the first n entries of alon. If n is greater than
;;   the length of alon, the list produced is empty.
;; Examples-
;;  1. (drop-first (list 1 3 4) 5) => empty
;;  2. (drop-first (list 1 2 3 4) 3) => (list 1)
;;  3. (drop-first empty 5) => empty
;;  4. (drop-first (list 1 9 8 2 3 2) 2) => (list 8 2 3 2)
;;  5. (drop-first (list 1 2 3) 0) => (list 1 2 3)
;;  6. (drop-first (list 1 2 3) 10) => empty


(define (drop-first alon n)
  (cond
    [(empty? alon) empty]
    [(zero? n) alon]
    [else (drop-first (rest alon) (- n 1))]))


;; testing drop-first
;; 1.
(equal? (drop-first (list 1 2 3) 5) empty)

;; 2.
(equal? (drop-first (list 1 2 3 4) 3) (list 4))

;; 3.
(equal? (drop-first empty 5) empty)

;; 4.
(equal? (drop-first (list 1 2 3 4 5) 2) (list 3 4 5))

;; 5.
(equal? (drop-first (list 1 2 3) 0) (list 1 2 3))

;; 6.
(equal? (drop-first (list 1 2 3) 10) empty)


;;--------------------------------------------------------------------------------
;; Contract-
;;   sublist: alon N N -> alon
;; Purpose-
;;   consumes a list of numbers (alon) and 2 natural numbers, m and n,
;;   and produces the sublist consisting of the mth through nth entries
;;   (whichever of these are present in alon)
;; Examples-
;;   1. (sublist empty 3 5) => empty
;;   2. (sublist (list 1) 1 2) => (list 1)
;;   3. (sublist (list 1) 3 6) => empty
;;   4. (sublist (list 1 2 3 4 5) 3 5) => (list 3 4 5)
;;   5. (sublist (list 1 2 3) 1 3) => (list 1 2 3)


(define (sublist alon m n)
  (keep-first (drop-first alon (- m 1)) (- n m -1)))


;; testing sublist
;; 1.
(equal? (sublist empty 3 5) empty)

;; 2.
(equal? (sublist (list 1) 1 2) (list 1))

;; 3.
(equal? (sublist (list 1) 3 6) empty)

;; 4.
(equal? (sublist (list 1 2 3 4 5) 2 4) (list 2 3 4))

;; 5.
(equal? (sublist (list 1 2 3) 1 3) (list 1 2 3))