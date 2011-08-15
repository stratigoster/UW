;; Note: Language used is Intermediate Student

;; Data Definitions-
;;   A parent is a structure: (make-parent loc n d e)
;;   where loc is a list of children, n and e are symbols, and d is a number.
;;
;;   A list-of-children is either
;;    1. empty
;;    2. (cons p loc) where p is a parent and loc is a list-of-children
;;
;;   A list-of-parent-structures is either
;;    1. empty
;;    2. (cons p lops) where p is a parent and lops is a list-of-parent-structures

(define-struct parent (loc n d e))

;; Contract-
;;   childless-descendants: parent -> list-of-parent-structures
;; Purpose-
;;   to consume a parent structure and produce a list of parent structures
;;   representing descedants who themselves are childless.
;; Examples-
;;   (define Gustav (make-parent empty 'Gustav 1988 'brown))
;;   (define Fred&Eva (list Gustav))
;;   (define Adam (make-parent empty 'Adam 1950 'yellow))
;;   (define Dave (make-parent empty 'Dave 1955 'black))
;;   (define Eva (make-parent Fred&Eva 'Eva 1965 'blue))
;;   (define Fred (make-parent Fred&Eva 'Fred 1966 'pink))
;;   (define Carl&Bettina (list Adam Dave Eva))
;;   (define Carl (make-parent Carl&Bettina 'Carl 1926 'green))
;;   (define Bettina (make-parent Carl&Bettina 'Bettina 1926 'green))
;;
;; 1. (childless-descendants Gustav) => (list Gustav)
;; 2. (childless-descendants Fred) => (list Gustav)
;; 3. (childless-descendants Bettina) => (list Adam Dave Gustav)
;; 4. (childless-descendants Carl) => (list Adam Dave Gustav)


(define (childless-descendants p)
  (cond
    [(empty? (parent-loc p)) (cons p empty)]
    [else
     (local
         ;; Contract-
         ;;   check-children: list-of-children -> list-of-parent-structures
         ;; Purpose-
         ;;   consumes a list-of-children and determines which of the descendants
         ;;   are themselves childless.
         ((define (check-children loc)
            (cond
              [(empty? loc) empty]
              [(empty? (parent-loc (first loc))) (append (cons (first loc) empty) (check-children (rest loc)))]
              [else (append (check-children (parent-loc (first loc))) (check-children (rest loc)))])))
       (check-children (parent-loc p)))]))


;; testing childless-descendants

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
(equal? (childless-descendants Gustav) (list Gustav))

;; 2.
(equal? (childless-descendants Fred) (list Gustav))

;; 3.
(equal? (childless-descendants Bettina) (list George Emily Dave Gustav))

;; 4.
(equal? (childless-descendants Jane) (list George Emily))

;; 5.
(equal? (childless-descendants Eva) (list Gustav))

;; 6.
(equal? (childless-descendants Dave) (list Dave))

;; 7.
(equal? (childless-descendants Adam) (list George Emily))