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
;;   inorder: BT -> list-of-numbers
;; Purpose-
;;   to consume a binary tree and produce a list of all the ssn numbers in the tree
;; Examples-
;; 1. (inorder false) => empty
;; 2. (inorder (make-node 5 'd false false)) => '(5)
;; 3. (inorder (make-node 5 'd
;;               (make-node 4 'l false false)
;;               (make-node 6 'k false false)))
;;       => '(4 5 6)
;; 4. (inorder (make-node 5 'd
;;                (make-node 3 'l
;;                   (make-node 2 'o false false)
;;                   (make-node 4 'q false false))
;;                (make-node 7 'u
;;                   (make-node 6 'e false false)
;;                   (make-node 8 'z false false))))
;;          => '(2 3 4 5 6 7 8)


(define (inorder bt)
  (cond
    [(equal? false bt) empty]
    [else (append (inorder (node-lft bt)) (cons (node-soc bt) empty) (inorder (node-rgt bt)))]))


;; testing inorder
;; 1.
(equal? (inorder false) empty)

;; 2.
(equal? (inorder (make-node 5 'd false false)) '(5))

;; 3.
(equal? (inorder (make-node 5 'd
                            (make-node 4 'l false false)
                            (make-node 6 'k false false)))
        '(4 5 6))

;; 4.
(equal? (inorder (make-node 5 'd
                            (make-node 3 'l
                                       (make-node 2 'o false false)
                                       (make-node 4 'q false false))
                            (make-node 7 'u
                                       (make-node 6 'e false false)
                                       (make-node 8 'z false false))))
        '(2 3 4 5 6 7 8))

;; 5.
(equal? (inorder (make-node 63 'a
                            (make-node 29 'b
                                       (make-node 15 'c
                                                  (make-node 87 'd false false)
                                                  (make-node 24 'e false false))
                                       false)
                            (make-node 89 'f
                                       (make-node 33 'g false false)
                                       (make-node 95 'h
                                                  false
                                                  (make-node 99 'i false false)))))
        '(87 15 24 29 63 33 89 95 99))


;; inorder produces a list of numbers sorted in ascending order for a binary search tree.
;; Recall:
;;   A binary search tree is a BT:
;;     1. false is always a BST
;;     2. (make-node soc pn lft rgt) is a BST if
;;        a. lft and rgt are BSTs
;;        b. all ssn numbers in lft are smaller than soc
;;        c. all ssn numbers in rgt are larger than soc
;;
;; Thus, since all ssn numbers in the left branch are smaller than the ssn of the root,
;; and all ssn numbers in the right branch are larger than the ssn of the root,
;; when we read off the numbers in a BST from left to right we will get a list of numbers in ascending order.