;; Contract-
;;   unmerge: alon alon -> alon
;; Purpose-
;;   consumes 2 lists of numbers, each of which is sorted and contains any number
;;   at most once, and produces the sorted list that would result from taking the
;;   first input list and removing any number that occurs on the second input list
;; Examples-
;;   1. (unmerge (list 1 2 3 4 5 6) empty) => (list 1 2 3 4 5 6)
;;   2. (unmerge (list 1 2 3 4 5 6) (list 2 4 6)) => (list 1 3 5)
;;   3. (unmerge empty (list 1 2 3)) => empty
;;   4. (unmerge (list 1 2 3) (list 1 2 3)) => empty


(define (unmerge list1 list2)
  (cond
    [(empty? list1) empty]
    [(empty? list2) list1]
    [else
     (cond
       [(equal? (first list1) (first list2)) (unmerge (rest list1) (rest list2))]
       [(< (first list2) (first list1)) (cons (first list1) (unmerge (rest list1) (rest list2)))]
       [else (cons (first list1) (unmerge (rest list1) list2))])]))


;; testing unmerge
;; 1.
(equal? (unmerge (list 1 2 3) empty) (list 1 2 3))

;; 2.
(equal? (unmerge empty (list 1 2 3)) empty)

;; 3.
(equal? (unmerge (list 1 2 3 4 5 6) (list 2 4 6)) (list 1 3 5))

;; 4.
(equal? (unmerge (list 4 5 6 7 9 32) (list 2 3 6 9)) (list 4 5 7 32))

;; 5.
(equal? (unmerge (list 6 9 21) (list 6 9 21)) empty)