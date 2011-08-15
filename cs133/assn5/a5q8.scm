;; Data Definition - Heirarchical Lists
;;   A heirarchical list (hl) is either empty, or it is of the form (cons symb hlist)
;;   where symb is a symbol and hlist is a hl, or it is of the form (cons hlist1 hlist2)
;;   where hlist1 and hlist2 are heirarchical lists.


;; Contract-
;;   depth: hl -> num
;; Purpose-
;;   to consume a heirarchical list and produces its depth. (The depth of a symbol
;;   is the number of lines we must traverse from the top in order to reach it. The
;;   depth of a tree is the largest depth of any symbol in it)
;; Examples-
;;   1. (depth empty) => 0
;;   2. (depth (list 'a) => 1
;;   3. (depth (list (list 'a 'b) (list 's 'e 'f) 'c))) => 2
;;   4. (depth (list (list (list 'a 'b 'c) (list 'd 'e 'f) (list 'g 'h 'i))
;;                         (list 'a 'b 'c) (list (list 'a 'b) (list 'c 'f)))) => 3


(define (depth hl)
  (cond
    [(or (equal? false hl) (empty? hl)) 0]
    [(symbol? (first hl)) (max 1 (depth (rest hl)))]
    [else (max (+ 1 (depth (first hl))) (depth (rest hl)))]))


;; testing depth
;; 1.
(equal? (depth empty) 0)

;; 2.
(equal? (depth (list 'a)) 1)

;; 3.
(equal? (depth (list (list 'a 'b) (list 's 'e 'f) 'c)) 2)

;; 4.
(equal? (depth (list (list (list 'a 'b 'c) (list 'd 'e 'f) (list 'g 'h 'i))
                     (list 'a 'b 'c) (list (list 'a 'b) (list 'c 'f)))) 3)

;; 5.
(equal? (depth (list 'a (list 'b 'c) (list 'd 'e 'g 't 'g))) 2)

;; 6.
(equal? (depth (list 'b (list 'z (list 'c (list 'd 'e)) 'e 'f))) 4)

;; 7.
(equal? (depth (list
                  (list
                    (list 'a 'b)
                    (list 'c 'd))
                  (list 'e 'f)
                  (list
                    (list 'f 'g 'h)
                    (list
                       'a
                       (list 'b 'c 'd
                             (list 'e 'f))))
                  (list (list 'e 'o) 'a))) 5)
