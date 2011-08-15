;; Contract-
;;   make-singles: list-of-numbers -> list-of-(list-of-numbers)
;; Purpose-
;;   constructs a list of one-item lists from the given list of numbers
;; Examples-
;;   1. (make-singles empty) => empty
;;   2. (make-singles (list 1)) => (list (list 1))
;;   3. (make-singles (list 1 2 3)) => '((1) (2) (3))


(define (make-singles lon)
  (cond
    [(empty? lon) empty]
    [else (cons (cons (first lon) empty) (make-singles (rest lon)))]))


;; testing make-singles
(equal? (make-singles empty) empty)
(equal? (make-singles '(1)) '((1)))
(equal? (make-singles '(1 2 3)) '((1) (2) (3)))


;; ====================================================================================================
;; Contract-
;;   merge-all-neighbors: list-of-(list-of-numbers) -> list-of-(list-of-numbers)
;; Purpose-
;;   consumes a list-of-(list-of-numbers) and merges neighbors in the list.
;; Examples-
;;   1. (merge-all-neighbors empty) => empty
;;   2. (merge-all-neighbors '((1))) => '((1))
;;   3. (merge-all-neighbors '((2) (1))) => '((1 2))
;;   4. (merge-all-neighbors '((2 5) (3 9))) => '((2 3 5 9))
;;   5. (merge-all-neighbors '((2) (5) (9) (3))) => '((2 5) (3 9))


(define (merge-all-neighbors lolon)
  (local
      ((define (merge list1 list2)
         (cond
           [(empty? list1) list2]
           [(empty? list2) list1]
           [else
            (cond
              [(< (first list1) (first list2)) (cons (first list1) (merge (rest list1) list2))]
              [(< (first list2) (first list1)) (cons (first list2) (merge list1 (rest list2)))]
              [else (cons (first list1) (cons (first list2) (merge (rest list1) (rest list2))))])])))
  (cond
    [(empty? lolon) empty]
    [(empty? (rest lolon)) lolon]
    [else (cons (merge (first lolon) (second lolon)) (merge-all-neighbors (rest (rest lolon))))])))


;; testing merge-all-neighbors
;; 1.
(equal? (merge-all-neighbors empty) empty)

;; 2.
(equal? (merge-all-neighbors '((1))) '((1)))

;; 3.
(equal? (merge-all-neighbors '((2) (1))) '((1 2)))

;; 4.
(equal? (merge-all-neighbors '((2 5) (3 9))) '((2 3 5 9)))

;; 5.
(equal? (merge-all-neighbors '((2) (5) (9) (3))) '((2 5) (3 9)))

;; 6.
(equal? (merge-all-neighbors '((1) (2) (3))) '((1 2) (3)))

;; 7.
(equal? (merge-all-neighbors '((1 2) (3))) '((1 2 3)))

;; 8.
(equal? (merge-all-neighbors '((1 3) (1 3))) '((1 1 3 3)))

;; 9.
(equal? (merge-all-neighbors '((2) (2))) '((2 2)))


;; ====================================================================================================
;; Contract-
;;   merge-sort: lon -> lon
;; Purpose-
;;   to sort a list of numbers in ascending order
;; Examples-
;;   1. (merge-sort empty) => empty
;;   2. (merge-sort '(1)) => '(1)
;;   3. (merge-sort '(1 2)) => '(1 2)
;;   4. (merge-sort '(2 1)) => '(1 2)
;;   5. (merge-sort '(1 8 3 4 2 9)) => '(1 2 3 4 8 9)


(define (merge-sort lon)
  (local
      ((define (msort lolon)
         (cond
           [(empty? lolon) empty]
           [(empty? (rest lolon)) (first lolon)]
           [else (msort (merge-all-neighbors lolon))])))
    (msort (make-singles lon))))


;; testing merge-sort
;; 1.
(equal? (merge-sort empty) empty)

;; 2.
(equal? (merge-sort '(1)) '(1))

;; 3.
(equal? (merge-sort '(1 2)) '(1 2))

;; 4.
(equal? (merge-sort '(2 1)) '(1 2))

;; 5.
(equal? (merge-sort '(2 1 3)) '(1 2 3))

;; 6.
(equal? (merge-sort '(1 9 4 5 2 9 7)) '(1 2 4 5 7 9 9))