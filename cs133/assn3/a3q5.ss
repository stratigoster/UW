;; contract- remove-duplicates: lon -> lon
;; purpose- to consume a list of numbers (lon) and produce the list with all but the first occurrence of every number removed
;; examples-
;; (remove-duplicates (cons 1 (cons 3 (cons 1 (cons 4 empty))))) => (cons 1 (cons 3 (cons 4 empty)))
;; (remove-duplicates (cons 1 (cons 2 (cons 3 empty)))) => (cons 1 (cons 2 (cons 3 empty)))
(define (remove-duplicates numlist)
  (reverse (remove (reverse numlist)))) ;; sends in a reversed list, so it has to reverse the output to make it the right order

;; contract- contains: num lon -> boolean
;; purpose- to consume a number and a list of numbers (lon) and outputs true iff the number is on the list
;; examples-
;; (contains 5 (cons 1 (cons 2 (cons 5 (cons 4 empty))))) => true
;; (contains 10 (cons 1 (cons 2 (cons 5 (cons 4 empty))))) => false
(define (contains? num numlist)
  (cond
    [(empty? numlist) false]
    [else
     (cond
       [(= num (first numlist)) true]
       [else (contains? num (rest numlist))])]))

;; tests
(equal? (contains? 5 (cons 1 (cons 2 (cons 5 (cons 4 empty))))) true)
(equal? (contains? 5 (cons 1 (cons 2 (cons 3 (cons 4 empty))))) false)
(equal? (contains? 5 (cons 5 (cons 2 (cons 5 (cons 4 empty))))) true)

;; contract- remove: lon -> lon
;; purpose- to perform the actual removal of the duplicated elements
;; it has the reversed list passed in, then checks each element to see if it occurs again in the list. If it does, then it skips that element otherwise the element is added to the new list
;; examples:
;; (remove (cons 4 (cons 2 (cons 4 empty)))) => (cons 2 (cons 4 empty))
;; (remove (cons 4 (cons 1 (cons 2 (cons 1 (cons 4 empty)))))) => (cons 2 (cons 1 (cons 4 empty)))
(define (remove numlist)
  (cond
    [(empty? numlist) empty]
    [(contains? (first numlist) (rest numlist)) (remove (rest numlist))]
    [else (cons (first numlist) (remove (rest numlist)))]))

;; testing remove
(equal? (remove (cons 4 (cons 2 (cons 4 empty)))) (cons 2 (cons 4 empty)))
(equal? (remove (cons 4 (cons 1 (cons 2 (cons 1 (cons 4 empty)))))) (cons 2 (cons 1 (cons 4 empty))))

;; tests
(equal? (remove-duplicates (cons 1 (cons 2 (cons 3 empty)))) (cons 1 (cons 2 (cons 3 empty))))

(equal? (remove-duplicates (cons 1 (cons 4 (cons 2 (cons 1 (cons 5 (cons 4 empty)))))))
        (cons 1 (cons 4 (cons 2 (cons 5 empty)))))

(equal? (remove-duplicates (cons 1 (cons 3 (cons 1 (cons 4 empty))))) (cons 1 (cons 3 (cons 4 empty))))
