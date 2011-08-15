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
;;    search-bt: num BT -> symbol/boolean
;; Purpose-
;;    to consume a number n and a BT, and if the tree contains a node structure
;;    whose soc field is n, the function produces the value of the pn field in that node.
;;    Otherwise the function produces false.
;; Examples-
;;    (search-bt 7 false) => false
;;    (search-bt 9 (make-node 9 'k false false)) => 'k
;;    (search-bt 20 (make-node 15 'd false (make-node 24 'i false false))) => false
;;    (search-bt 87 (make-node 15 'd (make-node 87 'h false false) false)) => 'h


(define (search-bt n bt)
  (cond
    [(equal? false bt) false]
    [else
      (cond
        [(equal? (node-soc bt) n) (node-pn bt)]
        [(boolean? (search-bt n (node-lft bt))) (search-bt n (node-rgt bt))]
        [else (search-bt n (node-lft bt))])]))


;; testing search-bt
(equal? (search-bt 7 false) false)
(equal? (search-bt 9 (make-node 9 'k false false)) 'k)
(equal? (search-bt 20 (make-node 15 'd false (make-node 24 'i false false))) false)
(equal? (search-bt 87 (make-node 15 'd (make-node 87 'h false false) false)) 'h)
(equal? (search-bt 99 (make-node 17 'd (make-node 13 'k (make-node 34 'p false false) false) (make-node 99 'h false false))) 'h)
(equal? (search-bt 77 (make-node 17 'd (make-node 13 'k (make-node 77 'f false false) false) (make-node 55 'h false false))) 'f)