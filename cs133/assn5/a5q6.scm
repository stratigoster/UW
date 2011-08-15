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
;;   add-to-bst: BST num symbol -> BST
;; Purpose-
;;   to consume a BST, a number, and a symbol and produces a BST.
;;   If the number is present in a node of the input BST, it produces the input BST;
;;   otherwise it produces a BST which is the input BST with one of the false subtrees
;;   replaced by a new leaf node containing the input number and a symbol.
;; Examples-
;;   1. (add-to-bst false 66 'a) => (make-node 66 'a false false)
;;   2. (add-to-bst (add-to-bst false 66 'a) 53 'b) => (make-node 66 'a (make-node 53 'b false false) false)
;;   3. (add-to-bst (make-node 6 'd
;;                               (make-node 5 'e false false)
;;                               (make-node 7 'f false false)) 4 'a) =>
;;        (make-node 6 'd
;;                   (make-node 5 'e
;;                              (make-node 4 'a false false)
;;                              false)
;;                   (make-node 7 'f false false))


(define (add-to-bst bst num sym)
  (cond
    [(equal? false bst) (make-node num sym false false)]
    [(equal? (node-soc bst) num) bst]
    [else
     (cond
       [(< num (node-soc bst)) (make-node (node-soc bst) (node-pn bst) (add-to-bst (node-lft bst) num sym) (node-rgt bst))]
       [else (make-node (node-soc bst) (node-pn bst) (node-lft bst) (add-to-bst (node-rgt bst) num sym))])]))


;; testing add-to-bst
;; 1.
(equal? (add-to-bst false 66 'a) (make-node 66 'a false false))

;; 2.
(equal? (add-to-bst (add-to-bst false 66 'a) 53 'b) (make-node 66 'a (make-node 53 'b false false) false))

;; 3.
(equal? (add-to-bst (make-node 6 'd
                               (make-node 5 'e false false)
                               (make-node 7 'f false false)) 4 'a)
        (make-node 6 'd
                   (make-node 5 'e
                              (make-node 4 'a false false)
                              false)
                   (make-node 7 'f false false)))

;; 4.
(equal? (add-to-bst (make-node 5 'd
                            (make-node 3 'l
                                       (make-node 2 'o false false)
                                       (make-node 4 'q false false))
                            (make-node 7 'u
                                       (make-node 6 'e false false)
                                       (make-node 8 'z false false))) 3 'p)
        (make-node 5 'd
                    (make-node 3 'l
                               (make-node 2 'o false false)
                               (make-node 4 'q false false))
                    (make-node 7 'u
                               (make-node 6 'e false false)
                               (make-node 8 'z false false))))

;; 5.
(equal? (add-to-bst (make-node 5 'd
                            (make-node 3 'l
                                       (make-node 2 'o false false)
                                       (make-node 4 'q false false))
                            (make-node 7 'u
                                       (make-node 6 'e false false)
                                       (make-node 8 'z false false))) 1 'x)
        (make-node 5 'd
                    (make-node 3 'l
                               (make-node 2 'o
                                          (make-node 1 'x false false)
                                          false)
                               (make-node 4 'q false false))
                    (make-node 7 'u
                               (make-node 6 'e false false)
                               (make-node 8 'z false false))))

;; 6.
(equal? (add-to-bst (make-node 5 'd
                            (make-node 3 'l
                                       (make-node 2 'o false false)
                                       (make-node 4 'q false false))
                            (make-node 7 'u
                                       (make-node 6 'e false false)
                                       (make-node 8 'z false false))) 9 'x)
                (make-node 5 'd
                    (make-node 3 'l
                               (make-node 2 'o false false)
                               (make-node 4 'q false false))
                    (make-node 7 'u
                               (make-node 6 'e false false)
                               (make-node 8 'z
                                          false
                                          (make-node 9 'x false false)))))


;; Data Definition - list-of-number/name
;;   A list-of-number/name is either
;;    1. empty or
;;    2. (cons (list ssn nom) lonn)
;;     where ssn is a number, nom a symbol, and lonn is a list-of-number/name


;; Contract-
;;   create-bst: list bst -> bst
;; Purpose-
;;   consumes a list-of-number/names and a BST, and adds
;;   all the numbers (with their corresponding names) on the list onto the bst
;; Examples-
;;  1. (create-bst empty false) => false
;;  2. (create-bst (list (list 1 'a)) false) => (make-node 1 'a false false)
;;  3. (create-bst (list (list 1 'a) (list 2 'b)) false) => (make-node 1 'a false (make-node 2 'b false false))
;;  4. (create-bst (list (list 2 'b) (list 3 'c)) false) => (make-node 2 'b false (make-node 3 'c false false))
;;  5. (create-bst (list (list 1 'a) (list 2 'b) (list 3 'c)) false) =>
;;        (make-node 1 'a false (make-node 2 'b false (make-node 3 'c)))


(define (create-bst list bst)
  (cond
    [(empty? list) bst]
    [else (create-bst (rest list) (add-to-bst bst (first (first list)) (first (rest (first list)))))]))


;; testing create-bst
;; 1.
(equal? (create-bst empty false) false)

;; 2.
(equal? (create-bst (list (list 1 'a)) false) (make-node 1 'a false false))

;; 3.
(equal? (create-bst (list (list 1 'a) (list 2 'b)) false) (make-node 1 'a false (make-node 2 'b false false)))

;; 4.
(equal? (create-bst (list (list 2 'b) (list 3 'c)) false) (make-node 2 'b false (make-node 3 'c false false)))

;; 5.
(equal? (create-bst (list (list 1 'a) (list 2 'b) (list 3 'c)) false)
        (make-node 1 'a false (make-node 2 'b false (make-node 3 'c false false))))


;; Contract-
;;   create-bst-from-list: lonn -> BST
;; Purpose-
;;   to consume a list of numbers and names, and produces a BST
;; Examples-
;;  1. (create-bst-from-list empty) => false
;;  2. (create-bst-from-list '((1 'a))) => (make-node 1 'a false false)
;;  3. (create-bst-from-list '((1 'a) (2 'b))) => (make-node 2 'b (make-node 1 'a false false) false)
;;  4. (create-bst-from-list '((2 'b) (3 'c))) => (make-node 2 'b false (make-node 3 'c false false))
;;  5. (create-bst-from-list '((1 'a) (2 'b) (3 'c))) => (make-node 2 'b
;;                                                                  (make-node 1 'a false false)
;;                                                                  (make-node 3 'c false false))


(define (create-bst-from-list list)
  (cond
    [(empty? list) false]
    [else (create-bst list false)]))


;; testing create-bst-from-list
;; 1.
(equal? (create-bst-from-list empty) false)

;; 2.
(equal? (create-bst-from-list (list (list 1 'a))) (make-node 1 'a false false))

;; 3.
(equal? (create-bst-from-list (list (list 1 'a) (list 2 'b))) (make-node 1 'a false (make-node 2 'b false false)))

;; 4.
(equal? (create-bst-from-list (list (list 2 'b) (list 3 'c))) (make-node 2 'b false (make-node 3 'c false false)))

;; 5.
(equal? (create-bst-from-list (list (list 1 'a) (list 2 'b) (list 3 'c)))
        (make-node 1 'a false (make-node 2 'b false (make-node 3 'c false false))))