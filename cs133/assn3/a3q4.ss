;; contract- substitute: num num lon -> lon
;; purpose- to consume 2 numbers - a target & replacement - and a list of numbers (lon), and produces a lon which is the input list with every occurrence of the target replaced by the replacement
;; e.g. (substitute 1 6 (cons 1 (cons 4 (cons 2 (cons 1 (cons 9 empty)))))) =>
;;                      (cons 6 (cons 4 (cons 2 (cons 6 (cons 9 empty)))))
;; (substitute 1 6 (cons 2 (cons 4 (cons 3 (cons 7 (cons 9 empty)))))) =>
;;                 (cons 2 (cons 4 (cons 3 (cons 7 (cons 9 empty)))))
(define (substitute target replacement numlist)
  (cond
    [(empty? numlist) empty]
    [else
     (cond
       [(= target (first numlist)) (cons replacement (substitute target replacement (rest numlist)))]
       [else (cons (first numlist) (substitute target replacement (rest numlist)))])]))

;; tests
(equal? (substitute 1 6 (cons 1 (cons 4 (cons 2 (cons 1 (cons 9 empty))))))
                        (cons 6 (cons 4 (cons 2 (cons 6 (cons 9 empty))))))

(equal? (substitute 1 6 (cons 2 (cons 4 (cons 3 (cons 7 (cons 9 empty))))))
                        (cons 2 (cons 4 (cons 3 (cons 7 (cons 9 empty))))))