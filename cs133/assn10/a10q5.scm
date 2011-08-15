;; =====================================================================================
;; Contract-
;;   make-circular!: list -> circular-list
;; Purpose-
;;   consumes a list and produces a circular list
;; Examples-
;;   1. (make-circular! empty) => empty
;;   2. (make-circular! '(1)) => (shared ((-0- (cons 1 -0-))) -0-)
;;   3. (make-circular! '(1 2 3)) => (shared ((-0- (cons 1 (cons 2 (cons 3 -0-))))) -0-)

(define (make-circular! somelist)
  (local
      ((define (seek x)
         (cond
           [(empty? (rest x)) (begin (set-rest! x somelist) somelist)]
           [else (seek (rest x))])))
    (cond
      [(empty? somelist) empty]
      [else (seek somelist)])))


;; ================================================================================
;; Contract-
;;   circular-free?: list -> boolean
;; Purpose-
;;   to consume a list and returns true if and only if the list is circular-free;
;;   else it returns false
;; Examples-
;;   1. (circular-free? empty) => true
;;   2. (circular-free? '(1 2 3)) => true
;;   3. (circular-free? (make-circular! '(1 2 3))) => false


(define (circular-free? mylist)
  (local
      ((define (myfn tmp count static)
         (cond
           [(zero? count) true]
           [(empty? (rest tmp)) true]
           [(eq? static (rest tmp)) false]
           [else (myfn (rest tmp) (sub1 count) static)]))
       ;; acc is the invariant, and is a list of the remaining elements to be checked.
       ;; count ensures that we have cycled through the cycle (if there is one) once
       (define (check x acc count)
         (cond
           [(empty? (rest x)) true]
           [(myfn mylist count acc) (check (rest x) (rest acc) (add1 count))]
           [else false])))
      (cond
        [(empty? mylist) true]
        [else (check mylist (rest mylist) 0)])))


;; ================================================================================
;; Contract-
;;   make-weird-circ: list op -> cyclic list
;; Purpose-
;;   to create a cyclic list, not necessarily circular.
;;   DISCLAIMER: to be used at own discretion


(define (make-weird-circ x op)
  (local
      ((define (myfn y)
         (cond
           [(empty? (rest y)) (begin (set-rest! y (op x)) x)]
           [else (myfn (rest y))])))
    (myfn x)))


;; ================================================================================
;; testing circular-free?
;; 1.
(equal? (circular-free? empty) true)

;; 2.
(equal? (circular-free? '(1)) true)

;; 3.
(equal? (circular-free? '(1 2 3)) true)

;; 4.
(equal? (circular-free? '(1 2 3 4 5 6 7)) true)

;; 5.
(equal? (circular-free? (make-circular! '(1))) false)

;; 6.
(equal? (circular-free? (make-circular! '(1 2 3))) false)

;; 7.
(equal? (circular-free? (make-weird-circ '(1 2 3) rest)) false)

;; 8.
(equal? (circular-free? (make-weird-circ '(1 2 3 4 5) (lambda (x) (rest (rest x))))) false)