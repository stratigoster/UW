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
;; contract- increasing-digits?: num -> boolean
;; purpose- to consume a natural number and returns true iff the digits in the number strictly increase from left to right
;; examples-
;; (increasing-digits? 1346) => true
;; (increasing-digits? 392) => false
;; (increasing-digits 1223) => false

(define (increasing-digits? num)
  (cond
    [(< num 10) true]
    [else
     (cond
       [(> (last-digit num) (penul-digit num)) (increasing-digits? (floor (/ num 10)))]
       [else false])]))

;; testing increasing-digits
(equal? (increasing-digits? 5) true)
(equal? (increasing-digits? 10) false)
(equal? (increasing-digits? 12) true)
(equal? (increasing-digits? 11) false)
(equal? (increasing-digits? 112) false)
(equal? (increasing-digits? 2222) false)
(equal? (increasing-digits? 392) false)
(equal? (increasing-digits? 123456) true)
(equal? (increasing-digits? 912345) false)
(equal? (increasing-digits? 9220379) false)