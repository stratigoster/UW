;; store signatures of packages
;; library: pkg-name -> [hash-table]
;; most recent scope is at front of listt
(define library (make-hash-table 'equal))

;; we are using separate hash-tables for procedure types and variable types
(define-struct VAR (info))
(define-struct TYPE (info))
(define-struct FUN (info))
(define-struct EX (info))
(define-struct LABEL (info))

(define lc-false (lambda () #f))

(define global-scope (make-hash-table 'equal))
(for-each (lambda (x) (hash-table-put! global-scope (car x) (make-TYPE (cadr x)))) '(("boolean" bool) ("float" float) ("integer" int) ("string" string)))

(define no-pkg (lambda () (begin (mdisplay "***INTERNAL ERROR***:" line ":" column ":\tCannot find package `" pkg-name "'"))))

(define create-scope!
  (lambda ()
    (if (not (hash-table-get library pkg-name lc-false))
        (hash-table-put! library pkg-name (list (make-hash-table 'equal) global-scope))
        (begin
          (set! terror #t)
          (mdisplay "***ERROR***:" line ":" column ":\tMultiple definitions for package \"" pkg-name "\"")))))

;; adds a scope to pkg-name, ie. a new hash-table
(define append-scope!
  (lambda ()
    (let ((hts (hash-table-get library pkg-name lc-false)))
      (if hts
          (hash-table-put! library pkg-name (cons (make-hash-table 'equal) hts))
          (no-pkg)))))

;; removes the most recent scope
(define delete-scope!
  (lambda ()
    (let ((ht (hash-table-get library pkg-name lc-false)))
      (if (and (list? ht) (> (length ht) 1))
          (hash-table-put! library pkg-name (cdr ht))
          (begin
            (mdisplay "***INTERNAL ERROR***:" 
                      line ":" column
                      ":\tCannot find package or attempting to delete top-level scope \"" pkg-name "\"")
            (exit))))))

(define insert-info!
  (lambda (selector name info)
    (let* ((hts (hash-table-get library pkg-name lc-false))
           (just (if *types* (mdisplay "Inserting `" name ":" (printt info) "'")))
           (ht (if hts
                   (car hts)
                   (no-pkg)))
           (l-types (hash-table-get ht name lc-false))
           (conflict (lambda ()
                       (let ((l-types (cond ((VAR? l-types) (VAR-info l-types))
                                            ((TYPE? l-types) (TYPE-info l-types))
                                            ((FUN? l-types) info)
                                            (else 'crap))))
                         (begin
                           (set! terror #t)
                           (mdisplay "***ERROR***:" line ":" column ":\tDeclaration `" name ":" (printt info) "'"
                                     " conflicts with `" name ":" (printt l-types) "'"))
                         #f))))
      (cond
        ((equal? selector 'VAR) (if (not l-types)
                                    (hash-table-put! ht name (make-VAR info))
                                    (conflict)))
        ((equal? selector 'EXCEPT) (if (not l-types)
                                    (hash-table-put! ht name (make-EX info))
                                    (conflict)))
        ((equal? selector 'LABEL) (if (not l-types)
                                      (hash-table-put! ht name (make-LABEL info))
                                      (conflict)))
        ((equal? selector 'TYPE) (if (or (not l-types) (and (TYPE? l-types) (equal? (TYPE-info l-types) 'void)))
                                     (begin
                                       (hash-table-put! ht name (make-TYPE info))
                                       (if (enum? info)
                                           (let ((tmp-ht (make-hash-table 'equal)))
                                             (for-each (lambda (x)
                                                         (if (hash-table-get tmp-ht (car x) lc-false)
                                                             (begin
                                                               (set! terror #t)
                                                               (mdisplay "***ERROR***:" line ":" column "\tConflicting declaration of `" (car x) "'"))
                                                             (begin
                                                               (hash-table-put! tmp-ht (car x) #t)
                                                               (insert-info! 'ENUM-ELEM (car x) name))))
                                                       (cadr info)))
                                           ;; else do nothing (nothing to insert)
                                           ))
                                     (conflict)))
        ((equal? selector 'ENUM-ELEM) (if l-types
                                          (if (and (VAR? l-types) (enum? (VAR-info l-types)))
                                              (hash-table-put! ht name (make-VAR (cons 'enum (cons info (cdr (VAR-info l-types))))))
                                              (conflict))
                                          (hash-table-put! ht name (make-VAR (list 'enum info)))))
        ((equal? selector 'FUN-DECL)  (if l-types
                                          (if (and (FUN? l-types) (not (fun-already-defined? info (FUN-info l-types))))
                                              (hash-table-put! ht name (make-FUN (cons info (FUN-info l-types))))
                                              (begin
                                                (set! terror #t)
                                                (mdisplay "***ERROR***:" line ":" column ":\tConflicting declaration `" name ":" (printt info) "'")))
                                          (hash-table-put! ht name (make-FUN (list info)))))
        ((equal? selector 'FUN-BODY)  (if l-types
                                          (if (and (FUN? l-types) (not (fun-already-defined? info (FUN-info l-types))))
                                              (begin
                                                (mdisplay "before " (FUN-info l-types))
                                                (mdisplay "overwriting " name)
                                                
                                                (hash-table-put! ht name (make-FUN (change-num info (FUN-info l-types))))
                                                (mdisplay "after " (FUN-info (hash-table-get ht name #f))))
                                              ;; else do nothing - it's already there
                                              )
;                                              (if (not (equal? '(-> void void) info))
;                                                  (begin
;                                                    (set! terror #t)
;                                                    (mdisplay "***ERROR***:" line ":" column ":\tConflicting declaration `" name ":" (printt info) "'")))
                                          (hash-table-put! ht name (make-FUN (list info)))))
        (else (mdisplay "[insert-info] Unknown selector: " selector))
        ))))

(define change-num
  (lambda (sig siglist)
    (foldr (lambda (x i)
             (begin
               (if (equal? (cdr x) (cdr sig)) (set-car! x (car sig)))
               (cons x i)))
           '() siglist)))

(define get-fun-types
  (lambda (L)
    (map (lambda (x) (if (list? x) (lookup 'TYPE (caddr x)) x)) L)))

;;; a function is a 3-tuple [-> [[x in type #f] ... ] type]
;(define fun-already-defined?
;  (lambda (fun fun-list)
;;    (mdisplay "fun: " fun)
;;    (mdisplay "fun-list: " fun-list)
;    (if (null? fun-list)
;        'NO
;        ;; if the param types are the same, check the type of the return value
;        (if (or (and (list? (caddr fun))
;                     (list? (caddar fun-list))
;                     (equal? (get-fun-types (caddr fun)) (get-fun-types (caddar fun-list)))
;                     (equal? (cadddr fun) (car (cdddar fun-list))))
;                (and (equal? (caddr fun) (caddar fun-list))
;                     (equal? (cadddr fun) (car (cdddar fun-list)))))
;            (if (caar fun-list) 'YES 'HEAD)
;            (fun-already-defined? fun (cdr fun-list))))))

;; a function is a 3-tuple [-> [[x in type #f] ... ] type]
(define fun-already-defined?
  (lambda (fun fun-list)
;    (mdisplay "fun: " fun)
;    (mdisplay "fun-list: " fun-list)
    (if (null? fun-list)
        #f
        ;; if the param types are the same, check the type of the return value
        (if (or (and (list? (caddr fun))
                     (list? (caddar fun-list))
                     (equal? (get-fun-types (caddr fun)) (get-fun-types (caddar fun-list)))
                     (equal? (cadddr fun) (car (cdddar fun-list))))
                (and (equal? (caddr fun) (caddar fun-list))
                     (equal? (cadddr fun) (car (cdddar fun-list)))))
            #t
            (fun-already-defined? fun (cdr fun-list))))))

;; lookup :: selector name -> type | #f
(define lookup
  (lambda (selector name)
    (letrec ((ht-list (or (hash-table-get library pkg-name lc-false) (no-pkg)))
             (lookup2 (lambda (L)
                        (if (null? L)
                            #f
                            (let ((type (hash-table-get (car L) name lc-false)))
                              (or type (lookup2 (cdr L)))))))
             (type (lookup2 ht-list)))
      (cond
        ((equal? selector 'VAR) (if (VAR? type) (VAR-info type) #f))
        ((equal? selector 'LABEL) (if (LABEL? type) (LABEL-info type) #f))
        ((equal? selector 'TYPE) (if (TYPE? type) (TYPE-info type) #f))
        ((equal? selector 'FUN) (if (FUN? type) (FUN-info type) #f))
        ((equal? selector 'EXCEPT) (if (EX? type) (EX-info type) #f))
        (else (mdisplay "[lookup] Unknown selector: " selector))))))
