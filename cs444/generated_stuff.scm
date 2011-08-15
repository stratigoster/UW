(define FOLLOW
  (delay
   '((start ())
     (package ("eof" "package" "generic"))
     (package-rest ("generic" "package" "eof"))
     (package-decl ("eof" "package" "generic"))
     (package-body ("eof" "package" "generic"))
     (head ("end" "exception" "begin" "body" "private"))
     (decl ("end" "exception" "begin"))
     (except ("end"))
     (except-tail ("end"))
     (use ("private" "body" "begin" "exception" "end"))
     (var-decl ("Id" "private" "body" "begin" "exception" "end"))
     (var-type (";" ":="))
     (var-type2 (":=" ";"))
     (type-decl ("private" "body" "begin" "exception" "end"))
     (type-decl2 ("end" "exception" "begin" "body" "private"))
     (type-decl3 ("private" "body" "begin" "exception" "end"))
     (enum-decl ("end" "exception" "begin" "body" "private"))
     (array-decl ("end" "exception" "begin" "body" "private"))
     (bound (")" ","))
     (bound2 ())
     (bound3 ())
     (range ("loop" "," ")" ";" ":="))
     (record-decl ("end" "exception" "begin" "body" "private"))
     (component ("end"))
     (access-decl ("end" "exception" "begin" "body" "private"))
     (fun-sig ("is" ";"))
     (fun-name ("return" "("))
     (fun-decl ("private" "body" "begin" "exception" "end"))
     (fun-body ("begin" "exception" "end"))
     (proc-sig ("is" ";"))
     (proc-decl ("private" "body" "begin" "exception" "end"))
     (proc-body ("begin" "exception" "end"))
     (param-list (";" "is"))
     (param (")" ";"))
     (statement ("exception" "end"))
     (id-rest ("end" "exception"))
     (subname (";" ":="))
     (cas ("end" "exception"))
     (id-rest2 ("exception" "end"))
     (block ("end" "exception"))
     (loop ("end" "exception"))
     (while ("end" "exception"))
     (for ("end" "exception"))
     (when-list ())
     (expr ("=>" "|" "is" "then" ":=" ";" ")" "," "loop" ".." "range"))
     (orelse ())
     (expr2 ("range" ".." "loop" "," ")" ";" ":=" "then" "is" "|" "=>" "or"))
     (andthen ())
     (relation
       ("or" "=>" "|" "is" "then" ":=" ";" ")" "," "loop" ".." "range" "and"))
     (relat_op ())
     (simp_expr
       ("and"
        "range"
        ".."
        "loop"
        ","
        ")"
        ";"
        ":="
        "then"
        "is"
        "|"
        "=>"
        "or"
        ">="
        ">"
        "<="
        "<"
        "/="
        "="))
     (unary_op ("abs" "not" "(" "Id" "Str" "false" "true" "Float" "Int"))
     (adding_op ())
     (term
      ("="
       "/="
       "<"
       "<="
       ">"
       ">="
       "or"
       "=>"
       "|"
       "is"
       "then"
       ":="
       ";"
       ")"
       ","
       "loop"
       ".."
       "range"
       "and"
       "&"
       "-"
       "+"))
     (mult_op ())
     (factor
       ("+"
        "-"
        "&"
        "and"
        "range"
        ".."
        "loop"
        ","
        ")"
        ";"
        ":="
        "then"
        "is"
        "|"
        "=>"
        "or"
        ">="
        ">"
        "<="
        "<"
        "/="
        "="
        "mod"
        "/"
        "*"))
     (primary
       ("*"
        "/"
        "mod"
        "="
        "/="
        "<"
        "<="
        ">"
        ">="
        "or"
        "=>"
        "|"
        "is"
        "then"
        ":="
        ";"
        ")"
        ","
        "loop"
        ".."
        "range"
        "and"
        "&"
        "-"
        "+"
        "**"))
     (literal
       ("**"
        "+"
        "-"
        "&"
        "and"
        "range"
        ".."
        "loop"
        ","
        ")"
        ";"
        ":="
        "then"
        "is"
        "|"
        "=>"
        "or"
        ">="
        ">"
        "<="
        "<"
        "/="
        "="
        "mod"
        "/"
        "*"))
     (name-part
       ("**"
        "+"
        "-"
        "&"
        "and"
        "range"
        ".."
        "loop"
        ","
        ")"
        ";"
        ":="
        "then"
        "is"
        "|"
        "=>"
        "or"
        ">="
        ">"
        "<="
        "<"
        "/="
        "="
        "mod"
        "/"
        "*"))
     (agg
      ("*"
       "/"
       "mod"
       "="
       "/="
       "<"
       "<="
       ">"
       ">="
       "or"
       "=>"
       "|"
       "is"
       "then"
       ":="
       ";"
       ")"
       ","
       "loop"
       ".."
       "range"
       "and"
       "&"
       "-"
       "+"
       "**"))
     (agg-list
       ("*"
        "/"
        "mod"
        "="
        "/="
        "<"
        "<="
        ">"
        ">="
        "or"
        "=>"
        "|"
        "is"
        "then"
        ")"
        ","
        "loop"
        ".."
        "range"
        "and"
        "&"
        "-"
        "+"
        "**"
        ";"
        ":="
        "."))
     (name-list (")" "," "=>"))
     (name-rest
       ("*"
        "/"
        "mod"
        "="
        "/="
        "<"
        "<="
        ">"
        ">="
        "or"
        "=>"
        "|"
        "is"
        "then"
        ")"
        ","
        "loop"
        ".."
        "range"
        "and"
        "&"
        "-"
        "+"
        "**"
        ":="
        ";")))))
