;; Contract-
;;   combine: (X Y -> Z) (listof X) (listof Y) -> (listof Z)
;; Purpose-
;;   to consume a function and 2 lists of equal length, and produces a list of that
;;   length. The ith item of the list produced by combine is the result of applying
;;   the function to the ith items on each of the lists.
;; Examples-
;; 1. (combine * empty empty) => empty
;; 2. (combine + '(1 2 3) '(1 2 3)) => '(2 4 6)
;; 3. (combine * '(1 2 3) '(2 4 6)) => '(2 8 18)


(define (combine myfn list1 list2)
  (cond
    [(empty? list1) empty]
    [else (cons (myfn (first list1) (first list2)) (combine myfn (rest list1) (rest list2)))]))


;; testing combine
(equal? (combine * empty empty) empty)
(equal? (combine + '(1 2 3) '(4 5 6)) '(5 7 9))
(equal? (combine * '(1 2 3) '(4 5 6)) '(4 10 18))
(equal? (combine (lambda (x y) (* x (+ y 5))) '(1 2 3) '(3 4 5)) '(8 18 30))


;; --------------------------------------------------------------------------------
;; Data Definition
;; a phone-record is a structure: (make-phone-record s n)
;; where s is a symbol and n is a number
(define-struct phone-record (name number))


;; Contract-
;;   zip: los lon -> list-of-phone-records
;; Purpose-
;;   combines a list of names and a list of phone numbers into a list of phone records.
;;   A phone-record is constructed with (make-phone-record s n) where s is a symbol
;;   and n is a number. Assumption: the lists are of equal length.
;; Examples-
;; 1. (zip empty empty) => empty
;; 2. (zip (list 'Joe) (list 999)) => (list (make-phone-record 'Joe 999))
;; 3. (zip (list 'Jim 'Jack 'Bill 'Marie 'Kate) (list 999 888 777 666 555)) =>
;;       (list
;;           (make-phone-record 'Jim 999) (make-phone-record 'Jack 888)
;;           (make-phone-record 'Bill 777) (make-phone-record 'Marie 666)
;;           (make-phone-record 'Kate 555))


(define (zip list1 list2)
  (combine make-phone-record list1 list2))


;; testing zip
;; 1.
(equal? (zip empty empty) empty)

;; 2.
(equal? (zip
           (list 'Joe)
           (list 999))
        (list (make-phone-record 'Joe 999)))

;; 3.
(equal? (zip
           (list 'Jim 'Jack 'Bill 'Marie 'Kate)
           (list 999 888 777 666 555))
        (list
           (make-phone-record 'Jim 999)
           (make-phone-record 'Jack 888)
           (make-phone-record 'Bill 777)
           (make-phone-record 'Marie 666)
           (make-phone-record 'Kate 555)))