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


;; testing make-circular!
;; 1.
(eq? (make-circular! empty) empty)

;; 2.
 (make-circular! '(1))
;(shared ((-0- (cons 1 -0-))) -0-))

;; 3.
 (make-circular! '(1 2))
;(shared ((-0- (cons 1 (cons 2 -0-)))) -0-))

;; 4.
 (make-circular! '(1 2 3))
;(shared ((-0- (cons 1 (cons 2 (cons 3 -0-))))) -0-))