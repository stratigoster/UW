;; Data definition
(define-struct checking (balance transactions))
(define-struct savings (balance transactions interest-rate))
(define-struct credit (balance wdraw-limit transactions interest-rate))

;; A bank account is either
;; 1. a structure (make-checking num num)
;; 2. a structure (make-savings num num num)
;; 3. a structure (make-credit num num num num)

;; Template
;;(define (f an-account)
;;  (cond
;;    [(checking? an-account)
;;   ... (checking-balance an-account) ... (checking-transactions an-account) ...]
;;    [(savings? an-account)
;;   ... (savings-balance an-account) ... (savings-transactions an-account) ... (savings-interest-rate an-account) ... ]
;;    [(credit? an-account)
;;   ... (credit-balance an-account) ... (credit-wdraw-limit an-account) ... (credit-transactions an-account) ... (credit-interest-rate an-account) ... ]))

;; bank-of-canada-update: account num -> account
;; consumes an account and produces an accout with the updated interest rate
(define (bank-of-canada-update account new-int-rate)
  (cond
    [(checking? account) (update-checking account 0)]
    [(savings? account) (update-savings account new-int-rate 0 false)]
    [(credit? account) (update-credit account new-int-rate 0 false)]))

;; update-checking: checking num -> checking
;; creates the new checking account
;; eg. (update-checking (make-checking 100 5) 20) => (make-checking 80 6)
(define (update-checking account wdraw-amt)
  (make-checking
   (cond
     [(<= -1000 (- (checking-balance account) wdraw-amt)) (- (checking-balance account) wdraw-amt)]
     [else 'Error])
   (cond
     [(= 0 wdraw-amt) (checking-transactions account)] ;; withdrawal of $0 is not a transaction
     [else (+ 1 (checking-transactions account))])))

;; testing update-checking
(equal? (update-checking (make-checking 100 5) 20) (make-checking 80 6))

;; update-savings: savings num num boolean -> savings
;; multi-purpose function that creates the new savings account
;; uses a flag - updte - to determine whether interest is to be added
;; eg (update-savings (make-savings 100 5 3) 4 0 true) => (make-savings (103 5 3))
(define (update-savings account new-int-rate wdraw-amt updte)
  (make-savings
   (cond
     [updte (+ (savings-balance account) (* (savings-balance account) (savings-interest-rate account) .01))]
     [else
      (cond
        [(<= 0 (- (savings-balance account) wdraw-amt)) (- (savings-balance account) wdraw-amt)]
        [else 'Error])])
   (cond
     [(= 0 wdraw-amt) (savings-transactions account)] ;; withdrawal of $0 is not a transaction
     [else (+ 1 (savings-transactions account))])
   (max 0 (+ -1 new-int-rate))))

;; testing  update-savings
(equal? (update-savings (make-savings 100 5 3) 4 0 true) (make-savings 103 5 3))
(equal? (update-savings (make-savings 100 5 3) 5 0 false) (make-savings 100 5 4))
(equal? (update-savings (make-savings 100 5 3) 4 20 false) (make-savings 80 6 3))

;; update-credit: credit num num boolean-> credit
;; multi-purpose account that creates the new credit account
;; uses a flag - updte - to determine whether interest is to be added
;; eg. see tests
(define (update-credit account new-int-rate wdraw-amt updte)
  (make-credit
   (cond
     [updte (+ (credit-balance account) (* (credit-balance account) (credit-interest-rate account) .01))]
     [else
      (cond
        [(<= (+ (credit-balance account) wdraw-amt) (credit-wdraw-limit account)) (+ (credit-balance account) wdraw-amt)]
        [else 'Error])])
   (credit-wdraw-limit account)
   (cond
     [(= 0 wdraw-amt) (credit-transactions account)] ;; withdrawal of $0 is not a transacion
     [else (+ (credit-transactions account) 1)])
   (+ 2 new-int-rate)))

;; testing update-credit
(equal? (update-credit (make-credit 100 500 10 3) 1 0 true) (make-credit 103 500 10 3))
(equal? (update-credit (make-credit 100 500 10 3) 1 200 false) (make-credit 300 500 11 3))
(equal? (update-credit (make-credit 100 500 10 3) 12 0 false) (make-credit 100 500 10 14))

;; withdrawal: account amount -> account
;; withdraws a sum of money from the account
(define (withdrawal account wdraw-amt)
  (cond
    [(checking? account) (update-checking account wdraw-amt)]
    [(savings? account) (update-savings account (+ 1 (savings-interest-rate account)) wdraw-amt false)]
    [(credit? account) (update-credit account (+ -2 (credit-interest-rate account)) wdraw-amt false)]))

;; year-end-update: account -> account
;; to calculate and add the interest earned in an account
(define (year-end-update account)
  (cond
    [(checking? account) account]
    [(savings? account) (update-savings account (+ 1 (savings-interest-rate account)) 0 true)]
    [(credit? account) (update-credit account (+ -2 (credit-interest-rate account)) 0 true)]))

;; tests
(equal? (bank-of-canada-update (make-checking 100 5) 10) (make-checking 100 5))
(equal? (bank-of-canada-update (make-savings 100 10 5) 10) (make-savings 100 10 9))
(equal? (bank-of-canada-update (make-credit 100 500 10 5) 8) (make-credit 100 500 10 10))
(equal? (bank-of-canada-update (make-savings 100 10 1) .5) (make-savings 100 10 0))
(equal? (withdrawal (make-checking 100 5) 50) (make-checking 50 6))
(equal? (withdrawal (make-checking 100 5) 200) (make-checking -100 6))
;;(withdrawal (make-checking 100 5) 1900) => error
(equal? (withdrawal (make-savings 200 10 5) 100) (make-savings 100 11 5))
;; (withdrawal (make-savings 200 10 5) 250) => error
(equal? (withdrawal (make-savings 200 10 5) 200) (make-savings 0 11 5))
(equal? (withdrawal (make-credit 100 500 10 5) 200) (make-credit 300 500 11 5))
;; (withdrawal (make-credit 100 500 10 5) 500) => error
(equal? (withdrawal (make-credit 100 500 10 5) 400) (make-credit 500 500 11 5))
(equal? (year-end-update (make-checking 100 5)) (make-checking 100 5))
(equal? (year-end-update (make-savings 100 5 5)) (make-savings 105 5 5))
(equal? (year-end-update (make-credit 100 500 10 5)) (make-credit 105 500 10 5))