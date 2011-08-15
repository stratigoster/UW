;; Contract-
;;   make-fibonacci: -> (symbol -> num)
;; Purpose-
;;   to create a service manager that returns fibonacci numbers
;; Example-
;;  (define count (make-fibonacci))
;;   (count 'current) => 1
;;   (count 'next) => 1
;;   (count 'next) => 2
;;   (count 'current) => 2
;;   (count 'reset) => 1


(define (make-fibonacci)
  (local
      ((define curr 1)
       (define prev1 1)
       (define prev2 0)
       (define (service-manager msg)
         (cond
           [(symbol=? msg 'current) prev1]
           [(symbol=? msg 'next)
              (begin
                (set! curr (+ prev1 prev2))
                (set! prev2 prev1)
                (set! prev1 curr)
                curr)]
           [(symbol=? msg 'reset)
              (begin
                (set! curr 1)
                (set! prev1 1)
                (set! prev2 0)
                curr)]
           [else (error 'make-fibonacci "Invalid command")])))
    service-manager))


;; testing make-fibonacci
(define count (make-fibonacci))

(equal? (count 'current) 1)
(equal? (count 'next) 1)
(equal? (count 'current) 1)
(equal? (count 'next) 2)
(equal? (count 'current) 2)
(equal? (count 'next) 3)
(equal? (count 'current) 3)

(define another (make-fibonacci))

(equal? (another 'current) 1)
(equal? (another 'next) 1)
(equal? (another 'next) 2)
(equal? (another 'current) 2)
(equal? (another 'next) 3)
(equal? (another 'current) 3)

(equal? (count 'next) 5)
(equal? (count 'current) 5)
(equal? (count 'next) 8)
(equal? (count 'current) 8)
(equal? (count 'reset) 1)

(equal? (another 'next) 5)
(equal? (another 'current) 5)
(equal? (another 'next) 8)
(equal? (another 'next) 13)
(equal? (another 'next) 21)
(equal? (another 'current) 21)

