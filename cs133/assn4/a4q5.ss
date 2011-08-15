;; contract- first-row: num -> list-of-numbers
;; purpose- to create a reversed first row in the multiplication table
;; examples-
;; (first-row 5) => '(5 4 3 2 1)
;; (first-row 7) => '(7 6 5 4 3 2 1)

(define (first-row m)
  (cond
    [(zero? m) empty]
    [else (cons m (first-row (- m 1)))]))

;; testing first-row
(equal? (first-row 5) (list 5 4 3 2 1))
(equal? (first-row 1) (list 1))
(equal? (first-row 7) (list 7 6 5 4 3 2 1))


;;--------------------------------------------------------------
;; contract- create-row: num list-of-numbers -> list-of-numbers
;; purpose- to create one row of the multiplication table
;; examples-
;; (create-row 2 '(1 2 3)) => '(2 4 6)
;; (create-row 5 '(1 2 3 4 5)) => '(5 10 15 20 25)

(define (create-row n list)
  (cond
    [(empty? list) empty]
    [else (cons (* n (first list)) (create-row n (rest list)))]))

;; testing create-row
(equal? (create-row 4 '(1 2 3)) '(4 8 12))
(equal? (create-row 5 '(1 2 3 4 5)) '(5 10 15 20 25))
(equal? (create-row 2 '(1 2 3 4)) '(2 4 6 8))


;;--------------------------------------------------------------
;; contract- create-table: num list-of-numbers -> matrix
;; purpose- creates the multiplication table with the ordering of the rows reversed
;; example:
;; (create-table 5 '(1 2 3)) => '((5 10 15)
;;                                  (4 8 12)
;;                                  (3 6 9)
;;                                  (2 4 6)
;;                                  (1 2 3))

(define (create-table n list)
  (cond
    [(equal? 1 n) (cons list empty)]
    [else (cons (create-row n list) (create-table (- n 1) list))]))

;; testing create-table
(equal? (create-table 5 (list 1 2 3)) '((5 10 15) (4 8 12) (3 6 9) (2 4 6) (1 2 3)))
(equal? (create-table 4 (list 1 2 3 4)) '((4 8 12 16) (3 6 9 12) (2 4 6 8) (1 2 3 4)))
(equal? (create-table 1 (list 1 2 3 4)) '((1 2 3 4)))
(equal? (create-table 1 (list 1)) '((1)))


;;--------------------------------------------------------------
;; contract- mult-table: num num -> matrix
;; purpose- consumes 2 natural numbers, n and m, and produces a multiplication table with n rows and m columns
;; eg. (mult-table 3 4) => (list (list 1 2 3 4)
;;                               (list 2 4 6 8)
;;                               (list 3 6 9 12))
;;
;; eg. (mult-table 4 5) => (list (list 1 2 3 4 5)
;;                               (list 2 4 6 8 10)
;;                               (list 3 6 9 12 15)
;;                               (list 4 8 12 16 20))

(define (mult-table n m)
  (cond
    [(or (zero? n) (zero? m)) empty]
    [else (reverse (create-table n (reverse (first-row m))))]))

;; testing mult-table
(equal? (mult-table 3 4) '((1 2 3 4)
                          (2 4 6 8)
                          (3 6 9 12)))

(equal? (mult-table 1 2) '((1 2)))

(equal? (mult-table 2 1) '((1)
                          (2)))

(equal? (mult-table 5 6) '((1 2 3 4 5 6)
                          (2 4 6 8 10 12)
                          (3 6 9 12 15 18)
                          (4 8 12 16 20 24)
                          (5 10 15 20 25 30)))
