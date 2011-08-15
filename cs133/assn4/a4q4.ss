;; Data Definition: a matrix is a list, each of whose elements represents a row of the matrix
;; eg. a 3x4 matrix:
;; (list (list 1 4 3 2)
;;       (list 0 1 0 4)
;;       (list 2 0 1 3))

;; contract- remove-column: matrix -> matrix
;; purpose- to remove the first column of the matrix
;; eg. (remove-column (list (list 1 2)
;;                          (list 3 4)) =>
;;
;;                    (list (list 2)
;;                          (list 4))
(define (remove-column a-matrix)
  (cond
    [(empty? a-matrix) empty]
    [else (cons (rest (first a-matrix)) (remove-column (rest a-matrix)))]))

;; testing remove-column
(equal? (remove-column (list (list 1 2) (list 3 4))) (list (list 2) (list 4)))
(equal? (remove-column (list (list 1 2 3) (list 4 5 6))) (list (list 2 3) (list 5 6)))
(equal? (remove-column (list (list 1) (list 2))) (list empty empty))

;; contract- create-row: matrix -> list-of-numbers
;; purpose- to create one row of the transposed matrix
;; examples-
;; (create-row (list (list 1 2) (list 3 4))) => (list 3 1)
;; (create-row (list (list 1 2))) => (list (list 1))
(define (create-row a-matrix)
  (cond
    [(empty? a-matrix) empty]
    [else (cons (first (first a-matrix)) (create-row (rest a-matrix)))]))

;; testing create-row
(equal? (create-row (list (list 1 2) (list 3 4))) (list 1 3))
(equal? (create-row (list (list 1 2 3) (list 4 5 6) (list 7 8 9))) (list 1 4 7))
(equal? (create-row (list (list 1 2))) (list 1))

;; contract- transpose: matrix => matrix
;; purpose- to consume a matrix and produce its transpose
;; eg. (transpose (list (list 1 4 3 2)
;;                      (list 0 1 0 4)
;;                      (list 2 0 1 3))) =>
;;
;;                (list (list 1 0 2)
;;                      (list 4 1 0)
;;                      (list 3 0 1)
;;                      (list 2 4 3))
(define (transpose a-matrix)
  (cond
    [(empty? (rest (first a-matrix))) (cons (create-row a-matrix) empty)]
    [else (cons (create-row a-matrix) (transpose (remove-column a-matrix)))]))

(equal? (transpose (list (list 1 4 3 2)
                         (list 0 1 0 4)
                         (list 2 0 1 3)))
                   (list (list 1 0 2)
                         (list 4 1 0)
                         (list 3 0 1)
                         (list 2 4 3)))

(equal? (transpose (list (list 1)
                         (list 2)))
        (list (list 1 2)))

(equal? (transpose (list (list 1 2))) (list (list 1) (list 2)))

(equal? (transpose  (list (list 1))) (list (list 1)))
