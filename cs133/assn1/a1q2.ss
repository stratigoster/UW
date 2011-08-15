;; pre-calculates the total number of days from the beginning of the year up to the beginning of the month
;; eg April=31+28+31
(define m2 31)
(define m3 (+ 28 m2))
(define m4 (+ 31 m3))
(define m5 (+ 30 m4))
(define m6 (+ 31 m5))
(define m7 (+ 30 m6))
(define m8 (+ 31 m7))
(define m9 (+ 31 m8))
(define m10 (+ 30 m9))
(define m11 (+ 31 m10))
(define m12 (+ 30 m11))

;; day-within-year: symbol num num -> num
;; to produce the day of the year that the date falls on in the Gregorian calendar
;; eg (day-within-year 'Sep 24 2000) => 268
(define (day-within-year month day year)
  (cond
    [(leap-year? year) (calc-days month (+ day 1))] ;; if leap year, adds 1 to the day
    [else (calc-days month day)]))

; leap-year?: num -> boolean
;; to check whether a year is a leap year or not
;; Re: leap years are divisible by 400 and 4, but not 100
;; eg (leap-year? 2000) => true
(define (leap-year? year)
  (cond
    [(= 0 (remainder year 400)) true]
    [(= 0 (remainder year 100)) false]
    [(= 0 (remainder year 4)) true]
    [else false]))

;; calc-days: symbol num -> num
;; adds up the total number of days from the beginning of the year to the date
(define (calc-days month day)
  (cond
    [(symbol=? month 'Jan) day]
    [(symbol=? month 'Feb) (+ day m2)]
    [(symbol=? month 'Mar) (+ day m3)]
    [(symbol=? month 'Apr) (+ day m4)]
    [(symbol=? month 'May) (+ day m5)]
    [(symbol=? month 'Jun) (+ day m6)]
    [(symbol=? month 'Jul) (+ day m7)]
    [(symbol=? month 'Aug) (+ day m8)]
    [(symbol=? month 'Sep) (+ day m9)]
    [(symbol=? month 'Oct) (+ day m10)]
    [(symbol=? month 'Nov) (+ day m11)]
    [(symbol=? month 'Dec) (+ day m12)]))

;; tests
(= (day-within-year 'Sep 24 2000) 268)
(= (day-within-year 'Dec 31 2001) 365)
(= (day-within-year 'Jan 26 1987) 26)
(= (day-within-year 'Mar 12 1700) 71)