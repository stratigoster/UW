;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; UTILITIES
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (foldl f i L)
  (if (null? L)
      i
      (foldl f (f (car L) i) (cdr L))))

(define (foldr f i L)
  (if (null? L)
      i
      (f (car L) (foldr f i (cdr L)))))

; if item is in the list
(define in-list?
  (lambda (x lst)
    (foldl (lambda (n i) (or i (equal? n x))) #f lst)))

(define without
  (lambda (x lst)
    (foldr (lambda (n i)
             (if (equal? n x) i (cons n i))) '() lst)))

(define collision?
  (lambda (lst)
    (if (null? lst)
        #f
        (or (in-list? (car lst) (cdr lst)) (collision? (cdr lst))))))

(define check
  (lambda ()
    (without '() (map (lambda(x) (if (collision? (without '() (first-rule x)))
                                     x
                                     '())) 
                      (map car cfg)))))

(define continue
  (lambda (term i)
    (if (in-list? '() i)
        (append (without '() i) (first-rule term))
        i)))

(define first-rule
  (lambda (rule)
    (cond
      ((null? rule) (list rule))
      ((string? rule) (list rule))
      ((symbol? rule) (first rule))
      ((list? rule)
       (if (or (equal? (car rule) '?) (equal? (car rule) '*))
           `(,@(first-rule (cdr rule)) ())
           (foldl continue '(()) rule)))
      (else 'error_firstrule))))

(define first
  (lambda (nonterm)
    (cond 
      ((string? nonterm) (list nonterm))
      ((symbol? nonterm) (let* ((rules (cdr (assq nonterm cfg)))
                                (FIRST (apply append (map first-rule rules))))
                           (if (in-list? '() FIRST)
                               `(,@(without '() FIRST) ())
                               FIRST)))
      (else 'error_first))))

(define follow
  (lambda (nonterm)
    (remove-stuff
     (unroll 
      (map
       (lambda (y) ;; handle each production in a rule
         (let ((curr_nt (car y)))
           (map 
            (lambda (x) ;; handle a single production
              (letrec 
                  ((follow-rule
                    (lambda (i L)
                      (cond
                        ((null? L) i)
                        ((string? (car L)) (follow-rule i (cdr L)))
                        ((symbol? (car L))
                         (if (equal? (car L) nonterm)
                             (if (null? (cdr L))
                                 (if (equal? curr_nt nonterm)
                                     i
                                     (append (follow curr_nt) i))
                                 (follow-rule (append (first-rule (cdr L)) i) (cdr L)))
                             i))
                        ((list? (car L)) (follow-rule (append i (follow-regex nonterm curr_nt (cdar L) (cdr L))) (cdr L)))
                        (else 'error))))
                   (follow-regex 
                    (lambda (nonterm curr_nt body rest)
                      (cond
                        ((null? body) '())
                        ((symbol? (car body))
                         (if (equal? (car body) nonterm)
                             (if (null? (cdr body))
                                 (if (null? rest)
                                     (if (equal? curr_nt nonterm)
                                         '()
                                         (follow curr_nt))
                                     (first-rule rest))
                                 (if (list? (cadr body))
                                     (if (null? (cddr body))
                                         (if (null? rest)
                                             (if (equal? nonterm curr_nt)
                                                 (first-rule (cdr body))
                                                 (append (follow curr_nt) (first-rule (cdr body))))
                                             (append (first-rule (cdr body)) (first-rule rest)))
                                         (if (list? (cddr body))
                                             (append (follow-rule '() `(,(append (list '? nonterm) (cddr body)) ,@rest)) (first-rule (cdr body)))
                                             (append (first-rule (cddr body)) (first-rule (cdr body)))))
                                     (first-rule (cdr body))))
                             (follow-regex nonterm curr_nt (cdr body) rest)))
                        ((string? (car body)) (follow-regex nonterm curr_nt (cdr body) rest))
                        ((list? (car body))
                         (let ((FOLLOW (follow-regex nonterm curr_nt (cdar body) (cdr body))))
                           (if (not (null? FOLLOW))
                               (follow-rule (cdr body) FOLLOW)
                               '())))
                        (else 'error)))))
                (follow-rule '() x)))
            (cdr y))))
       cfg)) '())))

;; removes duplicates, #f, and '()
(define remove-stuff
  (lambda (L i)
    (if (null? L)
        i
        (if (or (equal? (car L) #f) (equal? (car L) '()) (in-list? (car L) i))
            (remove-stuff (cdr L) i)
            (remove-stuff (cdr L) (cons (car L) i))))))

(define unroll
  (lambda (L)
    (cond
      ((null? L) L)
      ((list? (car L)) (append (unroll (car L)) (unroll (cdr L))))
      (else L))))

(define make-node
  (lambda (value children)
    (list value children)))

(define has-epsilon?
  (lambda (rhs)
    (eval `(or ,@(map null? rhs)))))

(define has-terminal?
  (lambda (rhs)
    (eval `(or ,@(map string? rhs)))))
