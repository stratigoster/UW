;; Contract-
;;   create-matrix: num lon -> list-of-(list-of-numbers)
;; Purpose-
;;   consumes a number n and a list of n^2 numbers, and produces
;;   a list of n lists of n numbers
;; Examples-
;;   1. (create-matrix 1 '(1)) => '((1))
;;   2. (create-matrix 2 '(1 2 3 4)) => '((1 2) (3 4))
;;   3. (create-matrix 3 '(1 2 3 4 5 6 7 8 9)) => '((1 2 3) (4 5 6) (7 8 9))


(define (create-matrix n lon)
  (local
      ;; Contract-
      ;;   create-row: num lon -> lon
      ;; Purpose-
      ;;   extracts the first n elements of a lon
      ((define (create-row count lon)
         (cond
           [(zero? count) empty]
           [else (cons (first lon) (create-row (sub1 count) (rest lon)))]))
       ;; Contract-
       ;;   delete-row: num lon -> lon
       ;; Purpose-
       ;;   consumes a lon and produces a lon which is the input list with the
       ;;   first n elements removed
      (define (delete-row count lon)
         (cond
           [(zero? count) lon]
           [else (delete-row (sub1 count) (rest lon))]))
      (define (make-matrix x)
         (cond
           [(empty? x) empty]
           [else (cons (create-row n x) (make-matrix (delete-row n x)))])))
    (make-matrix lon)))


;; testing create-matrix
;; 1.
(equal? (create-matrix 1 '(1)) '((1)))

;; 2.
(equal? (create-matrix 2 '(1 2 3 4)) '((1 2) (3 4)))

;; 3.
(equal? (create-matrix 3 '(1 2 3 4 5 6 7 8 9)) '((1 2 3) (4 5 6) (7 8 9)))

;; 4.
(equal? (create-matrix 4 '(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16))
        '((1 2 3 4) (5 6 7 8) (9 10 11 12) (13 14 15 16)))