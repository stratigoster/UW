;; Contract-
;;   pair-up: symbol lon -> losn
;; Purpose-
;;   consumes a symbol and a list of numbers (lon), and produces a 
;;   list of symbols/numbers whose elements are lists of all pairs
;;   of numbers with that symbol
;; Examples-
;;   1. (pair-up 'a '(1 2 3)) => '((a 1) (a 2) (a 3))
;;   2. (pair-up 'b '(1)) => '((b 1))
;;   3. (pair-up 'b empty) => empty


(define (pair-up symb lon)
  (cond
    [(empty? lon) empty]
    [else (cons (cons symb (cons (first lon) empty)) (pair-up symb (rest lon)))]))


;; testing pair-up
;; 1.
(equal? (pair-up 'b empty) empty)

;; 2.
(equal? (pair-up 'b '(1)) '((b 1)))

;; 3.
(equal? (pair-up 'a '(1 2 3)) '((a 1) (a 2) (a 3)))

;; 4.
(equal? (pair-up 'c '(10 3 5)) '((c 10) (c 3) (c 5)))


;; --------------------------------------------------------------------------------
;; Contract-
;;   cross: los lon -> losn
;; Purpose-
;;   consumes a list of symbols (los) and a list of numbers (lon),
;;   and produces a list of symbols and numbers (losn) whose elements
;;   are lists of all possible pairs of symbols and numbers.
;; Examples-
;;   1. (cross '(a b c) '(1 2)) => '((a 1) (a 2) (b 1) (b 2) (c 1) (c 2))
;;   2. (cross '(a b c) empty) => empty
;;   3. (cross empty '(1 2 3)) => empty
;;   4. (cross empty empty) => empty


(define (cross los lon)
  (cond
    [(empty? los) empty]
    [(empty? lon) empty]
    [else (append (pair-up (first los) lon) (cross (rest los) lon))]))


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