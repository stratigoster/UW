;; Contract-
;;   reverse-graph: graph -> graph
;; Purpose-
;;   to consume a graph G and produces a graph with the same nodes but
;;   with all edges reversed
;; Examples-
;;   1. (reverse-graph '((A ()))) => '((A ()))
;;   2. (reverse-graph '((A (B)) (B ()))) => '((A ()) (B (A)))
;;   3. (reverse-graph '((A (B C)) (B ()) (C ()))) => '((A ()) (B (A)) (C (A)))


(define (reverse-graph G)
  (map (lambda (x)
         (list (first x)
               (map (lambda (z) (first z))
                    (filter (lambda (y)
                              (cond
                                [(boolean? (member (first x) (second y))) false]
                                [else true]))
                            G))))
          G))


;; testing reverse-graph
;; 1.
(equal? (reverse-graph '((A ()))) '((A ())))

;; 2.
(equal? (reverse-graph '((A (B)) (B ()))) '((A ()) (B (A))))

;; 3.
(equal? (reverse-graph '((A (B C)) (B ()) (C ()))) '((A ()) (B (A)) (C (A))))

;; Graph Definition, taken from pg413 of HTDP; contains a cycle
(define DCG '((A (B E)) (B (E F)) (C (B D)) (D ()) (E (C F)) (F (D G)) (G ())))

;; 4.
(equal? (reverse-graph DCG) '((A ()) (B (A C)) (C (E)) (D (C F)) (E (A B)) (F (B E)) (G (F))))