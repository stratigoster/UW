;; Sets up an interval (70,100] and then tests whether the grade is in the interval.
;; If the grade is in the interval, returns true; else false.

(define (strange-range? grade)
  (and (< 70 grade) (<= grade 100)))