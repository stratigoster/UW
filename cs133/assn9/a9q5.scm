;; Contract-
;;   split: list-of-symbols&numbers -> (list los lon)
;; Purpose-
;;   consumes a mixed list of symbols and numbers, and produces a list of 2 lists -
;;   the first list containing all the symbols and the 2nd one containing all the numbers
;; Examples-
;;   1. (split empty) => '(() ())
;;   2. (split '(1)) => '(() (1))
;;   3. (split '(a)) => '((a) ())
;;   4. (split '(a 1)) => '((a) (1))
;;   5. (split '(1 a)) => '((a) (1))
;;   6. (split '(a 5 b c 2 4)) => '((a b c) (5 2 4))


(define (split losn)
  ;; los is a list of symbols, which contains all symbols encountered so far in losn.
  ;; lon is a list of numbers, which contains all numbers encountered so far in losn.
  (local ((define (separate losn los lon)
            (cond
              [(empty? losn) (list (reverse los) (reverse lon))]
              [else
               (cond
                 [(symbol? (first losn)) (separate (rest losn) (cons (first losn) los) lon)]
                 [else (separate (rest losn) los (cons (first losn) lon))])])))
    (separate losn empty empty)))


;; testing split
;; 1.
(equal? (split empty) '(()()))

;; 2.
(equal? (split '(a)) '((a) ()))

;; 3.
(equal? (split '(1)) '(()(1)))

;; 4.
(equal? (split '(a 1)) '((a) (1)))

;; 5.
(equal? (split '(1 a)) '((a) (1)))

;; 6.
(equal? (split '(a b c d e)) '((a b c d e) ()))

;; 7.
(equal? (split '(a 5 b c 2 4)) '((a b c) (5 2 4)))