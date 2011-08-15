(require (lib "match.ss"))

(define print-reverse-stuff
  (lambda ()
    (begin
      (code #f "def _forwardGen(seq):\n")
      (open-block)
      (code #t "for i in seq:\n")
      (open-block)
      (code #t "yield { 'all':i }\n")
      (close-block)
      (close-block)
      (code #f "def _reverseGen(seq):\n")
      (open-block)
      (code #t "i = len(seq)\n")
      (code #t "while i>0:\n")
      (open-block)
      (code #t "i = i - 1\n")
      (code #t "yield { 'all':seq[i] }\n")
      (close-block)
      (close-block))))

(define prepare-py
  (lambda ()
    (begin
      (code #f "import math\n")
      (print-reverse-stuff)
      (code #f "class _dummy_(Exception):pass\n")
      (for-each (lambda (x) (code #f "class _" x "(Exception):pass\n")) except-list))))

;; stores the member variables of the current class
(define global-vars #f)
(define local-vars #f)

;; are we at the top level?
(define level 0)

;; new package; increase indentation
(define start-pkg
  (lambda ()
    (set! num-tabs (+ num-tabs 1))
    (set! global-vars (make-hash-table 'equal))))

;; close block; decrease indentation
(define finish-pkg
  (lambda ()
    ;    (set! num-tabs (- num-tabs 1))
    (set! global-vars #f)))

;; returns true if var is a global variable
(define global? (lambda (var) (and global-vars (hash-table-get global-vars var #f))))

;; returns true if var is a local variable
(define local? (lambda (var) (and local-vars (hash-table-get local-vars var #f))))

(define num-tabs 0)

;; new block; increase indentation
(define open-block
  (lambda ()
    (set! level (+ level 1))
    (set! num-tabs (+ num-tabs 1))))

;; close block; decrease indentation
(define close-block
  (lambda ()
    (set! level (- level 1))
    (set! num-tabs (- num-tabs 1))))

;; first element of L is a boolean variable that indicates whether we need to
;; print out tabs or not
(define code
  (lambda L
    (if (car L)
        (do ((i 1 (+ i 1)))
          ((< num-tabs i))
          (display "\t")))
    (map display (cdr L))))

(define PASS (lambda () (code #t "pass\n")))
(define DUMMY
  (lambda ()
    (begin
      (code #t "except _dummy_:\n")
      (open-block)
      (PASS)
      (close-block))))

(define expr-code
  (lambda (e1 op e2)
    (begin
      (code #f "(")
      (py-gen e1)
      (code #f op)
      (py-gen e2)
      (code #f ")"))))

(define float-code
  (lambda (num dec exp)
    (code #f (number->string num) "." (number->string dec) (exp-code exp))))

(define exp-code
  (lambda (exp)
    (if (= exp 0) "" (string-append "e" (number->string exp)))))

(define py-gen
  (match-lambda
    
    (('PKG name use head private body beginn except) (begin
                                                       (py-gen (list 'PKG-DECL name use head private '() '() '()))
                                                       (py-gen (list 'PKG-BODY name '() body beginn except))))
    
    (('PKG-DECL name use head private body beginn except) (begin
                                                            (code #t "class " name ":\n")
                                                            (start-pkg)
                                                            (code #t "try:\n")
                                                            (open-block) ;; open 1st try block
                                                            (for-each py-gen `(,head ,body ,beginn ,except))))
    
    (('PKG-BODY name use decl body except) (begin
                                             (py-gen decl)
                                             (code #t "def __init__(self):\n")
                                             (open-block) ;; open init block
                                             (code #t "try:\n") 
                                             (open-block) ;; open 2nd try block
                                             (PASS)
                                             (py-gen body)
                                             (close-block) ;; close 2nd try block
                                             (DUMMY)
                                             (py-gen except)
                                             (close-block) ;; close 1st try block
                                             (close-block) ;; close init block
                                             (DUMMY)
                                             (py-gen except)
                                             (finish-pkg)))
    
    ;; assignment to variable
    (('STORE var expr) (begin
                         (code #t (if (and (> level 1) (not (local? var)) (global? var)) "self." ""))
                         (py-gen var)
                         (code #f " = ")
                         (py-gen expr)
                         (code #f " \n")))
    
    ;; initialize variable
    (('INIT var expr) (begin
                        (if (= level 1) (hash-table-put! global-vars var #t) (hash-table-put! local-vars var #t))
                        (code #t var " = { 'all':")
                        (py-gen expr)
                        (code #f " }\n")))
    
    ;; binary operators
    (('PLUS e1 e2) (expr-code e1 " + " e2))
    (('MINUS e1 e2) (expr-code e1 " - " e2))
    (('POW e1 e2) (expr-code e1 " ** " e2))
    (('MUL e1 e2) (expr-code e1 " * " e2))
    (('DIV e1 e2) (expr-code e1 " / " e2))
    (('MOD e1 e2) (expr-code e1 " % " e2))
    (('CONCAT e1 e2) (expr-code e1 " + " e2))
    
    ((('PLUS e1 e2) T) (expr-code e1 " + " e2))
    ((('MINUS e1 e2) T) (expr-code e1 " - " e2))
    ((('POW e1 e2) T) (expr-code e1 " ** " e2))
    ((('MUL e1 e2) T) (expr-code e1 " * " e2))
    ((('DIV e1 e2) T) (expr-code e1 " / " e2))
    ((('MOD e1 e2) T) (expr-code e1 " % " e2))
    ((('CONCAT e1 e2) T) (expr-code e1 " + " e2))
    
    ;; literals    
    (((and num (? number?)) (and exp (? number?))) (code #f (number->string num) (exp-code exp)))
    (((and num (? number?)) (and dec (? number?)) (and exp (? number?))) (float-code num dec exp))
    
    ;; same as above, except with type information
    ((((and num (? number?)) (and exp (? number?))) T) (py-gen (list num exp)))
    ((((and num (? number?)) (and dec (? number?)) (and exp (? number?))) T) (py-gen num dec exp))
    
    ((and s (? string?)) (code #f (string-append "'" s "'")))
    (('VAR var) (code #f (if (and (> level 1) (not (local? var)) (global? var)) "self." "") var "['all']"))
    ((('VAR var) T) (py-gen (list 'VAR var)))
    
    ;; boolean operators
    (('AND e1 e2) (expr-code e1 " & " e2))
    (('OR e1 e2) (expr-code e1 " | " e2))
    (('AND-THEN e1 e2) (expr-code e1 " and " e2))
    (('OR-ELSE e1 e2) (expr-code e1 " or " e2))
    (('GEQ e1 e2) (expr-code e1 " >= " e2))
    (('GT e1 e2) (expr-code e1 " >" e2))
    (('LEQ e1 e2) (expr-code e1 " <= " e2))
    (('LT e1 e2) (expr-code e1 " < " e2))
    (('EQ e1 e2) (expr-code e1 " == " e2))
    (('NEQ e1 e2) (expr-code e1 " != " e2))
    
    (('NOT e1) (begin (code #f "(not ") (py-gen e1) (code #f ")")))
    (('ABS e1) (begin (code #f "abs(") (py-gen e1) (code #f ")")))
    (('NEG e1) (begin (code #f "-") (py-gen e1)))
    
    ;; strip off types in case we are given them
    ((('AND e1 e2) T) (expr-code e1 " & " e2))
    ((('OR e1 e2) T) (expr-code e1 " | " e2))
    ((('AND-THEN e1 e2) T) (expr-code e1 " and " e2))
    ((('OR-ELSE e1 e2) T) (expr-code e1 " or " e2))
    ((('GEQ e1 e2) T) (expr-code e1 " >= " e2))
    ((('GT e1 e2) T) (expr-code e1 " >" e2))
    ((('LEQ e1 e2) T) (expr-code e1 " <= " e2))
    ((('LT e1 e2) T) (expr-code e1 " < " e2))
    ((('EQ e1 e2) T) (expr-code e1 " == " e2))
    ((('NEQ e1 e2) T) (expr-code e1 " != " e2))
    
    ;; records
    (('Record ('void)) (code #f "{}"))
    (('Record fields) (begin
                        (code #f "{ ")
                        (code #f "'" (caar fields) "':")
                        (py-gen (cadar fields))
                        (for-each (lambda (x)
                                    (begin
                                      (code #f ", '" (car x) "':")
                                      (py-gen (cadr x))))
                                  (cdr fields))
                        (code #f " }")))
    
    (('Access) (code #f "{'all':0}"))
    
    (('LOOKUP-FIELD expr type field) (begin
                                       (py-gen expr)
                                       (code #f "['" field "']")))
    
    ;; pointers
    (('DEREF expr) (begin (py-gen expr) (code #f "['all']")))
    
    (('BEGIN stmts) (begin
                      (for-each py-gen stmts)
                      (set! local-vars #f)))
    (('DEF defns) (begin
                    (if (not local-vars)
                        (set! local-vars (make-hash-table 'equal)))
                    (for-each py-gen defns)))
    (('FUN name params decl body except) (begin
                                           ;                                           (mdisplay "LEVEL = " level)
                                           (if (not local-vars)
                                               (set! local-vars (make-hash-table 'equal)))
                                           (if (= level 1) (hash-table-put! global-vars name #t) (hash-table-put! local-vars name #t))
                                           (code #t "def " name "(" (if (= level 1) "self" ""))
                                           (if (not (null? params))
                                               (begin
                                                 (hash-table-put! local-vars (car params) #t)
                                                 (code #f (if (= level 1) "," "") (car params))
                                                 (for-each (lambda (var)
                                                             (begin
                                                               (hash-table-put! local-vars var #t)
                                                               (code #f "," var))) (cdr params)))
                                               ;; else do nothing
                                               )
                                           (code #f "):\n")
                                           (open-block)
                                           (code #t "try:\n")
                                           (open-block) ;; open try block
                                           (PASS)
                                           (for-each py-gen `(,decl ,body))
                                           (close-block) ;; close try block
                                           (DUMMY)
                                           (py-gen except)
                                           (close-block)
                                           ))
    
    (('SIG var) (begin
                  ;(mdisplay "LEVEL = " level)
                  (if (= level 1) (hash-table-put! global-vars var #t) (hash-table-put! local-vars var #t))))
    
    (('HEAD h) (for-each py-gen h))
    (('BODY b) (for-each py-gen b))
    (('PRIVATE p) (for-each py-gen p))
    (('EXCEPT e) (for-each py-gen e))
    
    (('LOOP name stmts) (begin
                          (code #t "try:\n")
                          (open-block)
                          (code #t "while True:\n")
                          (open-block)
                          (PASS)
                          (for-each py-gen stmts)
                          (close-block)
                          (close-block)
                          (code #t "except _" name ":\n")
                          (open-block)
                          (PASS)
                          (close-block)))
    (('EXIT name expr) (begin
                         (code #t "if ")
                         (py-gen expr)
                         (code #f ":\n")
                         (open-block)
                         (code #t "raise _" name "\n")
                         (close-block)))
    
    (('WHILE expr name body) (begin
                               (code #t "try:\n")
                               (open-block)
                               (code #t "while ")
                               (py-gen expr)
                               (code #f ":\n")
                               (open-block)
                               (PASS)
                               (for-each py-gen body)
                               (close-block)
                               (close-block)
                               (code #t "except _" name ":\n")
                               (open-block)
                               (PASS)
                               (close-block)))
    
    (('BLOCK name defns stmts except) (begin
                                        (code #t "def _" name "():\n")
                                        (open-block)
                                        (code #t "try:\n")
                                        (open-block) ;; open try block
                                        (PASS)
                                        (for-each py-gen `(,defns ,stmts))
                                        (close-block) ;; close try-block
                                        (DUMMY)
                                        (py-gen except)
                                        (close-block)
                                        (code #t "_" name "()\n")))
    
    ;; functions
    (('CALL name params) (begin
                           ;(mdisplay "--> LEVEL = " level)
                           (code #f (if (and (> level 1) (not (local? name)) (global? name)) "self." "") name "(")
                           (if (not (null? params))
                               (begin
                                 (py-gen (car params))
                                 (for-each (lambda (x)
                                             (code #f ",")
                                             (py-gen x))
                                           (cdr params))))
                           (code #f ")")))
    
    ((('CALL name params) T) (py-gen (list 'CALL name params)))
    
    
    ;; procedures
    (('PCALL name params) (begin
                            ;(mdisplay "--> LEVEL = " level)
                            (code #t (if (and (> level 1) (not (local? name)) (global? name)) "self." "") name "(")
                            (if (not (null? params))
                                (begin
                                  (py-gen (car params))
                                  (for-each (lambda (x)
                                              (code #f ",")
                                              (py-gen x))
                                            (cdr params))))
                            (code #f ")\n")))
    
    ((('PCALL name params) T) (py-gen (list 'PCALL name params)))
    
    ((var 'IN T expr) (begin
                        (code #f var " = {'all':")
                        (py-gen expr)
                        (code #f "}")))
    
    ((var 'OUT T expr) (begin
                         (code #f var " = {'all':")
                         (py-gen expr)
                         (code #f "}")))
    
    ((var 'IN-OUT T expr) (begin
                            (code #f var " = {'all':")
                            (py-gen expr)
                            (code #f "}")))
    
    (('RANGE e1 e2) (begin
                      (code #f "range(")
                      (py-gen e1)
                      (code #f ",")
                      (py-gen e2)
                      (code #f "+1)")))
    
    (('RANGE e1 e2 T) (py-gen `(RANGE ,e1 ,e2)))
    
    (('CASE var whenlist)
     (begin
       (if (not (null? whenlist))
           (begin
             (if (equal? 'ELSE (caar whenlist))
                 (for-each py-gen (cadar whenlist))
                 (let* ((when (car whenlist))
                        (ors (cadr when))
                        (stmts (caddr when)))
                   (begin
                     (if (equal? 'COR (car ors))
                         (begin
                           (if (equal? 'RANGE (caadr ors))
                               (begin
                                 (code #t "if (")
                                 (py-gen var)
                                 (code #f " in "))
                               (begin
                                 (code #t "if (")
                                 (py-gen var)
                                 (code #f " == ")))
                           (py-gen (cadr ors))
                           (code #f ")")
                           (for-each (lambda (x)
                                       (begin 
                                         (if (equal? (car x) 'RANGE)
                                             (begin
                                               (code #f " | (")
                                               (py-gen var)
                                               (code #f " in "))
                                             (begin
                                               (code #f " | (")
                                               (py-gen var)
                                               (code #f " == ")))
                                         (py-gen x)
                                         (code #f ")")))
                                     (cddr ors)))
                         (begin
                           (code #t "if (")
                           (py-gen var)
                           (if (equal? 'RANGE (caar ors))
                               (code #f " in ")
                               (code #f " == "))
                           (py-gen (car ors))
                           (code #f ")")))
                     (code #f ":\n")
                     (open-block)
                     (PASS)
                     (for-each py-gen stmts)
                     (close-block))))
             (for-each (lambda (when)
                         (begin
                           (if (equal? (car when) 'WHEN)
                               (let ((ors (cadr when))
                                     (stmts (caddr when)))
                                 (begin
                                   (if (equal? 'COR (car ors))
                                       (begin
                                         (if (equal? 'RANGE (caadr ors))
                                             (begin
                                               (code #t "elif (")
                                               (py-gen var)
                                               (code #f " in "))
                                             (begin
                                               (code #t "elif (")
                                               (py-gen var)
                                               (code #f " == ")))
                                         (py-gen (cadr ors))
                                         (code #f ")")
                                         (for-each (lambda (x)
                                                     (begin
                                                       (if (equal? (car x) 'RANGE)
                                                           (begin
                                                             (code #f " | (")
                                                             (py-gen var)
                                                             (code #f " in "))
                                                           (begin
                                                             (code #f " | (")
                                                             (py-gen var)
                                                             (code #f " == ")))
                                                       (py-gen x)
                                                       (code #f ")")))
                                                   (cddr ors))))
                                   (begin
                                     (code #t "elif (")
                                     (py-gen var)
                                     (code #f " == ")
                                     (py-gen (car ors))
                                     (code #f ")"))
                                   (code #f ":\n")
                                   (open-block)
                                   (PASS)
                                   (for-each py-gen stmts)
                                   (close-block)))
                               (begin
                                 (code #t "else:\n")
                                 (open-block)
                                 (PASS)
                                 (for-each py-gen (cadr when))
                                 (close-block)))))
                       (cdr whenlist)))
           'HUH)))
    
    (('FOR var reverse range ('LOOP name stmts)) (begin
                                                   (code #t "try:\n")
                                                   (open-block)
                                                   (code #t "for " var " in ")
                                                   (if (not (null? reverse))
                                                       (code #f "_reverseGen(")
                                                       (code #f "_forwardGen("))
                                                   (py-gen range)
                                                   (code #f "):\n")
                                                   (open-block)
                                                   (for-each py-gen stmts)
                                                   (close-block)
                                                   (close-block)
                                                   (code #t "except _dummy_:\n")
                                                   (open-block)
                                                   (PASS)
                                                   (close-block)))
    
    (('IF expr stmts elsifs else) (begin
                                    (code #t "if ")
                                    (py-gen expr)
                                    (code #f ":\n")
                                    (open-block)
                                    (for-each py-gen stmts)
                                    (close-block)
                                    (for-each py-gen elsifs)
                                    (py-gen else)))
    
    (('ELSIF expr stmts) (begin
                           (code #t "elif ")
                           (py-gen expr)
                           (code #f ":\n")
                           (open-block)
                           (for-each py-gen stmts)
                           (close-block)))
    
    (('ELSE stmts) (begin
                     (code #t "else:\n")
                     (open-block)
                     (for-each py-gen stmts)
                     (close-block)))
    
    (('RAISE) (code #t "raise\n"))
    
    (('RAISE e) (code #t "raise _" e "\n"))
    
    (('EIF name stmts) (begin
                         (code #t "except " (if (assoc name default-except) (cadr (assoc name default-except)) (string-append "_" name)) ":\n")
                         (open-block)
                         (for-each py-gen stmts)
                         (close-block)))
    
    (('EELSE stmts) (begin
                      (code #t "except:\n")
                      (open-block)
                      (for-each py-gen stmts)
                      (close-block)))
    
    (('RETURN) (code #t "return\n"))
    (('RETURN expr) (begin
                      (code #t "return ")
                      (py-gen expr)
                      (code #f "\n")))
    
    (('PRINT expr) (begin
                     (code #t "print ")
                     (py-gen expr)
                     (code #f ",\n")))
    
    (('READ-STR) (code #f "raw_input()"))
    (('READ-NUM) (code #f "input()"))
    
    ;; quoted attributes
    (('FLOOR expr) (begin
                     (code #f "math.floor(")
                     (py-gen expr)
                     (code #f ")")))
    
    (('CEILING expr) (begin
                       (code #f "math.ceil(")
                       (py-gen expr)
                       (code #f ")")))
    
    (('SUCC expr) (begin
                    (code #f "(1+")
                    (py-gen expr)
                    (code #f ")")))
    
    (('PRED expr) (begin
                    (code #f "(1-")
                    (py-gen expr)
                    (code #f ")")))
    
    (('POS expr) (py-gen expr))
    
    (('TOINT expr) (begin
                     (code #f "int(")
                     (py-gen expr)
                     (code #f ")")))
    
    (('TOFLOAT expr) (begin
                     (code #f "float(")
                     (py-gen expr)
                     (code #f ")")))
    
    (('LEN str) (begin
                  (code #f "len(")
                  (py-gen str)
                  (code #f ")")))
    
    ('void (PASS))
    ('null (PASS))
    (() 'blah)
    (_ 'crap)))
