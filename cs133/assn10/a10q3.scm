;; Contract-
;;   my-append!: (listof X) (listof Y) -> (union X Y)
;; Purpose-
;;   to append 2 lists
;; Examples-
;;   1. (my-append! '(1) empty) => empty
;;   2. (my-append! '(1 2 3) (4 5 6)) => '(1 2 3 4 5 6)
;;   3. (my-append! '(a) '(1)) => '(a 1)


(define (my-append! list1 list2)
  (local
      ((define (myfn! x1)
         (cond
           [(empty? (rest x1)) (set-rest! x1 list2)]
           [else (myfn! (rest x1))])))
      (begin
        (myfn! list1)
        list1)))


;; testing my-append!
;; 1.
(define L1 '(1 2 3))
(define L2 empty)
(equal? (append L1 L2) (my-append! L1 L2))
(set! L1 '(1 2 3))
(equal? (my-append! L1 L2) L1)

;; 2.
(define L3 '(1))
(define L4 '(2))
(equal? (append L3 L4) (my-append! L3 L4))
(set! L3 '(1))
(equal? (my-append! L3 L4) L3)

;; 3.
(define L5 '(1 2 3))
(define L6 '(4 5 6))
(equal? (append L5 L6) (my-append! L5 L6))
(set! L5 '(1 2 3))
(equal? (my-append! L5 L6) L5)

;; 4.
(define L7 '(1 2 3))
(define L8 '(a b c))
(equal? (append L7 L8) (my-append! L7 L8))
(set! L7 '(1 2 3))
(equal? (my-append! L7 L8) L7)


;; If list1 was empty, then we would not have been able to use set-rest! or set-first!
;; to mutate the empty list, thus the problem would have been unsolvable.