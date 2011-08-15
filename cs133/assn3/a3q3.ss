;; contract- contains: num lon -> boolean
;; purpose- to consume a number and a list of numbers (lon) and outputs true iff the number is on the list
;; examples- 
;; (contains 5 (cons 1 (cons 2 (cons 5 (cons 4 empty))))) => true
;; (contains? 5 (cons 1 (cons 2 (cons 3 (cons 4 empty))))) => false
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