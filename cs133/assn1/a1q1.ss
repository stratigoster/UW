;; proper-subinterval? : num num num num -> boolean
;; To check whether one interval is a proper subinterval of another
;; Examples:
;; (proper-subinterval? 4.5 5.5 4 6) => true
;; (proper-subinterval? 4 6 4.5 5.5) => false

(define (proper-subinterval? int1-sta int1-end int2-sta int2-end)
  (and (< int2-sta int1-sta) (< int1-end int2-end)))

;; tests
(boolean=? true (proper-subinterval? 4.5 5.5 4 6))
(boolean=? false (proper-subinterval? 3 4.5 5.5 6))
(boolean=? false (proper-subinterval? 5.5 6 5.5 6))
(boolean=? false (proper-subinterval? 4 6 4.5 5.5))