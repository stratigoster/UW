;; Data Definition
(define-struct tax (bp taxrate))

;; each tax structure contains 2 fields:
;; 1. bp - this is either a number or the symbol 'infinity
;; 2. taxrate - this is a number representing the tax rate

;; Data Definition
;; the gen-tax-system is a list-of-taxes
;; a list-of-taxes (lot) is either: 
;; 1. the empty list, empty, or
;; 2. (cons tax lot) where tax is a tax structure, and lot is a list-of-taxes

;; contract- calc-taxes: lot num num -> num
;; purpose- to perform the actual calculation of the taxes
;; example:
;; (calc-taxes (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 35000 120000) => 20885.88
(define (calc-taxes list lbp salary)
  (cond
    [(equal? (tax-bp (first list)) 'infinity) (* (tax-taxrate (first list)) (- salary lbp))]
    [(> salary (tax-bp (first list))) (+ (* (tax-taxrate (first list)) (- (tax-bp (first list)) lbp)) (calc-taxes (rest list) (tax-bp (first list)) salary))] 
    [else (* (tax-taxrate (first list)) (- salary lbp))]))

;; testing calc-taxes
(equal? (calc-taxes (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 35000 120000) 20885.88)

(equal? (calc-taxes (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 35000 50000) 3300)

;; contract- general-tax-payable: gen-tax-system num -> num
;; purpose- consumes a gen-tax-system and a num representing an income, and computes the taxes payable on that income
;; examples:
;; (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 50000) => 8900
;; (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 100000) => 21100
(define (general-tax-payable list salary)
  (cond
    [(<= salary (tax-bp (first list))) (* salary (tax-taxrate (first list)))]
    [else (+ (* (tax-bp (first list)) (tax-taxrate (first list))) (calc-taxes list (tax-bp (first list)) salary))]))

;; tests
(equal? (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 10000) 1600)

(equal? (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 35000) 5600)

(equal? (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 40000) 6700)

(equal? (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 80000) 15900)

(equal? (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 120000) 26485.88)

(equal? (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 50000) 8900)

(equal? (general-tax-payable (cons (make-tax 35000 16/100) (cons (make-tax 70000 22/100) (cons (make-tax 113804 26/100) (cons (make-tax 'infinity 29/100) empty)))) 100000) 21100)