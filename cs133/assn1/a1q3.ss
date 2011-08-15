;; myprofit: num -> num
;; to calculate the profit generated after working for a certain number of hours
(define (myprofit hours)
  (cond
    [(<= (* hours 60) 1500) (profit-1  (* hours 60))]
    [(<= (* hours 60) 5000) (+ (profit-1 1500) (profit-2 (- (* hours 60) 1500)))]
    [else (+ (profit-1 1500) (profit-2 3500) (profit-3 (- (* hours 60) 5000)))]))

;; profit-1: num -> num
;; to calculate the profit at 10c/msg ie the first 300msgs (or less)
(define (profit-1 mins)
  (- (* mins 0.2 0.1 ) 30)) ;; subtracts the cost of the generator as well

;; profit-2: num -> num
;; to calculate the profit at 20c/msg ie the next 700msgs (or less)
(define (profit-2 mins)
  (* mins 0.2 0.2))

;; profit-3: num -> num
;; to calculate the profit at 50c/msg ie for every other msg
(define (profit-3 mins)
  (* mins 0.2 0.5))

;; tests
(= -30 (myprofit 0))
(= 0 (myprofit 25))
(= 180 (myprofit 90))