(define start
  (lambda ()
    (do-start
      (list
       (lambda () (package))
       (lambda () (regex-handler '(* package) 'start))
       (lambda () (mustbe "eof" 'start))))))
(define package
  (lambda ()
    (do-package
      (list
       (lambda () (regex-handler '(? "generic" (* head)) 'package))
       (lambda () (mustbe "package" 'package))
       (lambda () (package-rest))))))
(define package-rest
  (lambda ()
    (cond
     ((let ((FIRST '("Id")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-package-rest (list (lambda () (package-decl)))))
     ((let ((FIRST '("body")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-package-rest (list (lambda () (package-body)))))
     (else (skipto '("Id" "body") 'package-rest)))))
(define package-decl
  (lambda ()
    (do-package-decl
      (list
       (lambda () (mustbe "Id" 'package-decl))
       (lambda () (mustbe "is" 'package-decl))
       (lambda () (regex-handler '(* head) 'package-decl))
       (lambda () (regex-handler '(? "private" (* type-decl)) 'package-decl))
       (lambda () (regex-handler '(? "body" (* decl)) 'package-decl))
       (lambda () (regex-handler '(? "begin" (* statement)) 'package-decl))
       (lambda () (regex-handler '(? "exception" (* except)) 'package-decl))
       (lambda () (mustbe "end" 'package-decl))
       (lambda () (regex-handler '(? "Id") 'package-decl))
       (lambda () (mustbe ";" 'package-decl))))))
(define package-body
  (lambda ()
    (do-package-body
      (list
       (lambda () (mustbe "body" 'package-body))
       (lambda () (mustbe "Id" 'package-body))
       (lambda () (mustbe "is" 'package-body))
       (lambda () (regex-handler '(* decl) 'package-body))
       (lambda () (regex-handler '(? "begin" (* statement)) 'package-body))
       (lambda () (regex-handler '(? "exception" (* except)) 'package-body))
       (lambda () (mustbe "end" 'package-body))
       (lambda () (regex-handler '(? "Id") 'package-body))
       (lambda () (mustbe ";" 'package-body))))))
(define head
  (lambda ()
    (cond
     ((let ((FIRST '("type" "subtype")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-head (list (lambda () (type-decl)))))
     ((let ((FIRST '("use")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-head (list (lambda () (use)))))
     ((let ((FIRST '("function")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-head (list (lambda () (fun-decl)))))
     ((let ((FIRST '("procedure")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-head (list (lambda () (proc-decl)))))
     ((let ((FIRST '("Id")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-head (list (lambda () (var-decl)))))
     (else
      (skipto '("type" "subtype" "use" "function" "procedure" "Id") 'head)))))
(define decl
  (lambda ()
    (cond
     ((let ((FIRST '("function")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-decl (list (lambda () (fun-body)))))
     ((let ((FIRST '("procedure")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-decl (list (lambda () (proc-body)))))
     ((let ((FIRST '("use")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-decl (list (lambda () (use)))))
     ((let ((FIRST '("type" "subtype")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-decl (list (lambda () (type-decl)))))
     ((let ((FIRST '("Id")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-decl (list (lambda () (var-decl)))))
     (else
      (skipto '("function" "procedure" "use" "type" "subtype" "Id") 'decl)))))
(define except
  (lambda ()
    (do-except
      (list (lambda () (mustbe "when" 'except)) (lambda () (except-tail))))))
(define except-tail
  (lambda ()
    (cond
     ((equal? (peek-token) "others")
      (do-except-tail
        (list
         (lambda () (mustbe "others" 'except-tail))
         (lambda () (mustbe "=>" 'except-tail))
         (lambda () (regex-handler '(* statement) 'except-tail)))))
     ((equal? (peek-token) "Id")
      (do-except-tail
        (list
         (lambda () (mustbe "Id" 'except-tail))
         (lambda () (regex-handler '(* "|" "Id") 'except-tail))
         (lambda () (mustbe "=>" 'except-tail))
         (lambda () (regex-handler '(* statement) 'except-tail)))))
     (else (skipto '("others" "Id") 'except-tail)))))
(define use
  (lambda ()
    (do-use
      (list
       (lambda () (mustbe "use" 'use))
       (lambda () (mustbe "Id" 'use))
       (lambda () (regex-handler '(* "," "Id") 'use))
       (lambda () (mustbe ";" 'use))))))
(define var-decl
  (lambda ()
    (do-var-decl
      (list
       (lambda () (mustbe "Id" 'var-decl))
       (lambda () (regex-handler '(* "," "Id") 'var-decl))
       (lambda () (mustbe ":" 'var-decl))
       (lambda () (regex-handler '(? "constant") 'var-decl))
       (lambda () (var-type))
       (lambda () (regex-handler '(? ":=" expr) 'var-decl))
       (lambda () (mustbe ";" 'var-decl))))))
(define var-type
  (lambda ()
    (cond
     ((equal? (peek-token) "Id")
      (do-var-type
        (list
         (lambda () (mustbe "Id" 'var-type))
         (lambda () (regex-handler '(? var-type2) 'var-type)))))
     ((equal? (peek-token) "exception")
      (do-var-type (list (lambda () (mustbe "exception" 'var-type)))))
     (else (skipto '("Id" "exception") 'var-type)))))
(define var-type2
  (lambda ()
    (cond
     ((equal? (peek-token) "range")
      (do-var-type2
        (list (lambda () (mustbe "range" 'var-type2)) (lambda () (range)))))
     ((equal? (peek-token) "(")
      (do-var-type2
        (list
         (lambda () (mustbe "(" 'var-type2))
         (lambda () (range))
         (lambda () (mustbe ")" 'var-type2)))))
     (else (skipto '("range" "(") 'var-type2)))))
(define type-decl
  (lambda ()
    (cond
     ((equal? (peek-token) "type")
      (do-type-decl
        (list
         (lambda () (mustbe "type" 'type-decl))
         (lambda () (mustbe "Id" 'type-decl))
         (lambda () (type-decl2)))))
     ((equal? (peek-token) "subtype")
      (do-type-decl
        (list
         (lambda () (mustbe "subtype" 'type-decl))
         (lambda () (mustbe "Id" 'type-decl))
         (lambda () (mustbe "is" 'type-decl))
         (lambda () (var-type))
         (lambda () (mustbe ";" 'type-decl)))))
     (else (skipto '("type" "subtype") 'type-decl)))))
(define type-decl2
  (lambda ()
    (cond
     ((equal? (peek-token) ";")
      (do-type-decl2 (list (lambda () (mustbe ";" 'type-decl2)))))
     ((equal? (peek-token) "is")
      (do-type-decl2
        (list (lambda () (mustbe "is" 'type-decl2)) (lambda () (type-decl3)))))
     (else (skipto '(";" "is") 'type-decl2)))))
(define type-decl3
  (lambda ()
    (cond
     ((let ((FIRST '("(")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-type-decl3 (list (lambda () (enum-decl)))))
     ((let ((FIRST '("array")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-type-decl3 (list (lambda () (array-decl)))))
     ((let ((FIRST '("record")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-type-decl3 (list (lambda () (record-decl)))))
     ((let ((FIRST '("access")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-type-decl3 (list (lambda () (access-decl)))))
     ((equal? (peek-token) "private")
      (do-type-decl3
        (list
         (lambda () (mustbe "private" 'type-decl3))
         (lambda () (mustbe ";" 'type-decl3)))))
     (else (skipto '("(" "array" "record" "access" "private") 'type-decl3)))))
(define enum-decl
  (lambda ()
    (do-enum-decl
      (list
       (lambda () (mustbe "(" 'enum-decl))
       (lambda () (mustbe "Id" 'enum-decl))
       (lambda () (regex-handler '(* "," "Id") 'enum-decl))
       (lambda () (mustbe ")" 'enum-decl))
       (lambda () (mustbe ";" 'enum-decl))))))
(define array-decl
  (lambda ()
    (do-array-decl
      (list
       (lambda () (mustbe "array" 'array-decl))
       (lambda () (mustbe "(" 'array-decl))
       (lambda () (bound))
       (lambda () (regex-handler '(* "," bound) 'array-decl))
       (lambda () (mustbe ")" 'array-decl))
       (lambda () (mustbe "of" 'array-decl))
       (lambda () (mustbe "Id" 'array-decl))
       (lambda () (mustbe ";" 'array-decl))))))
(define bound
  (lambda ()
    (cond
     ((let ((FIRST
             '("+"
               "-"
               "Int"
               "Float"
               "true"
               "false"
               "Str"
               "Id"
               "("
               "not"
               "abs")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-bound
        (list
         (lambda () (expr))
         (lambda () (regex-handler '(? bound2) 'bound)))))
     ((equal? (peek-token) "range")
      (do-bound
        (list (lambda () (mustbe "range" 'bound)) (lambda () (range)))))
     (else
      (skipto
        '("+"
          "-"
          "Int"
          "Float"
          "true"
          "false"
          "Str"
          "Id"
          "("
          "not"
          "abs"
          "range")
        'bound)))))
(define bound2
  (lambda ()
    (cond
     ((equal? (peek-token) "range")
      (do-bound2
        (list (lambda () (mustbe "range" 'bound2)) (lambda () (bound3)))))
     ((equal? (peek-token) "..")
      (do-bound2 (list (lambda () (mustbe ".." 'bound2)) (lambda () (expr)))))
     (else (skipto '("range" "..") 'bound2)))))
(define bound3
  (lambda ()
    (cond
     ((equal? (peek-token) "<>")
      (do-bound3 (list (lambda () (mustbe "<>" 'bound3)))))
     ((let ((FIRST
             '("+"
               "-"
               "Int"
               "Float"
               "true"
               "false"
               "Str"
               "Id"
               "("
               "not"
               "abs")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-bound3 (list (lambda () (range)))))
     (else
      (skipto
        '("<>" "+" "-" "Int" "Float" "true" "false" "Str" "Id" "(" "not" "abs")
        'bound3)))))
(define range
  (lambda ()
    (do-range
      (list
       (lambda () (expr))
       (lambda () (mustbe ".." 'range))
       (lambda () (expr))))))
(define record-decl
  (lambda ()
    (do-record-decl
      (list
       (lambda () (mustbe "record" 'record-decl))
       (lambda () (component))
       (lambda () (mustbe "end" 'record-decl))
       (lambda () (mustbe "record" 'record-decl))
       (lambda () (mustbe ";" 'record-decl))))))
(define component
  (lambda ()
    (cond
     ((equal? (peek-token) "null")
      (do-component
        (list
         (lambda () (mustbe "null" 'component))
         (lambda () (mustbe ";" 'component)))))
     ((let ((FIRST '("Id")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-component
        (list
         (lambda () (var-decl))
         (lambda () (regex-handler '(* var-decl) 'component)))))
     (else (skipto '("null" "Id") 'component)))))
(define access-decl
  (lambda ()
    (do-access-decl
      (list
       (lambda () (mustbe "access" 'access-decl))
       (lambda () (mustbe "Id" 'access-decl))
       (lambda () (mustbe ";" 'access-decl))))))
(define fun-sig
  (lambda ()
    (do-fun-sig
      (list
       (lambda () (mustbe "function" 'fun-sig))
       (lambda () (fun-name))
       (lambda () (regex-handler '(? param-list) 'fun-sig))
       (lambda () (mustbe "return" 'fun-sig))
       (lambda () (mustbe "Id" 'fun-sig))))))
(define fun-name
  (lambda ()
    (cond
     ((equal? (peek-token) "Id")
      (do-fun-name (list (lambda () (mustbe "Id" 'fun-name)))))
     ((equal? (peek-token) "Str")
      (do-fun-name (list (lambda () (mustbe "Str" 'fun-name)))))
     (else (skipto '("Id" "Str") 'fun-name)))))
(define fun-decl
  (lambda ()
    (do-fun-decl
      (list (lambda () (fun-sig)) (lambda () (mustbe ";" 'fun-decl))))))
(define fun-body
  (lambda ()
    (do-fun-body
      (list
       (lambda () (fun-sig))
       (lambda ()
         (regex-handler
           '(?
             "is"
             (* decl)
             (? "begin" (* statement))
             (? "exception" (* except))
             "end"
             (? fun-name))
           'fun-body))
       (lambda () (mustbe ";" 'fun-body))))))
(define proc-sig
  (lambda ()
    (do-proc-sig
      (list
       (lambda () (mustbe "procedure" 'proc-sig))
       (lambda () (mustbe "Id" 'proc-sig))
       (lambda () (regex-handler '(? param-list) 'proc-sig))))))
(define proc-decl
  (lambda ()
    (do-proc-decl
      (list (lambda () (proc-sig)) (lambda () (mustbe ";" 'proc-decl))))))
(define proc-body
  (lambda ()
    (do-proc-body
      (list
       (lambda () (proc-sig))
       (lambda ()
         (regex-handler
           '(?
             "is"
             (* decl)
             (? "begin" (* statement))
             (? "exception" (* except))
             "end"
             (? "Id"))
           'proc-body))
       (lambda () (mustbe ";" 'proc-body))))))
(define param-list
  (lambda ()
    (do-param-list
      (list
       (lambda () (mustbe "(" 'param-list))
       (lambda () (param))
       (lambda () (regex-handler '(* ";" param) 'param-list))
       (lambda () (mustbe ")" 'param-list))))))
(define param
  (lambda ()
    (do-param
      (list
       (lambda () (mustbe "Id" 'param))
       (lambda () (regex-handler '(* "," "Id") 'param))
       (lambda () (mustbe ":" 'param))
       (lambda () (regex-handler '(? "in") 'param))
       (lambda () (regex-handler '(? "out") 'param))
       (lambda () (mustbe "Id" 'param))
       (lambda () (regex-handler '(? ":=" expr) 'param))))))
(define statement
  (lambda ()
    (cond
     ((equal? (peek-token) "null")
      (do-statement
        (list
         (lambda () (mustbe "null" 'statement))
         (lambda () (mustbe ";" 'statement)))))
     ((let ((FIRST '("declare" "begin")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-statement (list (lambda () (block)))))
     ((equal? (peek-token) "if")
      (do-statement
        (list
         (lambda () (mustbe "if" 'statement))
         (lambda () (expr))
         (lambda () (mustbe "then" 'statement))
         (lambda () (regex-handler '(* statement) 'statement))
         (lambda ()
           (regex-handler '(* "elsif" expr "then" (* statement)) 'statement))
         (lambda () (regex-handler '(? "else" (* statement)) 'statement))
         (lambda () (mustbe "end" 'statement))
         (lambda () (mustbe "if" 'statement))
         (lambda () (mustbe ";" 'statement)))))
     ((let ((FIRST '("loop")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-statement (list (lambda () (loop)))))
     ((let ((FIRST '("while")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-statement (list (lambda () (while)))))
     ((let ((FIRST '("for")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-statement (list (lambda () (for)))))
     ((equal? (peek-token) "exit")
      (do-statement
        (list
         (lambda () (mustbe "exit" 'statement))
         (lambda () (regex-handler '(? "Id") 'statement))
         (lambda () (regex-handler '(? "when" expr) 'statement))
         (lambda () (mustbe ";" 'statement)))))
     ((let ((FIRST '("case")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-statement (list (lambda () (cas)))))
     ((equal? (peek-token) "return")
      (do-statement
        (list
         (lambda () (mustbe "return" 'statement))
         (lambda () (regex-handler '(? expr) 'statement))
         (lambda () (mustbe ";" 'statement)))))
     ((equal? (peek-token) "raise")
      (do-statement
        (list
         (lambda () (mustbe "raise" 'statement))
         (lambda () (regex-handler '(? "Id") 'statement))
         (lambda () (mustbe ";" 'statement)))))
     ((equal? (peek-token) "Id")
      (do-statement
        (list (lambda () (mustbe "Id" 'statement)) (lambda () (id-rest)))))
     (else
      (skipto
        '("null"
          "declare"
          "begin"
          "if"
          "loop"
          "while"
          "for"
          "exit"
          "case"
          "return"
          "raise"
          "Id")
        'statement)))))
(define id-rest
  (lambda ()
    (cond
     ((equal? (peek-token) ";")
      (do-id-rest (list (lambda () (mustbe ";" 'id-rest)))))
     ((equal? (peek-token) ":")
      (do-id-rest
        (list (lambda () (mustbe ":" 'id-rest)) (lambda () (id-rest2)))))
     ((let ((FIRST '("(" "." ":=" ";")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-id-rest
        (list
         (lambda () (regex-handler '(? agg-list) 'id-rest))
         (lambda () (regex-handler '(* subname) 'id-rest))
         (lambda () (regex-handler '(? ":=" expr) 'id-rest))
         (lambda () (mustbe ";" 'id-rest)))))
     (else (skipto '(";" ":" "(" "." ":=" ";") 'id-rest)))))
(define subname
  (lambda ()
    (do-subname
      (list (lambda () (mustbe "." 'subname)) (lambda () (name-rest))))))
(define cas
  (lambda ()
    (do-cas
      (list
       (lambda () (mustbe "case" 'cas))
       (lambda () (expr))
       (lambda () (mustbe "is" 'cas))
       (lambda () (regex-handler '(* "when" when-list) 'cas))
       (lambda () (mustbe "end" 'cas))
       (lambda () (mustbe "case" 'cas))
       (lambda () (mustbe ";" 'cas))))))
(define id-rest2
  (lambda ()
    (cond
     ((let ((FIRST '("declare" "begin")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-id-rest2 (list (lambda () (block)))))
     ((let ((FIRST '("loop")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-id-rest2 (list (lambda () (loop)))))
     ((let ((FIRST '("while")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-id-rest2 (list (lambda () (while)))))
     ((let ((FIRST '("for")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-id-rest2 (list (lambda () (for)))))
     (else (skipto '("declare" "begin" "loop" "while" "for") 'id-rest2)))))
(define block
  (lambda ()
    (do-block
      (list
       (lambda () (regex-handler '(? "declare" (* decl)) 'block))
       (lambda () (mustbe "begin" 'block))
       (lambda () (regex-handler '(* statement) 'block))
       (lambda () (regex-handler '(? "exception" except) 'block))
       (lambda () (mustbe "end" 'block))
       (lambda () (regex-handler '(? "Id") 'block))
       (lambda () (mustbe ";" 'block))))))
(define loop
  (lambda ()
    (do-loop
      (list
       (lambda () (mustbe "loop" 'loop))
       (lambda () (regex-handler '(* statement) 'loop))
       (lambda () (mustbe "end" 'loop))
       (lambda () (mustbe "loop" 'loop))
       (lambda () (regex-handler '(? "Id") 'loop))
       (lambda () (mustbe ";" 'loop))))))
(define while
  (lambda ()
    (do-while
      (list
       (lambda () (mustbe "while" 'while))
       (lambda () (expr))
       (lambda () (loop))))))
(define for
  (lambda ()
    (do-for
      (list
       (lambda () (mustbe "for" 'for))
       (lambda () (mustbe "Id" 'for))
       (lambda () (mustbe "in" 'for))
       (lambda () (regex-handler '(? "reverse") 'for))
       (lambda () (range))
       (lambda () (loop))))))
(define when-list
  (lambda ()
    (cond
     ((let ((FIRST
             '("+"
               "-"
               "Int"
               "Float"
               "true"
               "false"
               "Str"
               "Id"
               "("
               "not"
               "abs")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-when-list
        (list
         (lambda () (expr))
         (lambda () (regex-handler '(? ".." expr) 'when-list))
         (lambda () (regex-handler '(* "|" expr (? ".." expr)) 'when-list))
         (lambda () (mustbe "=>" 'when-list))
         (lambda () (regex-handler '(* statement) 'when-list)))))
     ((equal? (peek-token) "others")
      (do-when-list
        (list
         (lambda () (mustbe "others" 'when-list))
         (lambda () (mustbe "=>" 'when-list))
         (lambda () (regex-handler '(* statement) 'when-list)))))
     (else
      (skipto
        '("+"
          "-"
          "Int"
          "Float"
          "true"
          "false"
          "Str"
          "Id"
          "("
          "not"
          "abs"
          "others")
        'when-list)))))
(define expr
  (lambda ()
    (do-expr
      (list
       (lambda () (expr2))
       (lambda () (regex-handler '(* orelse expr2) 'expr))))))
(define orelse
  (lambda ()
    (do-orelse
      (list
       (lambda () (mustbe "or" 'orelse))
       (lambda () (regex-handler '(? "else") 'orelse))))))
(define expr2
  (lambda ()
    (do-expr2
      (list
       (lambda () (relation))
       (lambda () (regex-handler '(* andthen relation) 'expr2))))))
(define andthen
  (lambda ()
    (do-andthen
      (list
       (lambda () (mustbe "and" 'andthen))
       (lambda () (regex-handler '(? "then") 'andthen))))))
(define relation
  (lambda ()
    (do-relation
      (list
       (lambda () (simp_expr))
       (lambda () (regex-handler '(? relat_op simp_expr) 'relation))))))
(define relat_op
  (lambda ()
    (cond
     ((equal? (peek-token) "=")
      (do-relat_op (list (lambda () (mustbe "=" 'relat_op)))))
     ((equal? (peek-token) "/=")
      (do-relat_op (list (lambda () (mustbe "/=" 'relat_op)))))
     ((equal? (peek-token) "<")
      (do-relat_op (list (lambda () (mustbe "<" 'relat_op)))))
     ((equal? (peek-token) "<=")
      (do-relat_op (list (lambda () (mustbe "<=" 'relat_op)))))
     ((equal? (peek-token) ">")
      (do-relat_op (list (lambda () (mustbe ">" 'relat_op)))))
     ((equal? (peek-token) ">=")
      (do-relat_op (list (lambda () (mustbe ">=" 'relat_op)))))
     (else (skipto '("=" "/=" "<" "<=" ">" ">=") 'relat_op)))))
(define simp_expr
  (lambda ()
    (do-simp_expr
      (list
       (lambda () (regex-handler '(? unary_op) 'simp_expr))
       (lambda () (term))
       (lambda () (regex-handler '(* adding_op term) 'simp_expr))))))
(define unary_op
  (lambda ()
    (cond
     ((equal? (peek-token) "+")
      (do-unary_op (list (lambda () (mustbe "+" 'unary_op)))))
     ((equal? (peek-token) "-")
      (do-unary_op (list (lambda () (mustbe "-" 'unary_op)))))
     (else (skipto '("+" "-") 'unary_op)))))
(define adding_op
  (lambda ()
    (cond
     ((let ((FIRST '("+" "-")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-adding_op (list (lambda () (unary_op)))))
     ((equal? (peek-token) "&")
      (do-adding_op (list (lambda () (mustbe "&" 'adding_op)))))
     (else (skipto '("+" "-" "&") 'adding_op)))))
(define term
  (lambda ()
    (do-term
      (list
       (lambda () (factor))
       (lambda () (regex-handler '(* mult_op factor) 'term))))))
(define mult_op
  (lambda ()
    (cond
     ((equal? (peek-token) "*")
      (do-mult_op (list (lambda () (mustbe "*" 'mult_op)))))
     ((equal? (peek-token) "/")
      (do-mult_op (list (lambda () (mustbe "/" 'mult_op)))))
     ((equal? (peek-token) "mod")
      (do-mult_op (list (lambda () (mustbe "mod" 'mult_op)))))
     (else (skipto '("*" "/" "mod") 'mult_op)))))
(define factor
  (lambda ()
    (cond
     ((let ((FIRST '("Int" "Float" "true" "false" "Str" "Id" "(")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-factor
        (list
         (lambda () (primary))
         (lambda () (regex-handler '(? "**" primary) 'factor)))))
     ((equal? (peek-token) "not")
      (do-factor
        (list (lambda () (mustbe "not" 'factor)) (lambda () (primary)))))
     ((equal? (peek-token) "abs")
      (do-factor
        (list (lambda () (mustbe "abs" 'factor)) (lambda () (primary)))))
     (else
      (skipto
        '("Int" "Float" "true" "false" "Str" "Id" "(" "not" "abs")
        'factor)))))
(define primary
  (lambda ()
    (cond
     ((let ((FIRST '("Int" "Float" "true" "false" "Str")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-primary (list (lambda () (literal)))))
     ((equal? (peek-token) "Id")
      (do-primary
        (list
         (lambda () (mustbe "Id" 'primary))
         (lambda () (regex-handler '(* name-part) 'primary)))))
     ((equal? (peek-token) "(")
      (do-primary
        (list
         (lambda () (mustbe "(" 'primary))
         (lambda () (expr))
         (lambda () (mustbe ")" 'primary)))))
     (else (skipto '("Int" "Float" "true" "false" "Str" "Id" "(") 'primary)))))
(define literal
  (lambda ()
    (cond
     ((equal? (peek-token) "Int")
      (do-literal (list (lambda () (mustbe "Int" 'literal)))))
     ((equal? (peek-token) "Float")
      (do-literal (list (lambda () (mustbe "Float" 'literal)))))
     ((equal? (peek-token) "true")
      (do-literal (list (lambda () (mustbe "true" 'literal)))))
     ((equal? (peek-token) "false")
      (do-literal (list (lambda () (mustbe "false" 'literal)))))
     ((equal? (peek-token) "Str")
      (do-literal (list (lambda () (mustbe "Str" 'literal)))))
     (else (skipto '("Int" "Float" "true" "false" "Str") 'literal)))))
(define name-part
  (lambda ()
    (cond
     ((let ((FIRST '("(")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-name-part (list (lambda () (agg-list)))))
     ((equal? (peek-token) ".")
      (do-name-part
        (list (lambda () (mustbe "." 'name-part)) (lambda () (name-rest)))))
     ((equal? (peek-token) "'")
      (do-name-part
        (list (lambda () (mustbe "'" 'name-part)) (lambda () (agg)))))
     (else (skipto '("(" "." "'") 'name-part)))))
(define agg
  (lambda ()
    (cond
     ((let ((FIRST '("(")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-agg (list (lambda () (agg-list)))))
     ((equal? (peek-token) "Id")
      (do-agg (list (lambda () (mustbe "Id" 'agg)))))
     (else (skipto '("(" "Id") 'agg)))))
(define agg-list
  (lambda ()
    (do-agg-list
      (list
       (lambda () (mustbe "(" 'agg-list))
       (lambda () (name-list))
       (lambda () (regex-handler '(? "=>" expr) 'agg-list))
       (lambda () (regex-handler '(* "," name-list (? "=>" expr)) 'agg-list))
       (lambda () (mustbe ")" 'agg-list))))))
(define name-list
  (lambda ()
    (cond
     ((let ((FIRST
             '("+"
               "-"
               "Int"
               "Float"
               "true"
               "false"
               "Str"
               "Id"
               "("
               "not"
               "abs")))
        (or (in-list? (peek-token) FIRST) (has-epsilon? FIRST)))
      (do-name-list
        (list
         (lambda () (expr))
         (lambda () (regex-handler '(? ".." expr) 'name-list))
         (lambda () (regex-handler '(* "|" expr (? ".." expr)) 'name-list)))))
     ((equal? (peek-token) "others")
      (do-name-list (list (lambda () (mustbe "others" 'name-list)))))
     (else
      (skipto
        '("+"
          "-"
          "Int"
          "Float"
          "true"
          "false"
          "Str"
          "Id"
          "("
          "not"
          "abs"
          "others")
        'name-list)))))
(define name-rest
  (lambda ()
    (cond
     ((equal? (peek-token) "Id")
      (do-name-rest (list (lambda () (mustbe "Id" 'name-rest)))))
     ((equal? (peek-token) "Str")
      (do-name-rest (list (lambda () (mustbe "Str" 'name-rest)))))
     ((equal? (peek-token) "all")
      (do-name-rest (list (lambda () (mustbe "all" 'name-rest)))))
     (else (skipto '("Id" "Str" "all") 'name-rest)))))
