(define (profit ticket-price)
  (local
    ((define (attendees ticket-price)
       (+ 120
          (* (/ 15 .10) (- 5.00 ticket-price))))
    (define (cost ticket-price)
       (+ 180
          (* 0.04 (attendees ticket-price))))
    (define (revenue ticket-price)
       (* (attendees ticket-price) ticket-price)))
    (- (revenue ticket-price)
       (cost ticket-price))))


;; testing profit
;; 1.
(equal? (profit 1) 511.2)

;; 2.
(equal? (profit 2) 937.2)

;; 3.
(equal? (profit 3) 1063.2)

;; 4.
(equal? (profit 4) 889.2)

;; 5.
(equal? (profit 5) 415.2)

;; 6.
(equal? (profit 6) -358.8)

;; 7.
(equal? (profit 7) -1432.8)

;; 8.
(equal? (profit 8) -2806.8)