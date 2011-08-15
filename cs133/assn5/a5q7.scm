;; Data Definition - Heirarchical Lists
;;   A heirarchical list (hl) is either empty, or it is of the form (cons symb hlist)
;;   where symb is a symbol and hlist is a hl, or it is of the form (cons hlist1 hlist2)
;;   where hlist1 and hlist2 are heirarchical lists.


;; Contract-
;;   occurs-in-hl: hl symbol -> num
;; Purpose-
;;   to consume a heirarchical list and a symbol, and produces the number of times
;;   that the number occurs in the heirarchical list
;; Examples-
;; 1. (occurs-in-hl empty 'a) => 0
;; 2. (occurs-in-hl (list 'a) 'a) => 1
;; 3. (occurs-in-hl (list 'b) 'a) => 0
;; 4. (occurs-in-hl (list (list 'b 'c 'd) (list 'a 'b 'c) (list 'a 'b 'a)) 'a) => 3


(define (occurs-in-hl hl symb)
  (cond
    [(empty? hl) 0]
    [(symbol? (first hl)) (cond
                            [(equal? (first hl) symb) (+ 1 (occurs-in-hl (rest hl) symb))]
                            [else (occurs-in-hl (rest hl) symb)])]
    [else (+ (occurs-in-hl (first hl) symb) (occurs-in-hl (rest hl) symb))]))


;; testing occurs-in-hl
(equal? (occurs-in-hl empty 'a) 0)
(equal? (occurs-in-hl (list 'a) 'a) 1)
(equal? (occurs-in-hl (list 'b) 'a) 0)
(equal? (occurs-in-hl (list (list 'b 'c 'd) (list 'a 'b 'c) (list 'a 'b 'a)) 'a) 3)
(equal? (occurs-in-hl (list (list 'a 'b 'c) 'a (list 'z 'x 'a) (list 'b 'e 'f) 'a (list 'k 'a 'x)) 'a) 5)