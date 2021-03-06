(define cfg
  '((start          (package (* package) "eof"))
;  (unit            ((* pragmas) package))
;  (pragmas         ("pragma" "Id" (* "," "Id") ";"))

    (package        ((? "generic" (* head)) "package" package-rest))
    (package-rest   (package-decl)
                    (package-body))
    (package-decl   ("Id" "is" (* head) (? "private" (* type-decl)) (? "body" (* decl)) (? "begin" (* statement)) (? "exception" (* except)) "end" (? "Id") ";"))
    (package-body   ("body" "Id" "is" (* decl) (? "begin" (* statement)) (? "exception" (* except)) "end" (? "Id") ";"))

    (head           (type-decl)
                    (use)
                    (fun-decl)
                    (proc-decl)
;                   (pragmas)
                    (var-decl))
    (decl           (fun-body)
                    (proc-body)
                    (use)
;                   (pragmas)
                    (type-decl)
                    (var-decl))

    (except         ("when" except-tail))
    (except-tail    ("others" "=>" (* statement))
                    ("Id" (* "|" "Id") "=>" (* statement)))

    (use            ("use" "Id" (* "," "Id") ";"))

    (var-decl       ("Id" (* "," "Id") ":" (? "constant") var-type (? ":=" expr) ";"))
    (var-type       ("Id" (? var-type2))
                    ("exception"))
    (var-type2      ("range" range)
                    ("(" range ")"))

    (type-decl      ("type" "Id" type-decl2)
                    ("subtype" "Id" "is" var-type ";"))
    (type-decl2     (";")
                    ("is" type-decl3))
    (type-decl3     (enum-decl)
                    (array-decl)
                    (record-decl)
                    (access-decl)
                    ("private" ";"))

    (enum-decl      ("(" "Id" (* "," "Id") ")" ";"))
    (array-decl     ("array" "(" bound (* "," bound) ")" "of" "Id" ";"))
    (bound          (expr (? bound2))
                    ("range" range))
    (bound2         ("range" bound3)
                    (".." expr))
    (bound3         ("<>")
                    (range))

    (range          (expr ".." expr))

    (record-decl    ("record" component "end" "record" ";"))
    (component      ("null" ";")
                    (var-decl (* var-decl)))

    (access-decl    ("access" "Id" ";"))

    (fun-sig        ("function" fun-name (? param-list) "return" "Id"))
    (fun-name       ("Id") ("Str"))
    (fun-decl       (fun-sig ";"))
    (fun-body       (fun-sig (? "is" (* decl) (? "begin" (* statement)) (? "exception" (* except)) "end" (? fun-name)) ";"))

    (proc-sig       ("procedure" "Id" (? param-list)))
    (proc-decl      (proc-sig ";"))
    (proc-body      (proc-sig (? "is" (* decl) (? "begin" (* statement)) (? "exception" (* except)) "end" (? "Id")) ";"))

    (param-list     ("(" param (* ";" param) ")"))
    (param          ("Id" (* "," "Id") ":" (? "in") (? "out") "Id" (? ":=" expr)))


    (statement      ("null" ";")
                    (block)
                    ("if" expr "then" (* statement) (* "elsif" expr "then" (* statement)) (? "else" (* statement)) "end" "if" ";")
                    (loop)
                    (while)
                    (for)
                    ("exit" (? "Id") (? "when" expr) ";")
                    (cas)
                    ("return" (? expr) ";")
                    ("raise" (? "Id") ";")
                    ("Id" id-rest))

	(id-rest		(";")							; proc
					(":" id-rest2)					; label
					((? agg-list) (* subname) (? ":=" expr) ";")); proc{ foo(x=>4, 66 9) }, assignment (scalar { x } , array { A(1,2) } , record { R.Q.all } )

	(subname		("." name-rest)
					)

	(cas			("case" expr "is" (* "when" when-list) "end" "case" ";"))
    (id-rest2       (block)
                    (loop)
                    (while)
                    (for))
    (block          ((? "declare" (* decl)) "begin" (* statement) (? "exception" except) "end" (? "Id") ";"))

    (loop           ("loop" (* statement) "end" "loop" (? "Id") ";"))
    (while          ("while" expr loop))
    (for            ("for" "Id" "in" (? "reverse") range loop))

    (when-list      (expr (? ".." expr) (* "|" expr (? ".." expr)) "=>" (* statement))
                    ("others" "=>" (* statement)))


    (expr           (expr2 (* orelse expr2)))
    (orelse         ("or" (? "else")))
    (expr2          (relation (* andthen relation)))
    (andthen        ("and" (? "then")))
    (relation       (simp_expr (? relat_op simp_expr)))
    (relat_op       ("=")
                    ("/=")
                    ("<")
                    ("<=")
                    (">")
                    (">="))
    (simp_expr      ((? unary_op) term (* adding_op term)))
    (unary_op       ("+")
                    ("-"))
    (adding_op      (unary_op)
                    ("&"))
    (term           (factor (* mult_op factor)))
    (mult_op        ("*")
                    ("/")
                    ("mod"))
    (factor         (primary (? "**" primary))
                    ("not" primary)
                    ("abs" primary))
    (primary        (literal)
                    ("Id" (* name-part))
                    ("(" expr ")"))
    (literal        ("Int")
                    ("Float")
                    ("true")
                    ("false")
                    ("Str"))
    (name-part      (agg-list)
                    ("." name-rest)
                    ("'" agg))
    (agg            (agg-list)
                    ("Id"))
    (agg-list       ("(" name-list (? "=>" expr) (* "," name-list (? "=>" expr)) ")"))

    (name-list      (expr (? ".." expr) (* "|" expr (? ".." expr)))
                    ("others"))
    (name-rest      ("Id")
                    ("Str")
                    ("all"))
    ))
