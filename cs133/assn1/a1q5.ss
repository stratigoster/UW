;; The function strange-fctn can be divided into 3 intervals:
;; 1. (-infinity,-2) and num is even
;; 2. (-2,0)
;; 3. (0,5]
;; Now we just check each of the intervals in turn in the cond expression.

(define (strange-fctn num)
  (cond
    [(< num -2) (even? num)]
    [(< 0 num) (<= num 5)]
    [(< -2 num) (< num 0)]
    [else false]))