;; A node is a structure: (make-node name adj)
;; where name is a symbol, and adj is a graph

;; A graph is either:
;; 1. empty
;; 2. (cons N G), where N is a node and G is a graph

(define-struct node (name adj))

;; Template for node-
;;   (fun-for-nodes (somenode)
;;     ... (node-name somenode) ...
;;     ... (node-adj somenode) ... )

;; Template for graph-
;;   (fun-for-graphs (somegraph)
;;     (cond
;;       [(empty? somegraph) empty]
;;       [else
;;         ... (node-name (first somegraph)) ...
;;         ... (node-adj (first somegraph)) ...
;;         ... (rest graph) ... ]))