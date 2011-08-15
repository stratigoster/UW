;; Data Definition - Node
(define-struct node (soc pn lft rgt))
;; A node is a structure: (make-node soc pn lft rgt),
;; where soc is a number, pn is a symbol, and lft and rgt are BTs


;; Data Definition - Binary Tree
;; A binary-tree (BT) is either
;; 1. false; or
;; 2. (make-node soc pn lft rgt)
;;    where soc is a number, pn is a symbol, and lft and rgt are BTs


;; Contract-
;;    contains-bt: num BT -> boolean
;; Purpose-
;;    to consume a number and a BT and determine whether the number occurs in the tree
;; Examples-
;;   (contains-bt 11 false) => false
;;   (contains-bt 7 (make-node 7 'k false false)) => true
;;   (contains-bt 20 (make-node 15 'd false (make-node 24 'i false false))) => false
;;   (contains-bt 87 (make-node 15 'd (make-node 87 'h false false) false)) => true


(define (contains-bt num bt)
  (cond
    [(equal? false bt) false]
    [else
     (cond
       [(equal? (node-soc bt) num) true]
       [else (or (contains-bt num (node-lft bt))
                 (contains-bt num (node-rgt bt)))])]))


;; testing contains-bt
(equal? (contains-bt 11 false) false)
(equal? (contains-bt 7 (make-node 7 'k false false)) true)
(equal? (contains-bt 5 (make-node 15 'd false (make-node 24 'i false false))) false)
(equal? (contains-bt 87 (make-node 15 'd (make-node 87 'h false false) false)) true)
(equal? (contains-bt 10 (make-node 10 'd (make-node 22 'j false false) (make-node 11 'k false false))) true)