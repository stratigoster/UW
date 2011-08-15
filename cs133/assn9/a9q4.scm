(define (remove-duplicates somelist)
  ;; acc is the output list with all elements in somelist encountered so far, minus those that are duplicates.
  (local ((define (remove somelist acc)
            (cond
              [(empty? somelist) acc]
              [else
               (cond
                 [(boolean? (member (first somelist) (rest somelist))) (remove (rest somelist) (cons (first somelist) acc))]
                 [else (remove (rest somelist) acc)])])))
    (remove (reverse somelist) empty)))


;; testing remove-duplicates
;; 1.
(equal? (remove-duplicates empty) empty)

;; 2.
(equal? (remove-duplicates '(1)) '(1))

;; 3.
(equal? (remove-duplicates '(1 1)) '(1))

;; 4.
(equal? (remove-duplicates '(1 2 3 1)) '(1 2 3))

;; 5.
(equal? (remove-duplicates '(1 2 3 2 3 4 1 9 8 9 3)) '(1 2 3 4 9 8))

;; 6.
(equal? (remove-duplicates '(1 4 2 1 5 4)) '(1 4 2 5))