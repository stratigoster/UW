(load "scope.scm")
(require (lib "match.ss"))
(require (lib "pretty.ss"))
(load "parser_utils.scm")

(define myprint
  (lambda (x)
    (if (string? x) (display x) (print x))))

(define mdisplay 
  (lambda L
    (map (lambda (x) (if (list? x)
                         (if (null? x)
                             (print '())
                             (begin
                               (myprint (car x))
                               (map (lambda (y) (begin (display " ") (myprint y))) (cdr x))))
                         (myprint x)))
         (append L '("\n")))))

(define terror #f)

(define val-of car)
(define type-of cadr)
(define const? caddr)

;;types:
;;  int
;;  float
;;  bool
;;  string

;;  ([String])        (enum)
;;  (1, 100, type)        (array 1..100 of type)
;;  ((name,type)...)      (record)

;;  ( [in] [out] type, ..) -> void    (proc)
;;  (type, ..) -> type      (func)

(define access? (lambda (T) (and (list? T) (eq? (car T) 'access))))

(define alpha? (lambda (T) (eq? T 'alpha)))
(define array? (lambda (T) (and (list? T) (eq? (car T) 'array))))
(define astring? (lambda (T) (eq? T 'string)))
(define bool? (lambda (T) (eq? T 'bool)))
(define enum? 
  (lambda (T) 
    (if (string? T)
        (enum? (lookup 'TYPE T))
        (and (list? T) (eq? (car T) 'enum)))))
(define exception? (lambda (T) (eq? T 'exception)))
(define float? (lambda (T) (eq? T 'float)))
(define int? (lambda (T) (eq? T 'int)))
(define record? (lambda (T) (and (list? T) (list? (cadr T)) (eq? (car T) 'record))))
(define void? (lambda (T) (eq? T 'void)))

(define ty-error
  (lambda msg
    (begin
      (set! terror #t)
      (mdisplay "***ERROR***:" (car msg) ":" (cadr msg) ":\t" (cdddr msg))
      (caddr msg))))

(define printt
  (match-lambda
    ('int "universal integer")
    ('bool "universal boolean")
    ('float "universal float")
    ('void "void")
    ('exception "exception")
    ('string "universal string")
    ('alpha "alpha")
    ('error "error")
    ((and t (? string?)) t)
    (('subtype x) (string-append "subtype of " (printt x)))
    ;    (('enum (and t ((? string?) ...)))
    (('enum (or (and t (? string?)) (and t (? list-of-strings?))))
     (if (not (list? t))
         (string-append "enum element " t)
         (string-append "overloaded enum element "
                        (foldl (lambda (x i)
                                 (string-append (if (equal? i "") "" (string-append i " "))
                                                (car x)))
                               "" t))))
    (('enum (and x (? list-of-lists?))) (string-append "enumeration of (" (foldl (lambda (y i) (string-append (if (equal? i "") "" (string-append i " "))
                                                                                                              (car y)))
                                                                                 "" x) ")"))
    (((and n (? number?)) (and s (? string?))) (printt s))
    (('record x) (string-append "record "
                                (foldl (lambda (y i)
                                         (string-append (if (equal? i "") "" (string-append i " "))
                                                        (car y)
                                                        ":"
                                                        (printt (cadr y))
                                                        "; "))
                                       "" x)))
    (('access T) (string-append "access to " T))
    (('UNCONST (and x (? string?))) (string-append x " range <>"))
    (('RANGE a b t) (string-append (printt t) ".." (printt t)))
    ((and a (? array?)) (string-append "array ["
                                       (foldl (lambda (x i)
                                                (string-append i
                                                               (if (equal? i "") "" ",")
                                                               (printt x)))
                                              "" (cadr a))
                                       "] of "
                                       (printt (caddr a))))
    ((num '-> params ret-type) (string-append "function ("
                                          (if (list? params)
                                              (foldl (lambda (x i)
                                                       (string-append (if (equal? i "")
                                                                          ""
                                                                          (string-append i ","))
                                                                      (if (and (list? x) (not (null? x)))
                                                                          (caddr x)
                                                                          (printt x))))
                                                     ""
                                                     params)
                                              (printt params))
                                          ") return " (printt ret-type)))
    (unknown (begin (if *types* (mdisplay "[printt] INTERNAL ERROR: Unknown type: " unknown) "beta")))
    ;...
    ))

(define list-of-strings?
  (lambda (L)
    (and (list? L) (not (memq #f (map string? L))))))

(define list-of-lists?
  (lambda (L)
    (and (list? L) (not (memq #f (map list? L))))))

(define apply?
  (match-lambda*
    ((t1 (-> t2 t3)) (if (U t1 t2) t3 #f))
    (_ #f)))

(define U
  (match-lambda*
    (('alpha _) #t)
    ((_ 'alpha) #t)
    (((and a (? symbol?)) (and b (? symbol?))) (eq? a b))
    (((and t (? string?)) (and e (? string?))) (equal? t e))
    (x (begin (mdisplay x) #f))))
;
;(define U
;  (match-lambda*
;    (((and x (? string?)) y) (U (string->symbol x) y))
;    ((x (and y (? string?))) (U x (string->symbol y)))
;    (((and x (? symbol?)) (and y (? symbol?))) (or (eq? x 'alpha) (eq? y 'alpha) (eq? x y)))
;    (x (begin (mdisplay "[U] No match for: " x) #f))))
