(define-struct clock (hours mins secs))

;; tick: clock -> clock
;; to consume a clock and return a clock whose time is 1 second later
(define (tick a-clock)
  (cond
    [(< (+ (clock-secs a-clock) 1) 60) (make-clock (clock-hours a-clock) (clock-mins a-clock) (+ (clock-secs a-clock) 1))]
    [(< (+ (clock-mins a-clock) 1) 60) (make-clock (clock-hours a-clock) (+ (clock-mins a-clock) 1) 0)]
    [(< (+ (clock-hours a-clock) 1) 13) (make-clock (+ (clock-hours a-clock) 1) 0 0)]
    [else (make-clock 1 0 0)]))

;; tests
(equal? (tick (make-clock 10 9 1)) (make-clock 10 9 2))
(equal? (tick (make-clock 10 9 59)) (make-clock 10 10 0))
(equal? (tick (make-clock 10 59 59)) (make-clock 11 0 0))
(equal? (tick (make-clock 12 59 59)) (make-clock 1 0 0))