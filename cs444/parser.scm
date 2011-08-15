(load "ada.scm")
(load "scanner.scm")
(load "parser_utils.scm")
(load "do.scm")
(load "generated_stuff.scm")
(require (lib "pretty.ss"))
(require (lib "trace.ss"))

(define DEBUG #f)
(define error #f)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; INTERFACE WITH LEXER
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define token-list '())

(define last-token '(1 1 0))
(define current-token '(1 1 0))
(define next-token '(1 1 0))

(define get-token
  (lambda ()
    (begin
      (set! last-token current-token)
      (set! current-token next-token)
      (set! next-token (list line column (string-length (token-name))))
      (if (null? token-list)
          (getnext)
          (let* ((token (car token-list))
                 (just (set! token-list '())))
            token)))))

(define peek-token
  (lambda ()
    (if (null? token-list)
        (begin (set! token-list (cons (getnext) token-list))
               (caar token-list))
        (caar token-list))))

(define token-name
  (lambda ()
    (begin
      (if (null? token-list) (begin (set! token-list (cons (getnext) token-list))))
      (cond
        ((equal? (caar token-list) "Int") (number->string (cadar token-list)))
        ((equal? (caar token-list) "Id") (caddar token-list))
        (else (caar token-list))))))

(define replace-token
  (lambda (tok)
    (begin
      (get-token)
      (set! token-list (cons tok token-list)))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; ERROR HANDLING
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(define ERROR_VAL (list 'error 'alpha))
(define recovering #f)
(define HEADER '("begin" "declare" "for" "function" "package" "procedure" "type" "when" "while" "eof"))

(define make-error
  (lambda (expected found)
    (begin
      (set! error #t)
      (if (not recovering)
          (let ((expected (without '() expected)))
            (begin
              (set! recovering #t)
              (display (string-append "***ERROR***:" 
                                      (number->string line) ":" 
                                      (number->string (max 1 (- column (string-length found)))) ":\tExpected "))
              (cond
                ((= (length expected) 1) (print (car expected)))
                ((= (length expected) 2) (display (string-append "\"" (car expected) "\" or \"" (cadr expected) "\"")))
                (else (begin (display "one of ") (print expected))))
              (display (string-append " but found \"" found "\""))
              (newline)
              ERROR_VAL))
          ERROR_VAL))))

(define mistakes
  `(("procedure" ("package"))
    ("for" ("loop"))
    ("is" (":=", "of"))
    ("of" ("is"))
    (":=" ("=", "is"))
    ("=" (":="))
    (";" ("loop"))
    ("," (";"))
    ("." (".."))
    ))

(define in-a-list?
  (lambda (x lst)
    (begin
      (if (in-list? x lst)
          #t
          (if (assoc x mistakes)
              (let* ((xs (cadr (assoc x mistakes)))
                     (findit (lambda (x) (if (in-list? x lst) x 'notfound)))
                     (found (without 'notfound (map findit xs))))
                (if (> (length found) 0)
                    (begin
                      (set! error #t)
                      (display (string-append "***ERROR***:" (number->string line) ":" (number->string (- column (string-length (peek-token)))) ":\tReplacing "))
                      (print x)
                      (display " with ")
                      (print (car found))
                      (if (> (length found) 1) (begin (display " out of possible ") (print found)))
                      (newline)
                      (replace-token (list (car found)))
                      #t)
                    #f))
              #f)))))

(define insertions '())

(define inserting
  (lambda (tok)
    (if (in-list? tok insertions)
        (begin
          (set! error #t)
          (display (string-append "***ERROR***:" (number->string (car next-token)) ":" (number->string (cadr next-token)) ":\tInserting "))
          (print tok)
          (newline)
          #t)
        #f)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; PARSER FUNCTIONS
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; only supports * and ?
(define regex-handler
  (lambda (regex nt)
    (let* ((op (car regex))
           (body (cdr regex))
           (counter 0)
           (just (if DEBUG (begin (display "Matching regex: ") (display regex) (newline))))
           (children '()))
      (do ()
        ((if (equal? op '*)
             (not (in-list? (peek-token) (first-rule regex)))
             
             (or (equal? counter 1) (not (in-list? (peek-token) (first-rule regex)))))
         children)
        (begin
          (set! counter (+ counter 1))
          (set! children (append children (map
                                           (lambda (var)
                                             (cond
                                               ((string? var) (mustbe var nt))
                                               ((symbol? var) (eval `(,var)))
                                               ((list? var) (regex-handler var nt))
                                               (else 'error)))
                                           body))))))))

(define mustbe
  (lambda (var nt)
    (if (equal? (peek-token) var)
        (begin
          (set! recovering #f)
          (get-token))
        (let* ((result (assq nt (force FOLLOW)))
               (followset (if result (cadr result) (begin (if DEBUG (display "INTERNAL ERROR: Non-terminal not found\n")) (exit)))))
          (cond
            ((in-list? (peek-token) (list var)) (begin
                                                  (set! recovering #f)
                                                  (get-token)))
            ((inserting var) var)
            (else (begin
                    (make-error (list var) (token-name))
                    (if (or (equal? (peek-token) "eof") (equal? var "eof") (exit))
                        (do ()
                          ((or
                            (equal? (peek-token) var)
                            (in-list? (peek-token) (first nt))
                            (in-list? (peek-token) followset)
                            (in-list? (peek-token) HEADER))
                           ERROR_VAL)
                          (begin
                            (if DEBUG (mdisplay "[mustbe " var "] Skipping: " (token-name)))
                            (get-token)))
                        (if (equal? (peek-token) var)
                            (begin
                              (set! recovering #f)
                              (get-token))
                            ERROR_VAL)))))))))

(define skipto
  (lambda (lst nt)
    (begin
      (make-error lst (token-name))
      (let* ((result (assq nt (force FOLLOW)))
             (followset (if result (cadr result) (begin (if DEBUG (display "INTERNAL ERROR: Non-terminal not found\n")) (exit)))))
        (begin
          (do ()
            ((or
              (in-list? (peek-token) lst)
              (in-list? (peek-token) followset)
              (in-list? (peek-token) HEADER))
             ERROR_VAL)
            (begin
              (if DEBUG (mdisplay "[skipto] Skipping: " (token-name)))
              (get-token)))
          (if (in-list? (peek-token) lst)
              (begin
                (set! recovering #f)
                (eval `(,nt)))
              ERROR_VAL))))))

(define parser start)

;(load "tracers.scm")
