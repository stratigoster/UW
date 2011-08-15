;; Contract-
;;   DNAprefix: los los -> boolean
;; Purpose-
;;   consumes 2 lists of symbols (los); the first list is called a pattern,
;;   the 2nd one a search-string. The function returns true if the pattern
;;   is a prefix of the search-string. Otherwise the function returns false.
;; Examples-
;;   1. (DNAprefix '(a t) '(a t c)) => true
;;   2. (DNAprefix '(a t) '(a)) => false
;;   3. (DNAprefix '(a t) '(a t)) => true
;;   4. (DNAprefix '(a c g t) '(a g)) => false
;;   5. (DNAprefix '(a a c c) '(a c)) => false
;;   6. (DNAprefix '(a b c) empty) => false
;;   7. (DNAprefix empty '(a b c)) => true

(define (DNAprefix patt sstring)
  (cond
    [(empty? patt) true]
    [(empty? sstring) false]
    [(equal? (first patt) (first sstring)) (DNAprefix (rest patt) (rest sstring))]
    [else false]))


;; testing DNAprefix
;; 1.
(equal? (DNAprefix '(a t) '(a t c)) true)

;; 2.
(equal? (DNAprefix '(a t) '(a)) false)

;; 3.
(equal? (DNAprefix '(a t) '(a t)) true)

;; 4.
(equal? (DNAprefix '(a c g t) '(a g)) false)

;; 5.
(equal? (DNAprefix '(a a c c) '(a c)) false)

;; 6.
(equal? (DNAprefix '(a b c) empty) false)

;; 7.
(equal? (DNAprefix empty '(a b c)) true)


;; --------------------------------------------------------------------------------
;; Contract-
;;   DNAsubstring: los los -> boolean
;; Purpose-
;;   consumes 2 lists of symbols (lon); the first list is called a pattern
;;   and the 2nd one a search-string. The function returns true if the pattern
;;   occurs somewhere in the search-string (not necessarily as a prefix, but
;;   consecutively).
;; Examples-
;;   1. (DNAsubstring '(a t) '(a t c)) => true
;;   2. (DNAsubstring '(a t) '(a)) => false
;;   3. (DNAsubstring '(a t) '(a t)) => true
;;   4. (DNAsubstring '(a c g t) '(a g)) => false
;;   5. (DNAsubstring '(a c) '(a a c c)) => true
;;   6. (DNAsubstring '(a c g) '(a b c a c g j)) => true
;;   7. (DNAsubstring '(a b c) empty) => false


(define (DNAsubstring patt sstring)
  (cond
    [(empty? sstring) false]
    [(empty? patt) true]
    [else
     (cond
       [(DNAprefix patt sstring) true]
       [else (DNAsubstring patt (rest sstring))])]))


;; testing DNAsubstring
;; 1.
(equal? (DNAsubstring '(a b c) empty) false)

;; 2.
(equal? (DNAsubstring '(a t) '(a t c)) true)

;; 3.
(equal? (DNAsubstring '(a t) '(a)) false)

;; 4.
(equal? (DNAsubstring '(a t) '(a t)) true)

;; 5.
(equal? (DNAsubstring '(a c g t) '(a g)) false)

;; 6.
(equal? (DNAsubstring '(a c) '(a a c c)) true)

;; 7.
(equal? (DNAsubstring '(a c g) '(a b c a c g j)) true)

;; 8.
(equal? (DNAsubstring '(a t) '(a a t t)) true)

;; 9.
(equal? (DNAsubstring empty '(a b c)) true)