(define line 1)
(define column 1)

(define new-line
  (lambda ()
    (begin
      (set! line (+ line 1))
      line)))

(define update-column
  (lambda (c)
    (cond
      ((eof-object? c) (set! column column))
      ((char=? c #\linefeed) (set! column 1))
      (else (set! column (+ column 1))))))

(define get-char
  (lambda ()
    (let* ((c (read-char))
           (just (update-column c)))
      c)))

(define dotdot? #f)

(define kont #f)

(define my-error
  (lambda (msg)
    (begin
      (display (string-append "***ERROR***:" (number->string line) ":" (number->string column) ":\t" msg "\n"))
      (set! error #t)
      (do ((c (get-char) (get-char)))
        ((or (eof-object? c) (is-delim? c)) (kont (getnext)))))))

;create a hash table for operators for easy lookup
(define ht (make-hash-table 'equal))  ; 43 keywords

(define operators
  '("abs" "access" "all" "and" "array" "begin" "body"
    "case" "constant" "declare" "else" "elsif" "end" "exception"
    "exit" "false" "for" "function" "generic" "if" "in" "is"
    "loop" "mod" "not" "null" "of" "or" "others" "out"
    "package" "pragma" "private" "procedure" "raise" "range"
    "record" "return" "reverse" "subtype" "then" "true"
    "type" "use" "when" "while"))

(define delim '(("="">")("."".")("*""*")(":""=")("/""=")(">""=")("<""=")("<""<")(">"">")("<"">")("'")(";")(",")("|")("&")("(")(")")("=")("+")("-")))

(define is-delim?
  (lambda (c) (or (eof-object? c)
                  (char=? c #\linefeed)
                  (char=? c #\space)
                  (let ((s (assoc (string c) delim)))
                    (if (and s
                             (= (length s) 2)
                             (equal? (string (peek-char))
                                     (cadr s)))
                      (begin (read-char) #t)
                      s)))))


;Add all the operators into a hash table
(for-each (lambda (str) (hash-table-put! ht str #t)) operators)

;char -> int
(define char->int
  (lambda (c)
    (- (char->integer c) 48)))

;char char char -> bool
(define in-between?
  (lambda (c1 c c2)
    (and (char-ci>=? c c1)
         (char-ci<=? c c2))))

;char -> bool
(define isdigit?
  (lambda (c)
    (in-between? #\0 c #\9)))

(define isalpha?
  (lambda (c)
    (in-between? #\A c #\Z)))
(define isalphanum?
  (lambda (c)
    (or (isalpha? c)
        (isdigit? c))))

; getnum reads in numbers only, while
; getint reads in digits and underscores
(define getnum
  (lambda (num)
    (if (isdigit? (peek-char))
      (getint (+ (* num 10) (char->int (get-char))))
      num)))

(define getint  ;;integer part of decimal
  (lambda (num)
    (let ((next (peek-char)))
      (cond
        ((char=? next #\_) (begin (get-char) (if (isdigit? (peek-char)) (getnum num) (begin (my-error "Consecutive underscores aren't allowed") 0))))
        ((isdigit? next) (getnum num))
        (else num)))))

(define getfloat
  (lambda ()
    (let* ((float (getnum 0))
           (next (peek-char)))
      (cons float
            (if (char-ci=? next #\E)
              (let* ((E (get-char))
                     (next-after (get-char)))
                (cond
                  ((char=? next-after #\+) (list (getnum 0)))
                  ((char=? next-after #\-) (list (- (getnum 0))))
                  ((isdigit? next-after) (list (getint (char->int next-after))))
                  (else (cons 0 '()))))
              (cons 0 '()))))))

(define getid
  (lambda ()
    (let ((c (peek-char)))
      (cond
        ((isalphanum? c) (begin
                           (get-char)
                           (cons c (getid))))
        ((char=? c #\_)
         (begin
           (get-char)
           (cons c
                 (cond
                   ((isalphanum? (peek-char)) (getid))
                   ((char=? #\_ (peek-char)) (my-error "Consecutive underscores aren't permitted."))
                   (else '())))))
        (else '())))))

(define getstring
  (lambda ()
    (let ((c (get-char)))
      (cond
        ((char=? c #\") (if (char=? (peek-char) #\")
                          (cons (get-char) (getstring))
                          '()))
        ((char=? c #\newline) (my-error "Unterminated string literal."))
        (else (cons c (getstring)))))))

(define getcomment
  (lambda ()
    (let ((c (get-char)))
      (if (or (eof-object? c) (char=? #\linefeed c))
        (begin (new-line) (getnext))
        (getcomment)))))

(define getnext
  (lambda ()
    (let* ((get-next 
             (lambda()
               (let ((c (get-char)))
                 (cond
                   ((eof-object? c) '("eof"))
                   ((char=? c #\space) (getnext))
                   ((char=? c #\tab) (getnext))
                   ((char=? c #\linefeed) (begin (new-line) (getnext)))
                   ((char=? c #\backspace) (getnext))
                   ((char=? c #\newline) (getnext))
                   ((char=? c #\return) (getnext))
                   ((char=? c #\;) '(";"))
                   ((char=? c #\:) (let ((c (peek-char)))
                                     (if (char=? c #\=)
                                       (begin (get-char)
                                              '(":="))
                                       '(":"))))
                   ((char=? c #\+) '("+"))
                   ((char=? c #\-) (let ((c (peek-char)))
                                     (if (char=? c #\-)
                                       (getcomment)
                                       '("-"))))
                   ((char=? c #\*) (let ((c (peek-char)))
                                     (if (char=? c #\*)
                                       (begin (get-char)
                                              '("**"))
                                       '("*"))))
                   ((char=? c #\/) (let ((c (peek-char)))
                                     (if (char=? c #\=)
                                       (begin (get-char)
                                              '("/="))
                                       '("/"))))
                   ((char=? c #\&) '("&"))
                   ((char=? c #\,) '(","))
                   ((char=? c #\() '("("))
                   ((char=? c #\)) '(")"))
                   ((char=? c #\.) (if dotdot?
                                     (begin (set! dotdot? #f)
                                            '(".."))
                                     (let ((c (peek-char)))
                                       (if (char=? c #\.)
                                         (begin (get-char)
                                                '(".."))
                                         '(".")))))
                   ((char=? c #\=) (let ((c (peek-char)))
                                     (if (char=? c #\>)
                                       (begin (get-char)
                                              '("=>"))
                                       '("="))))
                   ((char=? c #\<) (let ((c (peek-char)))
                                     (cond
                                       ((char=? c #\=) (begin (get-char)
                                                              '("<=")))
                                       ((char=? c #\>) (begin (get-char)
                                                              '("<>")))
                                       (else '("<")))))
                   ((char=? c #\>) (let ((c (peek-char)))
                                     (if (char=? c #\=)
                                       (begin (get-char)
                                              '(">="))
                                       '(">"))))
                   ((char=? c #\|) '("|"))
                   ((char=? c #\") (list "Str" (list->string (getstring))))
                   ((char=? c #\') '("'"))
                   ((isdigit? c)  (let* ((num (getint (char->int c)))
                                         (next (peek-char)))
                                    (cond
                                      ((char=? next #\.) (let* ((first-dot (get-char))
                                                                (next-after (peek-char)))
                                                           (if (char=? next-after #\.)
                                                             (begin (set! dotdot? #t)
                                                                    (list "Int" num 0))
                                                             (append (list "Float" num) (getfloat)))))
                                      ((char-ci=? next #\E) (begin
                                                              (get-char)
                                                              (let ((next (get-char)))
                                                                (cond
                                                                  ((char=? next #\-) (list "Float" num 0 (- (getnum 0))))
                                                                  ((char=? next #\+) (list "Int" num (getnum 0)))
                                                                  ((isdigit? next) (list "Int" num (getint (char->int next))))
                                                                  (else (my-error "Invalid exponent for an Integer Literal."))))))
                                      (else (list "Int" num 0)))))
                   ((isalpha? c) (let ((s (list->string (map char-downcase (cons c (getid))))))
                                   (if (hash-table-get ht s (lambda () #f))
                                     (list s)
                                     (list "Id" line s))))
                   (else  (my-error "Invalid token.")))))))
      (call/cc (lambda (k) (begin
                            (set! kont k)
                            (get-next)))))))
