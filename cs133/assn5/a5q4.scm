;; Data Definition - Node
(define-struct node (soc pn lft rgt))
;; A node is a structure: (make-node soc pn lft rgt),
;; where soc is a number, pn is a symbol, and lft and rgt are BTs


;; Data Definition - Binary Tree
;; A binary-tree (BT) is either
;; 1. false; or
;; 2. (make-node soc pn lft rgt)
;;    where soc is a number, pn is a symbol, and lft and rgt are BTs


;; Data Definition - Binary Search Tree (BST)
;;   A Binary Search Tree is a BT:
;;     1. false is always a BST
;;     2. (make-node soc pn lft rgt) is a BST if
;;        a. lft and rgt are BSTs
;;        b. all ssn numbers in lft are smaller than soc
;;        c. all ssn numbers in rgt are larger than soc


;; Contract-
;;   search-bst: num BST -> symbol/boolean
;; Purpose-
;;   to consume a num n and a BST, and if the tree contains a node structure whose soc field is n,
;;   the function produces the value of the pn field in that node. Otherwise, the function produces false.
;; Examples-
;;   1. (search-bst 5 false) => false
;;   2. (search-bst 5 (make-node 5 'd false false)) => 'd
;;   3. (search-bst 5 (make-node 6 'd
;;                               (make-node 5 'e false false)
;;                               (make-node 7 'f false false))) => 'e
;;   4. (search-bst 8 (make-node 5 'd
;;                            (make-node 3 'l
;;                                       (make-node 2 'o false false)
;;                                       (make-node 4 'q false false))
;;                            (make-node 7 'u
;;                                       (make-node 6 'e false false)
;;                                       (make-node 8 'z false false))))) => 'z
;;   5. (search-bst 10 (make-node 5 'd
;;                            (make-node 3 'l
;;                                       (make-node 2 'o false false)
;;                                       (make-node 4 'q false false))
;;                            (make-node 7 'u
;;                                       (make-node 6 'e false false)
;;                                       (make-node 8 'z false false))))) => false


(define (search-bst n bst)
  (cond
    [(equal? false bst) false]
    [(equal? (node-soc bst) n) (node-pn bst)]
    [else
     (cond
       [(< n (node-soc bst)) (search-bst n (node-lft bst))]
       [else (search-bst n (node-rgt bst))])]))


;; testing search-bst
;; 1.
(equal? (search-bst 5 false) false)

;; 2.
(equal? (search-bst 5 (make-node 5 'd false false)) 'd)

;; 3.
(equal? (search-bst 5 (make-node 6 'd
                               (make-node 5 'e false false)
                               (make-node 7 'f false false))) 'e)

;; 4.
(equal? (search-bst 1 (make-node 6 'd
                               (make-node 5 'e false false)
                               (make-node 7 'f false false))) false)

;; 5.
(equal? (search-bst 8 (make-node 5 'd
                            (make-node 3 'l
                                       (make-node 2 'o false false)
                                       (make-node 4 'q false false))
                            (make-node 7 'u
                                       (make-node 6 'e false false)
                                       (make-node 8 'z false false)))) 'z)

;; 6.
(equal? (search-bst 10 (make-node 5 'd
                            (make-node 3 'l
                                       (make-node 2 'o false false)
                                       (make-node 4 'q false false))
                            (make-node 7 'u
                                       (make-node 6 'e false false)
                                       (make-node 8 'z false false)))) false)