;; Note: Language used is Intermediate Student

;; Data Definitions-
;;   A parent is a structure: (make-parent loc n d e)
;;   where loc is a list of children, n and e are symbols, and d is a number.
;;
;;   A list-of-children is either
;;    1. empty
;;    2. (cons p loc) where p is a parent and loc is a list-of-children


;; Structure Definition
(define-struct parent (loc n d e))


;; Contract-
;;   count-descendants: parent -> num
;; Purpose-
;;   to consume a parent and produce the number of descendants, including the parent
;; Examples-
;; (define Gustav (make-parent empty 'Gustav 1988 'brown))
;; (define Fred&Eva (list Gustav))
;; (define Adam (make-parent empty 'Adam 1950 'yellow))
;; (define Dave (make-parent empty 'Dave 1955 'black))
;; (define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
;; (define Fred (make-parent Fred&Eva 'Fred 1966 'pink))
;; (define Carl&Bettina (list Adam Dave Eva))
;; (define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
;; (define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))
;;
;; 1. (count-descendants Carl) => 5
;; 2. (count-descendants Fred) => 2
;; 3. (count-descendants Gustav) => 1
;; 4. (count-descendants Bettina) => 5


(define (count-descendants pnt)
  (cond
    [(empty? (parent-loc pnt)) 1]
    [else
     (local ((define (count-children-descendants loc)
               (cond
                 [(empty? loc) 0]
                 [else (+ (count-descendants (first loc)) (count-children-descendants (rest loc)))])))
       (+ 1 (count-children-descendants (parent-loc pnt))))]))


;; testing count-descendants

;; Youngest generation
 (define Gustav (make-parent empty 'Gustav 1988 'brown))
 (define George (make-parent empty 'George 1987 'purple))
 (define Emily (make-parent empty 'Emily 1985 'lilac))

 (define Jane&Adam (list George Emily))
 (define Fred&Eva (list Gustav))
 
;; Middle generation
 (define Adam (make-parent Jane&Adam 'Adam 1950 'yellow))
 (define Dave (make-parent empty 'Dave 1955 'black))
 (define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
 (define Fred (make-parent Fred&Eva 'Fred 1966 'pink))
 (define Jane (make-parent Jane&Adam 'Jane 1951 'orange))
 
 (define Carl&Bettina (list Adam Dave Eva))

;; Oldest generation
 (define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
 (define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))


;; 1.
(equal? (count-descendants Carl) 7)
 
;; 2.
(equal? (count-descendants Fred) 2)
 
;; 3.
(equal? (count-descendants Gustav) 1)
 
;; 4.
(equal? (count-descendants Bettina) 7)
 
;; 5.
(equal? (count-descendants Jane) 3)
 
;; 6.
(equal? (count-descendants Adam) 3)
 
;; 7.
(equal? (count-descendants Emily) 1)


;;--------------------------------------------------------------------------------
;; Contract-
;;   count-proper-descendants: parent -> num
;; Purpose-
;;   to consume a parent and produce the number of proper descendants (ie not counting the parent)
;; Examples-
;; (define Gustav (make-parent empty 'Gustav 1988 'brown))
;; (define Fred&Eva (list Gustav))
;; (define Adam (make-parent empty 'Adam 1950 'yellow))
;; (define Dave (make-parent empty 'Dave 1955 'black))
;; (define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
;; (define Fred (make-parent Fred&Eva 'Fred 1966 'pink))
;; (define Carl&Bettina (list Adam Dave Eva))
;; (define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
;; (define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))
;;
;; 1. (count-descendants Carl) => 4
;; 2. (count-descendants Fred) => 1
;; 3. (count-descendants Gustav) => 0
;; 4. (count-descendants Bettina) => 4


(define (count-proper-descendants pnt)
  (cond
    [(empty? (parent-loc pnt)) 0]
    [else
     ;; Contract-
     ;;   count-children-descendants: list-of-children -> num
     ;; Purpose-
     ;;   consumes a list-of-children and sums up the number
     ;;   of descendants of the children on the list
     (local ((define (count-children-descendants loc)
               (cond
                 [(empty? loc) 0]
                 [else (+ (count-descendants (first loc)) (count-children-descendants (rest loc)))])))
       (count-children-descendants (parent-loc pnt)))]))


;; testing count-proper-descendants
;; The following tests uses the same family tree defined above (used in testing proper-descedants)

;; 1.
(equal? (count-proper-descendants Carl) 6)
 
;; 2.
(equal? (count-proper-descendants Fred) 1)
 
;; 3.
(equal? (count-proper-descendants Gustav) 0)
 
;; 4.
(equal? (count-proper-descendants Bettina) 6)
 
;; 5.
(equal? (count-proper-descendants Jane) 2)
 
;; 6.
(equal? (count-proper-descendants Adam) 2)
 
;; 7.
(equal? (count-proper-descendants Emily) 0)