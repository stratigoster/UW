;; contract- collect-taxes: payroll -> num
;; purpose- to consume a payroll and calculate the total amount of taxes owed by the persons
;; example- (collect-taxes
;;            (cons (make-sr 'JaneDoe 50000)
;;              (cons (make-sr 'DaKou 15500)
;;                (cons (make-sr 'MusaAlKharizmi 100000) empty )))) => 32480
(define (collect-taxes payrl)
  (cond
    [(empty? payrl) 0]
    [else (+ (tax-payable (sr-salary (first payrl))) (collect-taxes (rest payrl)))]))

;; tests
(equal?
 (collect-taxes
  (cons (make-sr 'JaneDoe 50000)
   (cons (make-sr 'DaKou 15500)
    (cons (make-sr 'MusaAlKharizmi 100000) empty)))) 32480)

;; contract- new-salary: num -> num
;; purpose- consumes a salary and then calculates the new salary after the reduction
;; example- (new-salary 50000 5) => 47500
(define (new-salary salary percent-decrease)
  (* salary (* (- 100 percent-decrease) 0.01)))

;; testing new-salary
(equal? (new-salary 500000 5) 475000)
(equal? (new-salary 100000 10) 90000)

;; contract- government-cutback: payroll num -> payroll
;; purpose- to to consume a payroll and decrease all the salaries by a certain percentage, and produce a payroll with the new salaries
;; eg. (government-cutback
;;       (cons (make-sr 'JaneDoe 50000)
;;         (cons (make-sr 'DaKou 15500)
;;           (cons (make-sr 'MusaAlKharizmi 100000) empty))) 5) =>
;;       (cons (make-sr 'JaneDoe 47500)
;;         (cons (make-sr 'DaKou 14725)
;;           (cons (make-sr 'MusaAlKharizmi 95000) empty)))
(define (government-cutback payrl percent-decrease)
  (cond
    [(empty? payrl) empty]
    [else
     (cons
      (make-sr (sr-name (first payrl))
               (new-salary (sr-salary (first payrl)) percent-decrease))
      (government-cutback (rest payrl) percent-decrease))]))

;; tests
(equal?
 (government-cutback
  (cons (make-sr 'JaneDoe 50000)
   (cons (make-sr 'DaKou 15500)
    (cons (make-sr 'MusaAlKharizmi 100000) empty))) 5)
 (cons (make-sr 'JaneDoe 47500)
  (cons (make-sr 'DaKou 14725)
   (cons (make-sr 'MusaAlKharizmi 95000) empty))))

;; contract- fire-the-rich: payroll -> payroll
;; purpose- to consume a payroll and produce a payroll with all persons earning $100000 or more removed
;; eg. (fire-the-rich
;;      (cons (make-sr 'JaneDoe 50000)
;;       (cons (make-sr 'DaKou 15500)
;;        (cons (make-sr 'MusaAlKharizmi 100000)
;;         (cons (make-sr 'JohnSmith 75000) empty))))) =>
;;      (cons (make-sr 'JaneDoe 50000)
;;       (cons (make-sr 'DaKou 15500)
;;        (cons (make-sr 'JohnSmith 75000) empty)))
(define (fire-the-rich payrl)
  (cond
    [(empty? payrl) empty]
    [else (cond
            [(< (sr-salary (first payrl)) 100000) (cons (first payrl) (fire-the-rich (rest payrl)))]
            [else (fire-the-rich (rest payrl))])]))

;; tests
(equal? (fire-the-rich
         (cons (make-sr 'JaneDoe 50000)
          (cons (make-sr 'DaKou 15500)
           (cons (make-sr 'MusaAlKharizmi 100000)
            (cons (make-sr 'JohnSmith 75000) empty)))))
        (cons (make-sr 'JaneDoe 50000)
         (cons (make-sr 'DaKou 15500)
          (cons (make-sr 'JohnSmith 75000) empty))))
(equal? (fire-the-rich
         (cons (make-sr 'JaneDoe 50000)
          (cons (make-sr 'DaKou 15500)
           (cons (make-sr 'MusaAlKharizmi 90000)
            (cons (make-sr 'JohnSmith 75000) empty)))))
        (cons (make-sr 'JaneDoe 50000)
         (cons (make-sr 'DaKou 15500)
          (cons (make-sr 'MusaAlKharizmi 90000)
           (cons (make-sr 'JohnSmith 75000) empty)))))
(equal? (fire-the-rich
         (cons (make-sr 'JaneDoe 150000)
          (cons (make-sr 'DaKou 15500)
           (cons (make-sr 'MusaAlKharizmi 100000)
            (cons (make-sr 'JohnSmith 75000) empty)))))
        (cons (make-sr 'DaKou 15500)
         (cons (make-sr 'JohnSmith 75000) empty)))