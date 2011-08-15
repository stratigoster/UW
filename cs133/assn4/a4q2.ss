;; Template-
;; (define (fun-for-num num)
;;   (cond
;;     [(< num 10) ... ]
;;     [else ... (last-digit num) ... (fun-for-num (floor (/ num 10))) ... ]))


;;-------------------------------------------------------
;; contract- last-digit: num -> num
;; purpose- returns the rightmost digit of a number
;; examples-
;; (last-digit 1) => 1
;; (last-digit 12) => 2
;; (last-digit 10000010) => 0

(define (last-digit num)
  (modulo num 10))

;; testing last-digit
(equal? (last-digit 1) 1)
(equal? (last-digit 12) 2)
(equal? (last-digit 149) 9)
(equal? (last-digit 10000010) 0)


;;-------------------------------------------------------
;; contract- penul-digit: num -> num
;; purpose- returns the 2nd to last digit of a number > 10
;; examples-
;; (penul-digit 10) => 1
;; (penul-digit 129) => 2
;; (penul-digit 943) => 4

(define (penul-digit num)
  (/ (- (modulo num 100) (last-digit num)) 10))

;; testing penul-digit
(equal? (penul-digit 10) 1)
(equal? (penul-digit 129) 2)
(equal? (penul-digit 10000020) 2)
(equal? (penul-digit 12345897) 9)


;;-------------------------------------------------------
;; contract- sum-digits: num -> num
;; purpose- to consume a natural number and produce the sum of its digits
;; examples-
;; (sum-digits 12) => 3
;; (sum-digits 2) => 2
;; (sum-digits 100001) => 2

(define (sum-digits num)
  (cond
    [(< num 10) num]
    [else (+ (last-digit num) (sum-digits (floor (/ num 10))))]))

;; testing sum-digits
(equal? (sum-digits 1) 1)
(equal? (sum-digits 12) 3)
(equal? (sum-digits 1000001) 2)
(equal? (sum-digits 66475) 28)
(equal? (sum-digits 12345) 15)