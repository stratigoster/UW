;; Contract-
;;   reachable-from: node graph: list-of-nodes
;; Purpose-
;;   consumes a node orig and a graph G, and produces a list
;;   of all nodes in G reachable from orig
;; Examples-
;;   1. (reachable-from 'A '((A empty))) => A
;;   2. (reachable-from 'A '((A (B C)) (B empty) (C empty)) => '(A B C)
;;   3. (reachable-from 'A '((A (B C)) (B (D)) (C (E)) (D empty) (E empty))) => '(A B C D E)


(define (reachable-from orig G)
  (local
      ;; Contract-
      ;;   enqueue: los los -> los
      ;; Purpose-
      ;;   consumes 2 lists: list1 and list2, and produces a list that is the same as list1
      ;;   but with all nodes from list1 that are in list2 removed
      ((define (enqueue nodelist visited)
         (cond
           [(empty? nodelist) empty]
           [else
            (cond
              [(boolean? (member (first nodelist) visited)) (cons (first nodelist) (enqueue (rest nodelist) visited))]
              [else (enqueue (rest nodelist) visited)])]))
       ;; Contract-
       ;;   nbors: node graph -> los
       ;; Purpose-
       ;;   consumes a node and a graph, and produces the neighbors of that node
       (define (nbors node G)
         (cond
           [(equal? (first (first G)) node) (second (first G))]
           [else (nbors node (rest G))]))
       ;; Contract-
       ;;   findnodes: los los -> los
       ;; Purpose-
       ;;   uses breadth-first-search to produce a list of all nodes reachable from the origin
       (define (findnodes tovisit visited)
         (cond
           [(empty? tovisit) visited]
           [else
            (findnodes (enqueue (append (nbors (first tovisit) G) (rest tovisit)) visited) (cons (first tovisit) visited))])))
    (map string->symbol (quicksort (map symbol->string (findnodes (list orig) empty)) string<?))))


;; testing reachable-from
;; 1.
(equal? (reachable-from 'A '((A ()))) '(A))

;; 2.
(equal? (reachable-from 'A '((A (B C)) (B ()) (C ()))) '(A B C))

;; 3.
(equal? (reachable-from 'A '((A (B C)) (B (D)) (C (E)) (D ()) (E ()))) '(A B C D E))

;; Graph Definition, taken from pg413 of HTDP; contains a cycle
(define DCG '((A (B E)) (B (E F)) (C (B D)) (D ()) (E (C F)) (F (D G)) (G ())))

;; 4.
(equal? (reachable-from 'A DCG) '(A B C D E F G))

;; 5.
(equal? (reachable-from 'B DCG) '(B C D E F G))

;; 6.
(equal? (reachable-from 'C DCG) '(B C D E F G))

;; 7.
(equal? (reachable-from 'D DCG) '(D))

;; 8.
(equal? (reachable-from 'E DCG) '(B C D E F G))

;; 9.
(equal? (reachable-from 'F DCG) '(D F G))