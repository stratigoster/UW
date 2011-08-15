(load "ada.scm")
(load "parser_utils.scm")
(require (lib "pretty.ss"))

(define DEBUG #f)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; PARSER GENERATOR
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define make-parser
  (lambda ()
    `(define parser (lambda () (letrec ((regex-handler ,handle-regex) (mustbe ,handle-terminal) ,@(map make-fxn cfg)) (start))))))

(define make-rest-of-rule
  (lambda (rhs nt)
    (map (lambda (x)
           (cond
             ((string? x) `(mustbe ,x ',nt))
             ((symbol? x) `(,x))
             ((list? x) `(regex-handler ',x ',nt))
             (else 'error)))
         rhs)))

(define spider
  (lambda (nt rest)
;    (if (equal? nt 'id-rest) (begin (display "rest: ")(display rest) (newline)))
	`(,@(list (string->symbol (string-append "do-" (symbol->string nt)))
                  `(list ,@(map (lambda (x) `(lambda () ,x)) (cdr rest)))))))

;(define spider
;  (lambda (nt rest)
;	`(if error
;	   ,rest
;	   (,@(list (string->symbol (string-append "do-" (symbol->string nt)))
;                  `(list ,@(map (lambda (x) `(lambda () ,x)) (cdr rest))))))))

(define make-cond-stmts
  (lambda (nt rhs)
    (let ((else-stmt (if (has-epsilon? rhs)
                         '(else '())
                         `(else (skipto ',(first-rule nt) ',nt)))))
;;                         `(else (make-error ',(first-rule nt) (token-name))))))
      `(,@(map (lambda (var) 
                 (if (not (null? var))
                     (cond
                       ((list? (car var)) `((let ((FIRST ',(first-rule var))) (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
                                            ,(spider nt `(list (regex-handler ',(car var) ',nt) ,@(make-rest-of-rule (cdr var) nt)))))
                       ((string? (car var))
                        `((equal? (peek-token) ,(car var)) ,(spider nt `(list (mustbe ,(car var) ',nt) ,@(make-rest-of-rule (cdr var) nt)))))
                       (else `((let ((FIRST ',(first-rule var)))
                                 (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
                               ,(spider nt `(list ,@(make-rest-of-rule var nt))))))
                     '((equal? #t #f) #f))) rhs) ,else-stmt))))

(define make-fxn
  (lambda (rule)
    (begin
      (if DEBUG
          (begin
            (display "Making function for:") (display rule) (newline)))
      (list 'define (car rule)
            (let ((nt (car rule)) (rhs (cdr rule)))
              (if (equal? 1 (length rhs))
                  (cond
                    ((string? (caar rhs)) `(lambda () ,(spider nt `(list (mustbe ,(caar rhs) ',nt) ,@(make-rest-of-rule (cdar rhs) nt)))))
                    ((symbol? (caar rhs)) `(lambda () ,(spider nt `(list ,@(make-rest-of-rule (car rhs) nt)))))
                    ((list? (caar rhs))
                     (if (or (equal? (caaar rhs) '*) (equal? (caaar rhs) '?))
                         `(lambda () ,(spider nt `(list (regex-handler ',(caar rhs) ',nt) ,@(make-rest-of-rule (cdar rhs) nt))))
                         `(lambda () ,(spider nt (make-rest-of-rule (car rhs) nt)))))
                    (else 'error))
                  `(lambda () (cond ,@(make-cond-stmts nt rhs)))))))))

(pretty-print `(define FOLLOW (delay ',(map (lambda (x) (list x (follow x))) (map car cfg)))))
(for-each pretty-print (map make-fxn cfg))