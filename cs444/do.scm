(require (lib "match.ss"))
(require (lib "trace.ss"))
(require (lib "pretty.ss"))
(load "types.scm")
(load "macro.scm")


(define 1- (lambda (n) (- n 1)))
(define myapply (lambda (x) (apply x ())))

(define pkg-name #f)
(define do-record? #f)
(define rangeT #f)
(define infun? #f)

(define find-ref
  (lambda (lst)
	(- (length lst) (length (member #t (map (match-lambda (#f #f) (_ #t)) lst))))))

(define ty-error-expr
  (lambda s
	(eval `(ty-error ,line ,column '(error alpha) ,@s))))

(define ty-error-stmt
  (lambda s
	(eval `(ty-error ,line ,column '(void) ,@s))))

(define except-list '("numeric_error" "constraint_error"))
(define default-except '(("numeric_error" "ZeroDivisionError") ("constraint_error" "TypeError")))
(define uses '())
(define classs '())
(define prev-class #f)

(define main-defined #f)

(define freeInt 0)
(define getFreeInt
  (lambda (b)
	(set! freeInt (+ 1 freeInt))
	(if (and b (not (member freeInt except-list)))
	  (set! except-list (cons freeInt except-list)))
	freeInt))

(define resolve-enum
  (lambda (expr type)
	(match expr
		   (('VAR x) (if (assoc x type)
					   (list (cadr (assoc x type)) 0)
					   (list 'VAR x)))
		   (x x))))

(define Union
  (lambda (e1 e2)
	(without #f (map (lambda (s) (member s (cdr e2))) (cdr e1)))))

(define matcht (make-hash-table 'equal))

(define mama
  (lambda (params defn)
	(let ((ret 
			(cond
			  ((equal? 'void defn) (or (equal? 'void params) (equal? 'alpha params)))
			  ((or (equal? 'alpha defn) (equal? 'alpha params)) #t)
			  ((list? defn) (begin
							  (call/cc 
								(lambda (k)
								  (for-each
									(lambda (x)
									  (match x
											 ((x M T e) (hash-table-put! matcht x (list #f T e)))
											 (_ (k #f))))
									defn)))
							  (let ((ret (m2 params defn)))
								(if (not ret) ;; no match
								  #f
								  (let ((blah (map
												(lambda (x) 
												  (list (car x)
														(cadr x)
														(caddr x)
														(list (car (hash-table-get matcht (car x) #f))
															  (cadr (hash-table-get matcht (car x) #f)))))
												defn)))
									(let ((retval (set-defaults blah defn)))
										(if (checkcheck retval)
									  		retval
									  		#f)))))))
			  (else #f))))
	  (begin
		(set! matcht (make-hash-table 'equal))
		ret))))

(define set-defaults
  (lambda (params defn)
	(if (null? params)
	  '()
	  (begin
	  (cons (match (car params)
				((pname pinout pT (#f pTT)) (list pname pinout pT (list (match (car defn) ((_ _ _ (v _)) v)) pTT)))
			 	(x x))
			(set-defaults (cdr params) (cdr defn)))))))
	  

;; ( ("x" 5 'int #f) ("y" 10 'int #f) ...)
(define checkcheck
  (lambda (L)
	(not (in-list? #f (map (lambda (x) (car (cadddr x))) L)))))


(define m2
  (lambda (params defn)
	(if (null? params)
	  #t
	  (if (list? params)
		(match (car params)
			   ((x as (v T)) (let ((ret (hash-table-get matcht x #f)))
							   (if ret
								 (if (not (car ret)) ;; not defined yet
								   (if (equal? T (lookup 'TYPE (cadr ret)))
									 (begin
									   (hash-table-put! matcht x (list v T (caddr ret)))
									   (m2 (cdr params) (if (list? defn)
														  (match (car defn)
																 ((a val typ exp) (let ((blah (hash-table-get matcht a #f)))
																					(if (car blah) ;; already defined
																					  (cdr defn)
																					  defn)))
																 (_ #f))
														  #f)))
									 #f)
								   #f)
								 #f)))
			   ((v T) (if (not (null? defn))
						(match (car defn)
							   ((x M TT e) (let ((ret (hash-table-get matcht x #f)))
											 (if ret
											   (if (not (car ret)) ;; not defined yet
												 (if (equal? T (lookup 'TYPE TT))
												   (begin
													 (hash-table-put! matcht x (list v T e))
													 (m2 (cdr params) (cdr defn)))
												   #f)
												 #f)
											   #f)))
							   (_ #f))
						#f))
			   (_ #f))
		(equal? 'void defn)))))

; ((x 'as (v T)) (v T) ... )
; ((x MODE T #f) (y MODE T e)...)
;       :
; ((x v) (y v)...)
(define Match
  (lambda (params defn)
	(cond
	  ((and (eq? 'void params) (eq 'void params)) '())
	  ((eq? 'void params) #f)
	  ((eq? 'void params) #f)
	  (else
		(call/cc
		  (lambda (koo)
			(let aloop ((top params)
						(bot defn)
						(vis '()))
			  (cond
				((and (null? top) (null? bot) (null? vis)) '())
				((and (null? top) (null? bot)) (koo #f))
				((and (null? top) (null? vis)) (koo #f))
				((null? bot) (koo #f))
				((null? top)
				 (cond
				   ((assoc (caar bot) vis)
					(cons (assoc (car bot) vis)
						  (aloop top trest
								 (car brest) (cdr brest)
								 (without (assoc (car bot) vis)
										  vis))))
				   ((list-ref (car bot) 3)
					(cons (list (list-ref bot 3) (list-ref bot 2))
						  (aloop top trest
								 (car brest) (cdr brest)
								 vis)))
				   (else (koo #f))))
				(else
				  ((match (list (car top) (car bot))
						  (((v T) (x mode U w))
						   (cond
							 ((equal? T U)
							  (cons (list x mode U v)
									(aloop (cdr top) (cdr bot) vis)))
							 ((assoc x vis)
							  (koo #f))))
						  (((x 'as (v T)) (y mode U w))
						   (if (and (equal? x y) (equal? T U))
							 (cons (list y mode U v)
								   (aloop (cdr top (cdr bot) vis)))
							 (aloop (cdr top) bot (cons (list x 'as (v T)) vis))))
						  (_ (koo #f)))))

				))))))))


(define do-scope '())

;------------

(define do-start
  (match-lambda
	((p ps eof)
	 (let* ((p (p))
			(ps (ps))
			(eof (eof)))
	   (cons p ps)))))

(define do-package
  (match-lambda
	((gen pkg p-rest)
	 (let* ((gen (gen)) (pkg (pkg)) (p-rest (p-rest)))
	   (unless (null? gen)
		 (begin
		   (ty-error line column p-rest "Generics aren't supported")
		   (exit))
		 p-rest)))))

(define do-package-rest
  (lambda (pkg) (car (map myapply pkg))))

(define do-package-decl
  (match-lambda
	((i is head private body beginn except end j semi)
	 (set! do-scope '(PacDecl))
	 (let* ((i (match (i) (("Id" l id) id) (_ 'error)))
			(line line)
			(column (- column (caddr next-token)))
			(t0 (if *scope* (mdisplay "- Package name is: " i)))
			(t1 (set! pkg-name i))
			(t2 (create-scope!))
			(is (is))
			(head (apply append (head)))
			(private (private))
			(t3 (set! do-scope '(PacBody)))
			(body (body))
			(beginn (beginn))
			(except (except))
			(end (end))
			(j (match (j) ((("Id" l id)) id) (() i) (_ 'error)))
			(semi (semi))
			(pkg (if (not (and (null? body) (null? beginn) (null? except)))
				   'PKG 'PKG-DECL))
			(t4 (if (equal? pkg-name "main")
				  (if main-defined
					(ty-error-stmt "Main package has already been defined"))
				  (if (member pkg-name classs)
					(ty-error-stmt "Package `" pkg-name "' has already been defined"))))
			)
	   (set! do-scope '())
	   (if (and (equal? pkg-name "main") (eq? pkg 'PKG)) (set! main-defined #t))
	   (if prev-class (ty-error-stmt "A package declaration must be followed by its body"))
	   (if (eq? pkg 'PKG-DECL) (set! prev-class pkg-name) (set! prev-class #f))
	   (set! classs (cons pkg-name classs))
	   (cond
		 ((or (symbol? i) (symbol? j)) '(error))
		 ((not (equal? i j))
		  (ty-error line column '(error)
					"Package name declaration and closure are not the same"))
		 (else
		   (list pkg
				 i
				 (list 'USE (let ((u uses)) (set! uses '()) u))
				 (list 'HEAD (without 'void head))
				 (list 'PRIVATE (match private
						((("private") private) (apply append (apply append private)))
						(_ '())))
				 (list 'BODY (match body
						((("body") body) (without 'void (apply append (apply append body))))
						(_ '())))
				 (list 'BEGIN (match beginn
									  ((("begin") beginn) (apply append beginn))
									  (_ '())))
				 (list 'EXCEPT (match except
									  ((("exception") except) (apply append except))
									  (_ '())))
				 )))))
	(_ 'void)))

(define do-package-body
  (lambda (lst)
	(match (cons ((car lst)) (cons ((cadr lst)) (cddr lst)))
		   ((("body")("Id" l i) is ds beginn except end j semi)
			(let* ((line line)
				   (column (- column (caddr next-token)))
				   (is (is))
				   (t0 (set! pkg-name i))
				   (t1 (if *scope* (mdisplay "- Package body is: " i)))
				   (t2 (set! do-scope '(PacBody)))
				   (t3 (if (not (member pkg-name classs))
						 (ty-error-stmt "Package `" pkg-name "' must be first defined")))
				   (ds (ds))
				   (beginn (beginn))
				   (except (except))
				   (end (end))
				   (j (match (j) ((("Id" l id)) id) (() i) (_ 'error)))
				   (semi (semi)))
			  (if (equal? pkg-name "main") (set! main-defined #t))
			  (if (not (equal? pkg-name prev-class)) (ty-error-stmt "Package body must follow head of the same package"))
			  (set! prev-class #f)
			  (set! do-scope '())
			  (set! classs (cons pkg-name classs))
			  (cond
				((or (symbol? i) (symbol? j)) '(error))
				((not (equal? i j))
				 (ty-error line column '(error)
						   "Package name declaration and closure are not the same"))
				(else
				  (list 'PKG-BODY
						i
						(list 'USE (let ((u uses)) (set! uses '()) u))
						(list 'DEF (apply append (apply append ds)))
						(list 'BEGIN (match beginn
											((("begin") beginn) (apply append beginn))
											(_ '())))
						(list 'EXCEPT (match except
											 ((("exception") except) (apply append except))
											 (_ '())))
						)))))
		   (_ 'void)
		   )))

(define do-head
  (lambda (lst)
	((car lst))))

(define do-decl (lambda (lst) (map myapply lst)))

(define do-except
  (lambda (lst)
	(match (map myapply lst)
		   ((("when") rest)
			rest)
		   (_ '(void)))))

(define do-except-tail
  (lambda (lst)
	(match (map myapply lst)
		   ((("others") ("=>") stmt)
			(list (list 'EELSE (apply append stmt))))
		   ((id ids ("=>") stmt)
			(map (match-lambda
				   (("Id" lin id)
				   (if (or (lookup 'EXCEPT id) (assoc id default-except))
					 (list 'EIF id (apply append stmt))
					 (ty-error line column '(void) "Unknown exception handled: " id)))
				   (_ '(void)))
				 (cons id (let aloop ((lst ids))
							(if (null? lst) '()
							  (cons (cadr lst) (aloop (cddr lst))))))))
		   (_ '(void)))))

(define do-use
  (lambda (lst)
	(match (map myapply lst)
		   ((("use") ("Id" lin id) ids (";"))
			(if (equal? id pkg-name)
			  (ty-error line column '(void) "Can't USE same package")
			  (unless (member id classs)
				(ty-error line column '(void) "Unknown class: " id)
				(begin
				  (set! uses (cons id uses))
				  (let aloop ((lst ids))
					(if (or (null? lst) (< (length lst) 2))
					  '(void)
					  (match (cadr lst)
							 (("Id" lin id)
							  (if (equal? id pkg-name)
								(ty-error line column '(void) "Can't USE same package")
								(unless (member id classs)
								  (ty-error line column '(void) "Unknown class: " id)
								  (if (member id uses)
									(ty-error line column '(void) "Class is already being used: " id)
									(begin
									  (set! uses (cons id uses))
									  (aloop (cddr lst)))))))
							 (_ '(void)))))))))
		   (_ '(void)))))

(define do-var-decl
  (match-lambda
	((id ids col constant T assign semi)
	 (let* ((id (caddr (id)))
			(ids (call/cc
				   (lambda (k)
					 (let aloop ((ids (ids)))
					   (cond
						 ((null? ids) '())
						 (else (match (car ids)
									  ((",") (aloop (cdr ids)))
									  (("Id" l id) (cons id (aloop (cdr ids))))
									  (else (k '())))))))))
			(ids (cons id ids))
			(col (col))
			(line line)
			(column (1- column))
			(constant (match (constant) ((("contant")) #t) (_ #f)))
			(T (T))
			(assign (assign))
			(e (if (or (null? assign) (eq? 'alpha (type-of assign)) (eq? T 'except)) #f (cadr assign)))
			(e (if e (let aloop ((TT (lookup 'TYPE T))
								 (t (type-of e))
								 (ret (val-of e))
								 (vis '()))
					   (let ((tt (lookup 'TYPE t)))
						 (if (or (equal? T t) (not (access? tt)))
						   (list ret t)
						   (if (member (cadr tt) vis)
							 (ty-error line column #f
									   "Circular accessor types")
							 (aloop TT (cadr tt) (list 'DEREF ret) (cons (cadr tt) vis))))))
				 #f))
			(semi (semi)))
	   (if (eq? T 'except)
		 (if (or constant e)
		   (ty-error line column '(void) "Invalid exception declaration")
		   (begin (map (lambda (id)
						 (insert-info! 'EXCEPT id 'exception)
						 (if (not (member id except-list))
						   (set! except-list (cons id except-list))))
					   ids)
				  '(void)))
		 (cond
		   ((and (list? T) (alpha? (type-of T))) '(void))
		   ((and e (enum? (type-of e)) (list? (type-of e)) (> (length (type-of e)) 2) (not (member T (cdr (type-of e)))))
			(ty-error line column 'void "Ambiguous enumerator type"))
		   ((and e (enum? (type-of e)) (list? (type-of e)) (member T (cdr (type-of e))))
			(map (lambda (id)
				   (if (insert-info! 'VAR id T)
					 (if (and e (not (alpha? (type-of e))))
					   (if (lookup 'TYPE T)
						 ;	(list 'STORE id (list (cadr (assoc (cadr (val-of e)) (cadr (lookup 'TYPE T)))) 0))
						 (list 'INIT id (if (enum? T)
										  (resolve-enum (val-of e) (cadr (lookup 'TYPE T)))
										  (val-of e)))
						 'void)
					   'void)
					 'void))
				 ids))
		   ((and e (eq? 'typ (type-of e)))
			(ty-error line column '(void) "Expression contains type name, needed variable name"))
		   ((and e (not (U T (type-of e))))
			(ty-error line column (if do-record? (list (list id 'alpha)) '(void))
					  "Incompatible types in assignment of `" (printt (type-of e)) "' to `" (printt T) "'"))
		   (else (if do-record?
				   (map (lambda (id)
						  (list id T e))
						ids)
				   (apply append (map (lambda (id)
										(begin (if (insert-info! 'VAR id T)
												 (if (and e (not (alpha? (type-of e))))
												   (list (list 'INIT id (val-of e)))
												   (list (list 'INIT id (default-value (lookup 'TYPE T)))))
												 '(void))))
									  ids))))))))
	(_ 'VAROR)))

(define default-value
  (match-lambda
	(('record rest) (list 'Record (map (match-lambda ((name type id) (list name (if id (val-of id) (default-value (lookup 'TYPE type))))) (_ 'void)) rest)))
	(('access T) (list 'Access))
	(_ '(0 0))))


(define do-var-type
  (match-lambda
	((T Ts) (let* ((T (T))(Ts (Ts)))
			  (match (list T Ts)
					 ((("Id" l T) ())
					  (let ((t (lookup 'TYPE T)))
						(cond
						  ((void? t)
						   (ty-error line column 'alpha
									 "Missing full type declaration for `" T "' before use"))
						  ((or (int? t) (bool? t) (astring? t) (float? t)) t)
						  (t (if (and (array? t)
									  (match (cadr t)
											 ((('UNCONST i)) #t)
											 (_ #f)
											 ))
							   (ty-error
								 line column 'alpha
								 "Unconstrained array needs its dimensions specified")
							   T))
						  (else
							(ty-error line column 'alpha
									  "Uninitialized type `" T "'")))))
					 (_ 'VERR))))
	((except) (let* ((except (except)))
				'except))))

(define do-var-type2 (lambda (lst) (map myapply lst))) ;!!!!!!!!!!!!!!!!!!!!!!!!!!

(define do-type-decl
  (match-lambda
	((type id rest)
	 (let* ((type (type))
			(id (id))
			(rest (rest)))
	   (match id
			  (("Id" l id)
			   (if (and (list? rest) (alpha? (type-of rest)))
				 '(void)
				 (begin (insert-info! 'TYPE id rest)
						'(void))))
			  (_ '(void)))))
	((sub id is T semi)
	 (let* ((sub (sub))
			(id (id))
			(is (is))
			(T (T))
			(semi (semi)))
	   (match id
			  (("Id" l id)
			   (if (and (list? T) (alpha? (type-of T)))
				 'void
				 (begin (insert-info! 'TYPE id T)
						'(void))))
			  (_ '(void)))))
	(_ 'TERRO)))

(define do-type-decl2
  (match-lambda
	((semi) (let* ((semi (semi)))
			  'void))
	((is rest) (let* ((is (is))
					  (rest (rest)))
				 rest))
	(_ 'T2ERRO)))

(define do-type-decl3
  (match-lambda
	((decl) (decl))
	((private semi) (let* ((private (private))
						   (semi (semi)))
					  'void))
	(_ 'T3ERRO)))

(define do-enum-decl
  (match-lambda
	((open id ids close semi)
	 (let* ((open (open))
			(id (id))
			(ids (ids))
			(close (close))
			(semi (semi)))
	   (match id
			  (("Id" l id)
			   (list 'enum (cons (list id 0)
								 (let aloop ((ids ids) (num 1))
								   (cond
									 ((null? ids) '())
									 (else (match (car ids)
												  (("Id" l id) (cons (list id num)
																	 (aloop (cdr ids) (+ num 1))))
												  ((",") (aloop (cdr ids) num))
												  (_ '()))))))))
			  (_ 'alpha))))
	(_ 'ENUMERR)))

(define do-array-decl
  (lambda (lst)
	(match (map myapply lst)
		   ((array open bound bound2 close of ("Id" l type) semi)
			(unless (lookup 'TYPE type)
			  (ty-error-expr "Undefined type `" type "'")
			  (list 'array
					(cons bound
						  (let aloop ((c1 (match bound (('UNCONST i) #t) (_ #f)))
									  (lst bound2))
							(cond
							  ((null? lst) '())
							  ((eq? 'alpha (car lst)) (aloop c1 (cdr lst)))
							  (else (let* ((comma (car lst))
										   (bound (cadr lst))
										   (c2 (match bound (('UNCONST i) #t) (_ #f))))
									  (if (eq? c1 c2)
										(cons bound (aloop c2 (cddr lst)))
										(ty-error line column '()
												  "Mixing unconstrained and constrained array definitions")))))))
					type)))
		   (_ '(void)))))

(define do-bound
  (match-lambda
	((a b)
	 (match (list (a) b)
			((("range") range) (range))
			(((id 'typ) r)
			 (set! rangeT id)
			 (let ((r (r)))
			   (if (match r ((('expr e)) #t) (_ #f))
				 (ty-error line column 'alpha "Invalid range: type..expression")
				 (let* ((T (lookup 'TYPE id)))
				   (cond
					 ((not (or (enum? T) (int? T) (bool? T)))
					  (ty-error line column 'alpha
								"Array indices must all be of enumeratable type, given `" id "'"))
					 (else
					   (match r
							  (('unconst) (list 'UNCONST id))
							  ((('RANGE a b t)) (list 'RANGE a b t))
							  (() (cond
									((int? T) (list 'RANGE '(FIRST int) '(LAST int) 'int))
									((bool? T) (list 'RANGE '(0 0) '(1 1) 'bool))
									(else (list 'RANGE '(0 0) (list (1- (length (cadr T))) 0) id))))
							  (_ 'alpha))))))))
			((e1 e2)
			 (let ((e2 (e2)))
			   (match e2
					  ((('to e2))
					   (if (and (or (int? (type-of e1)) (bool? (type-of e1)))
								(equal? (type-of e1) (type-of e2)))
						 (list 'RANGE (val-of e1) (val-of e2) (type-of e1))
						 (let ((t1 (if (string? (type-of e1)) (list 'enum (type-of e1)) (type-of e1)))
							   (t2 (if (string? (type-of e2)) (list 'enum (type-of e2)) (type-of e2))))
						   (if (and (enum? t1) (enum? t2))
							 (let ((union (Union t1 t2)))
							   (cond
								 ((null? union)
								  (ty-error line column 'alpha "Not compatible enumerator instances"))
								 ((> (length union) 1)
								  (ty-error line column 'alpha "Ambiguous enumarator range"))
								 (else
								   (let ((v1 (if (string? (type-of e1))
											   (val-of e1)
											   (list (cadr (assoc (cadr (val-of e1))
																  (cadr (lookup 'TYPE (caar union)))))
													 0)))
										 (v2 (if (string? (type-of e2))
											   (val-of e2)
											   (list (cadr (assoc (cadr (val-of e2))
																  (cadr (lookup 'TYPE (caar union)))))
													 0))))
									 (list 'RANGE v1 v2 (caar union))))))
							 (ty-error line column 'alpha "Incompatible range types")))))
					  (_ (ty-error line column 'alpha
								   "Expression must be followed by .. and expression")))))

			;(_ 'alpha)
			))))

(define do-bound2
  (lambda (lst)
	(match (map myapply lst)
		   ((("..") e) (list 'to e))
		   ((("range") r) r)
		   (_ 'alpha))))

(define do-bound3
  (lambda (lst)
	(match (map myapply lst)
		   ((("<>")) 'unconst)
		   ((t) t))))

(define do-range
  (lambda (lst)
	(match (map myapply lst)
		   ((e1 ("..") e2)
			(cond
			  ((or (alpha? (type-of e1))
				   (alpha? (type-of e2))) 'alpha)
			  ((and (or (int? (type-of e1))
						(bool? (type-of e1)))
					(equal? (type-of e1) (type-of e2))
					(if rangeT
					  (or (eq? (lookup 'TYPE rangeT) (type-of e1))
						  (eq? (lookup 'TYPE rangeT) (type-of e2)))
					  #t))
			   (list 'RANGE (val-of e1) (val-of e2) (type-of e1)))
			  (else
				(let ((t1 (if (string? (type-of e1)) (list 'enum (type-of e1)) (type-of e1)))
					  (t2 (if (string? (type-of e2)) (list 'enum (type-of e2)) (type-of e2))))
				  (if (and (enum? t1) (enum? t2))
					(let* ((union (Union t1 t2))
						   (union (if rangeT (if (assoc rangeT union) (list (assoc rangeT union)) '()) union)))
					  (set! rangeT #f)
					  (cond
						((null? union)
						 (ty-error line column 'alphga "Not compatible enumerator instances"))
						((> (length union) 1)
						 (ty-error line column 'alpha "Ambiguous enumarator range"))
						(else
						  (let ((v1 (if (string? (type-of e1))
									  (val-of e1)
									  (list (cadr (assoc (cadr (val-of e1))
														 (cadr (lookup 'TYPE (caar union)))))
											0)))
								(v2 (if (string? (type-of e2))
									  (val-of e2)
									  (list (cadr (assoc (cadr (val-of e2))
														 (cadr (lookup 'TYPE (caar union)))))
											0))))
							(list 'RANGE v1 v2 (caar union))))))
					(ty-error line column 'alpha "Incompatible range types"))))))
		   (_ 'alpha)
		   )))

(define do-record-decl
  (match-lambda
	((rec1 component end rec2 semi)
	 (let* ((rec1 (rec1))
			(enable (set! do-record? #t))
			(component (component))
			(disable (set! do-record? #f))
			(end (end))
			(rec2 (rec2))
			(semi (semi)))
	   component))
	(_ 'RERROR)))

(define do-component
  (lambda (lst)
	(match (map myapply lst)
		   ((("null") (";")) '(record (("" void))))
		   ((var vars)
			(let* ((vars
					 (match var
							(v
							  (list 'record
									(append v
											(let aloop ((vars (apply append vars)))
											  (if (null? vars)
												'()
												(match (car vars)
													   ((id T e) (cons (list id T e)
																	   (aloop (cdr vars))))
													   (x '())))))))))
				   (ht (make-hash-table 'equal))
				   (vs (begin (for-each (lambda (var)
										  (hash-table-put!
											ht
											(car var)
											(+ 1
											   (hash-table-get
												 ht
												 (car var)
												 (lambda () 0)))))
										(cadr vars))
							  (hash-table-for-each
								ht
								(lambda (v n)
								  (if (> n 1)
									(ty-error line column vars
											  "conflicting declarations of variable " v)))))))
			  vars))
		   (_ 'CERROR))))

(define do-access-decl
  (lambda (lst)
	(match (cadr (map myapply lst))
		   (("Id" l id) (if (lookup 'TYPE id)
						  (list 'access id)
						  (ty-error line column 'alpha
									"`" id "' is undefined")))
		   (_ '(void)))))

(define do-fun-sig
  (lambda (lst)
	(set! infun? #t)
	(match (map myapply lst)
		   ((function (and name (? string?)) () return ("Id" l T))
			(set! infun? #f)
			(if (lookup 'TYPE T)
			  (list name (list '-> 'void (if (symbol? (lookup 'TYPE T)) (lookup 'TYPE T) T)))
			  (ty-error line column '()
						"Undefined return type")))
		   ((function (and name (? string?)) (params) return ("Id" l T))
			(set! infun? #f)
			(if (lookup 'TYPE T)
			  (list name (list '-> params (if (symbol? (lookup 'TYPE T)) (lookup 'TYPE T) T)))
			  (ty-error line column '()
						"Undefined return type")))
		   (_ 'alpha))))

(define do-fun-name
  (lambda (lst)
	(match (map myapply lst)
		   ((("Id" l name)) name)
		   ((("Str" s)) (if (member s '("and" "or"
										"=" "/=" "<" "<=" ">" ">="
										"+" "-" "&"
										"*" "/" "mod"
										"**" "abs" "not"))
						  s
						  (ty-error line column 'error
									"Invalid overloading of a built-in function: `" s "' doesn't exist")))
		   (_ 'error))))

(define do-fun-decl
  (lambda (lst)
	(match (map myapply lst)
		   ((((and name (? string?)) rest) semi)
			(let ((N (getFreeInt #f)))
			  (insert-info! 'FUN-DECL name (cons N rest))
			'(void)))
		   (_ '(void)))))

(define do-fun-body
  (match-lambda
	((sig mid semi)
	 (let ((sig (sig))
		   (NUMBER 0))
	   (match (list (peek-token) sig)
			  (("is" ((and name (? string?)) rest))
			   (let ((N (without #f
								   (map (lambda (x)
										  (if (equal? (cdr x) (cadr sig))
											(car x) #f))
										(or (lookup 'FUN name) '())))))
				 (if (null? N)
				   (begin
					 (set! NUMBER (getFreeInt #f))
					 (insert-info! 'FUN-BODY name (cons NUMBER rest)))
				   (set! NUMBER (car N)))))
			  (_ (set! NUMBER (getFreeInt #f))
				 (insert-info! 'FUN-DECL (car sig) (cons NUMBER (cadr sig)))))
	   (append-scope!)
	   (if *scope* (mdisplay "-- Scope start of function:" (car sig)))
	   (set! do-scope
		 (cons 'FunBody
			   (cons (match sig
							(((? string?) ('-> para ret)) ret)
							(_ 'alpha))
					 do-scope)))
	   (if (list? (cadadr sig))
		 (for-each (lambda (lst)
					 (match lst
							((name mode T e) (insert-info! 'VAR name (lookup 'TYPE T)))
							(_ '())))
				   (cadadr sig)))
	   (match (cons sig (map myapply (list mid semi)))
			  ((((and name (? string?)) rest) () semi)
			   (delete-scope!)
			   (if *scope* (mdisplay "-- Scope end of function:" (car sig)))
			   (set! do-scope (cddr do-scope))
			   (list (list 'SIG (string-append "_" (number->string NUMBER) "_" (car sig)))))
			  ((((and name (? string?)) rest) (is ds beginn except end id) semi)
			   (delete-scope!)
			   (if *scope* (mdisplay "-- Scope end of function:" (car sig)))
			   (set! do-scope (cddr do-scope))
			   (if (or (null? id) (match id ((("Id" l id)) (equal? id name)) ((id) (equal? id name))))
				 (list (list 'FUN
							 (string-append "_" (number->string NUMBER) "_" name)
							 (match sig
									((name para) (match para
														(('-> 'void T) '())
														(('-> (and para (? list-of-lists?)) T) (map car para))
														(_ '())))
									(_ '()))
							 (list 'DEF (apply append (apply append ds)))
							 (list 'BEGIN (match beginn
												 ((b beginn) (apply append beginn))
												 (_ '())))
							 (list 'EXCEPT (match except
												  ((e except) (apply append except))
												  (_ '())))
							 ))
				 (ty-error-stmt "Function's names don't correspond")))
			  (_ (delete-scope!)
				 (if *scope* (mdisplay "-- Scope end of function:" (car sig)))
				 (set! do-scope (cddr do-scope))
				 '(void)))))
	(_ '(void))))
(define do-proc-sig
  (lambda (lst)
	(match (map myapply lst)
		   ((function ("Id" l name) ())
			(list name (list '-> 'void 'void)))
		   ((function ("Id" l name) (params))
			(list name (list '-> params 'void)))
		   (_ 'alpha))))

(define do-proc-decl
  (lambda (lst)
	(match (map myapply lst)
		   ((((and name (? string?)) rest) semi)
			(let ((N (getFreeInt #f)))
			  (insert-info! 'FUN-DECL name (cons N rest))
			  '(void)))
		   (_ '(void)))))

(define do-proc-body
  (match-lambda
	((sig mid semi)
	 (let ((sig (sig))
		   (NUMBER #f))
	   (match (list (peek-token) sig)
			  (("is" ((and name (? string?)) rest))
			   (let ((N (without #f
								 (map (lambda (x)
										(if (equal? (cdr x) (cadr sig))
										  (car x) #f))
									  (or (lookup 'FUN name) '())))))
				 (if (null? N)
				   (begin
					 (set! NUMBER (getFreeInt #f))
					 (insert-info! 'FUN-BODY name (cons NUMBER rest)))
				   (set! NUMBER (car N)))))
			  (_ (set! NUMBER (getFreeInt #f))
				 (insert-info! 'FUN-DECL (car sig) (cons NUMBER (cadr sig)))))
	   (append-scope!)
	   (if *scope* (mdisplay "-- Scope start of procedure:" (car sig)))
	   (set! do-scope (cons 'ProcBody do-scope))
	   (if (list? (cadadr sig))
		 (for-each (lambda (lst)
					 (match lst
							((name mode T e) (insert-info! 'VAR name (lookup 'TYPE T)))
							(_ '())))
				   (cadadr sig)))

	   (match (cons sig (map myapply (list mid semi)))
			  ((((and name (? string?)) rest) () semi)
			   (delete-scope!)
			   (if *scope* (mdisplay "-- Scope end of procedure:" (car sig)))
			   (set! do-scope (cdr do-scope))
			   (list (list 'SIG (string-append "_" (number->string NUMBER) "_" (car sig)))))
			  ((((and name (? string?)) rest) (is ds beginn except end id) semi)
			   (delete-scope!)
			   (if *scope* (mdisplay "-- Scope end of procedure:" (car sig)))
			   (set! do-scope (cdr do-scope))
			   (if (or (null? id) (match id ((("Id" l id)) (equal? id name)) (_ #f)))
				 (list (list 'FUN
							 (string-append "_" (number->string NUMBER) "_" name)
							 (match sig
									((name para) (match para
														(('-> 'void 'void) '())
														(('-> (and para (? list-of-lists?)) 'void) (map car para))
														(_ '())))
									(_ '()))
							 (list 'DEF (apply append (apply append ds)))
							 (list 'BEGIN (match beginn
												 ((b beginn) (apply append beginn))
												 (_ '())))
							 (list 'EXCEPT (match except
												  ((e except) (apply append except))
												  (_ '())))
							 ))
				 (ty-error-stmt "Procedure's names don't correspond")))
			  (_ (delete-scope!)
				 (if *scope* (mdisplay "-- Scope end of procedure:" (car sig)))
				 (set! do-scope (cdr do-scope))
				 '(void)))))
	(_ '(void))))

(define do-param-list
  (lambda (lst)
	(match (map myapply lst)
		   ((open (and param (? list?)) () close) param)
		   ((open (and param (? list?)) params close)
			(let ((params (append param
								  (let aloop ((lst params)
											  (vis (without #f (map (lambda(x) (if(alpha? x)#f
																				 (car x)))param))))
									(if (null? lst)
									  '()
									  (let* ((semi (car lst))
											 (param (if (list? (cadr lst)) (cadr lst) '(alpha)))
											 (vars (without #f (map(lambda(x)(if(alpha? x)#f(car x)))param))))
										(if (null? (without #f (map (lambda (id)
																	  (if(alpha? id)#f
																		(member id vis)))
																	vars)))
										  (append param
												  (aloop (cddr lst) (append vars vis)))
										  (ty-error line column '(alpha)
													"Erroneous repetition of parameters"))))))))
			  params))
		   (_ 'void)
		   )))

(define do-param
  (lambda (lst)
	(match (map myapply lst)
		   ((("Id" l id) ids col in out ("Id" l T) e)
			(cond
			  ((not (lookup 'TYPE T)) (ty-error line column '(alpha) "Unknown type `" T "'"))
			  ((and infun? (not (null? out)))
			   (ty-error line column '(alpha)
						 "Function arguments can't have mode OUT"))
			  ((and (= (length e) 2) (list? (cadr e))
					(and (not (equal? (lookup 'TYPE T) (type-of (cadr e))))
						 (and (enum? (type-of (cadr e)))
							  (not (member T (type-of (cadr e)))))))

			   (ty-error line column '(alpha)
						 "Parameter type doesn't match with expression's"))
			  (else
				(map
				  (lambda (id)
					(list id
						  (cond
							((and (null? in) (null? out)) 'IN)
							((null? in) 'OUT)
							((null? out) 'IN)
							(else 'IN-OUT))
						  T (match e (((":=") e) e) (_ #f))))
				  (cons id
						(let aloop ((lst ids) (vis (list id)))
						  (if (null? lst) '()
							(let ((comma (car lst))
								  (id (match (cadr lst) (("Id" l id) id) (_ 'alpha))))
							  (unless (member id vis)
								(cons id (aloop (cddr lst) (cons id vis)))
								(ty-error
								  line column '(alpha)
								  "Erroneous repetition of parameter `" id "'"))))))))))
		   (_ 'alpha))))


(define (do-statement lst)
  (match
	(peek-token)
	("Id" (set! do-scope (cons (token-name) do-scope)))
	(_ '()))
  (match
	(map myapply lst)
	((("null") semi) '(void))
	((("if") e1 then s1 elif els end iff semi)
	 (unless (or (alpha? (type-of e1)) (bool? (type-of e1)))
	   (ty-error-stmt "IF conditional should be of boolean type")
	   (let* ((elif (let aloop ((lst elif))
					  (if (null? lst)
						lst
						(let* ((elsif (car lst))
							   (e (cadr lst))
							   (then (caddr lst))
							   (s (apply append (cadddr lst))))
						  (unless (or (alpha? (type-of e)) (bool? (type-of e)))
							(begin
							  (ty-error-stmt "ELSIF conditional should be of boolean type")
							  '())
							(cons (list 'ELSIF (val-of e) s)
								  (aloop (cddddr lst))))))))
			  (els (match els
						  (() els)
						  ((("else") s) (list 'ELSE (apply append s))))))
		 (list (list 'IF (val-of e1) (apply append s1) elif els)))))
	((("exit") id when semi) (list
							   (list 'EXIT
									 (match id
											((("Id" l id))
											 (if (member id do-scope)
											   id
											   (ty-error line column 'error
														 "Unknown loop name: `" id "'")))
											(() (if (memq 'Loop do-scope)
												  (cadr (memq 'Loop do-scope))
												  (ty-error line column 'error
															"Exit statement must be within a loop")))
											(_ '())
											)
									 (match when
											((("when") e)
											 (if (or (alpha? (type-of e))
													 (bool? (type-of e)))
											   (val-of e)
											   (ty-error line column 'error
														 "Expression in when clause must be of boolean type")))
											(_ '(1 0))
											))))
	; need to do much more work of typechecking
	((("return") e semi)
	 (unless (null? e)
	   (if (memq 'FunBody do-scope)
		 (if (equal? (cadr (memq 'FunBody do-scope)) (type-of (car e)))
		   (list (list 'RETURN (val-of (car e))))
		   (ty-error-stmt "Return type of the current function doesn't match"))
		 (ty-error-stmt "Not in a function to be able to return from"))
	   (if (or #f ;(memq 'PacBody do-scope)
			   (memq 'ProcBody do-scope))
		 '((RETURN))
		 (ty-error-stmt "Not in a procedure to be able to return from"))))
	((("raise") x semi)
	 (if (null? x)
	   '((RAISE))
	   (match x
			  ((("Id" l id)) (list (list 'RAISE id)))
			  (_ '(void)))))
	((("Id" l id) rest)
	 (match rest
			('semi (let* ((f (lookup 'FUN id))   ; parameterless proc called
						  (fs (unless f '()
								(without #f
										 (map (lambda (f)
												(match f
													   ((num '-> 'void 'void) num)
													   (_ #f)))
											  f)))))
					 (if (= (length (without #f fs)) 1)
					   (list (list 'PCALL (string-append "_" (number->string (car (without #f fs))) "_" id) '()))
					   (ty-error-stmt "No compatible procedure found")
					   )))
			(('label rest) rest)
			(('lookup lst e) (if (lookup 'VAR id)
							   (if (member (lookup 'VAR id) '(enum int string float bool))
								 (if (equal? (lookup 'VAR id)
											 (type-of e))
								   (list (list 'STORE (list 'VAR id) (val-of e)))
								   (ty-error-stmt "Can't assign a value to a variable of inferior type"))
								 (let aloop ((left (list (list 'VAR id) (lookup 'VAR id)))
											 (lst lst))
								   (if (null? lst)
									 (let ((T (lookup 'TYPE (type-of left))))
									   (if (access? T)
										 (aloop (list (list 'DEREF (val-of left)) (cadr T))
												lst)
										 (list (list 'STORE (val-of left) (val-of e)))))
									 (let ((id (cadar lst)))   ; [ ('FIELD id) .... ]
									   (let* ((v (type-of left))  ; v = "k"
											  (T (lookup 'TYPE v))) ; T = '(record (("Data" 'int) ...))
										 (cond
										   ((access? T)
											(aloop (list (list 'DEREF (val-of left))
														 (cadr T))
												   (if (eq? id 'all)
													 (cdr lst)
													 lst)))
										   ((record? T)
											(let ((r (assoc id (cadr T))))
											  (if (not r)
												(ty-error-expr "Record `" v "' doesn't contain field `" id "'")
												(aloop (list (list 'LOOKUP-FIELD (val-of left) v id) (cadr r)) (cdr lst)))))
										   (else 
											 (ty-error-expr "To use `.' (dot) left hand side must be a record"))))))))
							   (ty-error-stmt "No such variable to assign a value to: `" id "'")))

			(('para arg) (if (or (lookup 'FUN id) (member id '("write" "read")))	; procedure?
						   (let* ((sig (or (lookup 'FUN id) '()))
								  (sig (without #f (map (match-lambda ((NUM '-> from 'void) (list NUM '-> from 'void)) (_ #f)) sig)))
								  (arg (map (match-lambda (((v 'agr) 'as T) (list v 'as T))
														  ((v T) (list v T))
														  (_ 'error))
											arg))
								  (fun (map (lambda (f) (mama arg (cadr f))) (map cdr sig))))
							 (case (length (without #f fun))
							   ((0) (match id
									  ("write" (match arg
														(((v T)) (list (list 'PRINT v)))
														(_ (ty-error-stmt "No compatible procedure found"))))
									  ("read" (match arg
														((((and ('VAR _) v) T)) (match T
																				  ('int (list (list 'STORE v (list 'TOINT (list 'READ-NUM)))))
																				  ('float (list (list 'STORE v (list 'TOFLOAT (list 'READ-NUM)))))
																				  ('string (list (list 'STORE v (list 'READ-STR))))
																				  (_ (ty-error-stmt "No_compatible procedure found"))))
														(_ (ty-error-stmt "No compatible procedure found"))))
									  (_ (ty-error-stmt "No compatible procedure found"))))
							   ((1) (list (list 'PCALL (string-append "_" (number->string (car (list-ref sig (find-ref fun)))) "_" id) (car (without #f fun)))))
							   (else (ty-error-stmt "Ambiguous procedure call"))))
						   (ty-error-stmt "No procedure found with the name: " id)))
			(lst lst)
			))
	(('CASE e when) (list 'CASE e when))
	(('FOR a b c d) (list 'FOR a b c d))
	((block) (list block))
	(_ '(void))
	))

(define do-cas
  (lambda (lst)
	(let* ((ca ((car lst)))
		   (expr ((cadr lst)))
		   (val (val-of expr))
		   (type (if (and (list? (type-of expr))
						  (not (null? (type-of expr)))
						  (eq? 'enum (car (type-of expr))))
				   (if (> (length (type-of expr)) 2)
					 (ty-error line column 'alpha "Ambiguous enumerable expression")
					 (begin
					   (set! val (resolve-enum val (cadr (lookup 'TYPE (cadr (type-of expr))))))
					   (cadr (type-of expr))))
				   (type-of expr)))
		   (type (if (or (enum? type) (int? type) (bool? type) (alpha? type))
				   type
				   (ty-error line column 'alpha "Case works only on integer, boolean, or enumerator types")))
		   )
	  (set! do-scope (cons 'Case (cons type do-scope)))
	  (match (cons ca (cons (list val type) (map myapply (cddr lst))))
			 ((("case") e is when end cas semi)
			  (set! do-scope (cddr do-scope))
			  (list 'CASE (val-of e) (let aloop ((when when))
							  (if (or (void? when) (null? when))
								when
								(cons (cadr when)
									  (aloop (cddr when)))))))
			 (_ 'crap)
			 ))))


(define do-id-rest
  (lambda (lst)
	(if (not (equal? (peek-token) ":"))
	  (set! do-scope (cdr do-scope)))
	(match (map myapply lst)
		   (((";")) 'semi)
		   (((":") rest2) (if (not (member (car do-scope) except-list))
							(set! except-list (cons (car do-scope) except-list)))
						  (set! do-scope (cdr do-scope))
						  (list 'label rest2))
		   (((arg) () () (";")) (list 'para arg))
		   ((() lst ((":=") e) (";")) (list 'lookup lst e))
		   (_ '(error))
		   )))

(define do-subname
  (lambda (lst)
	(match (map myapply lst)
		   (((".") name) (list 'FIELD (match name
											 (('Id id) id)
											 (('Str id) id)
											 ('all 'all))))
		   (lst lst))))

(define do-id-rest2 (lambda (lst) (map myapply lst)))

(define do-block
  (lambda (lst)
	(append-scope!)
	(if *scope* (mdisplay "--- Entering block " (if (string? (car do-scope)) (car do-scope) "")))
	(if (not (string? (car do-scope))) (set! do-scope (cons (number->string (getFreeInt #f)) do-scope)))
	(set! do-scope (cons 'Block do-scope))
	(let ((k (string->number (cadr do-scope))))
	  (match (map myapply lst)
			 ((declare beginn s except end id semi)
			  (delete-scope!)
			  (set! do-scope (cdr do-scope)) ;deleting 'Block
			  (if *scope* (mdisplay "--- Leaving block"))
			  (cond
				((and (null? id) (not k))
				 (ty-error line column '(void) "Named block must be ended with name"))
				((match id
						((("Id" l id)) (not (or k (equal? id (car do-scope)))))
						(_ #f))
				 (ty-error line column '(void) "Block's names don't match"))
				(else
				  (list 'BLOCK (number->string k)
						(list 'DEF (match declare
										  ((d ds) (apply append (apply append ds)))
										  (_ '())))
						(list 'BEGIN (apply append s))
						(list 'EXCEPT (match except
											 ((e es) (apply append (apply append es)))
											 (_ '())))))))
			 (_ (delete-scope!)
				(if *scope* (mdisplay "--- Leaving block"))
				'(void))))))

(define do-loop
  (lambda (lst)
	(if (not (string? (car do-scope))) (set! do-scope (cons (number->string (getFreeInt #t)) do-scope)))
	(set! do-scope (cons 'Loop do-scope))
	;check if label name already exists:
	(let ((k (if (string? (cadr do-scope)) (string->number (cadr do-scope)) #f)))
	  (match (map myapply lst)
			 ((l1 s end l2 (("Id" l id)) semi)		;Named loop
			  (set! do-scope (cdr do-scope))
			  (if (eq? 'Loop (car do-scope)) (set! do-scope (cdr do-scope)))
			  (cond
				((and (string? (car do-scope)) (equal? id (car do-scope)))
				 (list 'LOOP id (apply append s)))
				(k
				 (list 'LOOP (number->string k) (apply append s)))
				((and (not k) (string? (car do-scope)))
				 (ty-error line column '(void) "Loop names don't match"))
				(else
				  (ty-error line column '(void) "Named loop needs a label before it"))))
			 ((l1 s end l2 () semi)					;Nameless loop
			  (set! do-scope (cddr do-scope))
			  (if (not k)
				(ty-error line column '(void) "Named loop needs to be named in the end")
				(list 'LOOP (number->string k) (apply append s))))
			 (_ (set! do-scope (cdr do-scope))
				(if (number? (car do-scope))
				  (set! do-scope (cdr do-scope)))
				'(void))
			 ))))

(define do-while
  (lambda (lst)
	(match (map myapply lst)
		   ((while e loop)
			(match e
				   ((e 'bool) (match loop
									 (('LOOP name rest) (list 'WHILE e name rest))
									 (_ '(void))))
				   ((_ 'alpha) '(void))
				   ((_ T) (ty-error line column '(void) "While expression must be of type Boolean"))
				   (_ '(void))))
		   (_ '(void)))))

(define do-for
  (lambda (lst)
	(append-scope!)
	(match lst
		   ((for id in rev range loop)
			(let* ((for (for))
				   (id (match (id) (("Id" l id) id) (_ 'error)))
				   (in (in))
				   (rev (rev))
				   (range (range))
				   (tmp (insert-info! 'VAR id (cadddr range)))
				   (loop (loop)))
			  (delete-scope!)
			  (list 'FOR id rev range loop)))
		   (_ (delete-scope!)
			  '(void)))))

(define do-when-list
  (lambda (lst)
	(let ((type (cadr do-scope)))   ;		type :: string
	  (match (map myapply lst)
			 ((("others") ("=>") stmt)
			  (list 'ELSE (without 'void (apply append stmt))))
			 (((e T) range ors ("=>") stmt)
			  (call/cc
				(lambda (bk)
				  (if (alpha? T) (bk 'void))
				  (let* ((e e)
						 (T (if (and (list? T)
									 (not (null? T))
									 (eq? 'enum (car T)))
							  (if (member type T)
								(begin
								  (set! e (resolve-enum e (cadr (lookup 'TYPE type))))
								  type)
								(begin
								  (ty-error line column 'alpha "Ambiguous enumerable expression")
								  (bk 'void)))
							  (if (equal? type T)
								type
								(begin
								  (ty-error line column 'alpha "WHEN expression must be of type `" type "'")
								  (bk 'void)))))
						 )
					(list 'WHEN
						  (let ((first (match range
											  ((("..") (f S))
											   (let* ((f f)
													  (T S)
													  (T (if (and (list? T)
																  (not (null? T))
																  (eq? 'enum (car T)))
														   (if (member type T)
															 (begin
															   (set! f (resolve-enum f (cadr (lookup 'TYPE type))))
															   type)
															 (begin
															   (ty-error line column 'alpha "Ambiguous enumerable expression")
															   (bk 'void)))
														   (if (equal? type T)
															 type
															 (begin
															   (ty-error line column 'alpha "WHEN expression must be of type `" type "'")
															   (bk 'void)))))
													  )
												 (list 'RANGE e f)))
											  (_ e)))
								(rest (let aloop ((lst ors))
										(if (null? lst)
										  '()
										  (let ((x (car lst))
												(y (cadr lst))
												(z (caddr lst)))
											(match (list y z)
												   (((e T) (("..") (f S)))
													(let* ((e e)
														   (f f)
														   (T T)
														   (T (if (and (list? T)
																	   (not (null? T))
																	   (eq? 'enum (car T)))
																(if (member type T)
																  (begin
																	(set! e (resolve-enum e (cadr (lookup 'TYPE type))))
																	type)
																  (begin
																	(ty-error line column 'alpha "Ambiguous enumerable expression")
																	(bk 'void)))
																(if (equal? type T)
																  type
																  (begin
																	(ty-error line column 'alpha "WHEN expression must be of type `" type "'")
																	(bk 'void)))))
														   (T S)
														   (T (if (and (list? T)
																	   (not (null? T))
																	   (eq? 'enum (car T)))
																(if (member type T)
																  (begin
																	(set! f (resolve-enum f (cadr (lookup 'TYPE type))))
																	type)
																  (begin
																	(ty-error line column 'alpha "Ambiguous enumerable expression")
																	(bk 'void)))
																(if (equal? type T)
																  type
																  (begin
																	(ty-error line column 'alpha "WHEN expression must be of type `" type "'")
																	(bk 'void)))))
														   )
													  (cons (list 'RANGE e f) (aloop (cdddr lst)))))
												   (((e T) ())
													(let* ((e e)
														   (T T)
														   (T (if (and (list? T)
																	   (not (null? T))
																	   (eq? 'enum (car T)))
																(if (member type T)
																  (begin
																	(set! e (resolve-enum e (cadr (lookup 'TYPE type))))
																	type)
																  (begin
																	(ty-error line column 'alpha "Ambiguous enumerable expression")
																	(bk 'void)))
																(if (equal? type T)
																  type
																  (begin
																	(ty-error line column 'alpha "WHEN expression must be of type `" type "'")
																	(bk 'void)))))
														   )
													  (cons e (aloop (cdddr lst)))))
												   (_ (bk 'void))
												   ))))))
							(unless (null? rest)
							  (cons 'COR (cons first rest))
							  (list first)))
						  (without 'void (apply append stmt)))))))
			 (_ 'vOId)))))

(define do-expr
  (match-lambda
	((re lst)
	 (let* ((re (re)) (lst (lst)))
	   (let aloop ((re re)(lst lst))
		 (if (null? lst)
		   re
		   (aloop (let* ((w1 re)
						 (w2 (cadr lst))
						 (op (car lst)))
					(cond
					  ((alpha? (type-of w1)) (list 'error 'alpha))
					  ((alpha? (type-of w2)) (list 'error 'alpha))
					  ((and (bool? (type-of w1)) (bool? (type-of w2)))
					   (list (list (car op) (val-of w1) (val-of w2))
							 'bool
							 ))
					  (else
						(ty-error (cadr op) (caddr op) (list 'error 'alpha)
								  (car op) " works on boolean values"))))
				  (cddr lst))))))
	(_ 'EXOR)))

(define do-expr2
  (match-lambda
	((re lst)
	 (let* ((re (re)) (lst (lst)))
	   (let aloop ((re re)(lst lst))
		 (if (null? lst)
		   re
		   (aloop (let* ((w1 re)
						 (w2 (cadr lst))
						 (op (car lst)))
					(cond
					  ((alpha? (type-of w1)) (list 'error 'alpha))
					  ((alpha? (type-of w2)) (list 'error 'alpha))
					  ((and (bool? (type-of w1)) (bool? (type-of w2)))
					   (list (list (car op) (val-of w1) (val-of w2))
							 'bool
							 ))
					  (else
						(ty-error (cadr op) (caddr op) (list 'error 'alpha)
								  (car op) " works on boolean values"))))
				  (cddr lst))))))
	(_ 'EXOR2)))

(define do-orelse
  (lambda (lst)
	(let* ((op ((car lst)))
		   (line line) (column column)
		   (ap ((cadr lst))))
	  (list (if (null? ap) 'OR 'OR-ELSE) line (- column 2)))))

(define do-andthen
  (lambda (lst)
	(let* ((op ((car lst)))
		   (line line) (column column)
		   (ap ((cadr lst))))
	  (list (if (null? ap) 'AND 'AND-THEN) line (- column 3)))))

(define do-relation
  (match-lambda
	((si lst)
	 (let* ((si (si))(lst (lst)))
	   (if (or (null? lst) (= 1 (length lst)))
		 si
		 (let* ((w1 si)
				(w2 (cadr lst))
				(op (car lst))
				(t1 (type-of w1))
				(t1 (if (string? t1) (list 'enum t1) t1))
				(t2 (type-of w2))
				(t2 (if (string? t2) (list 'enum t2) t2)))
		   (cond
			 ((or (and (int? (type-of w1))
					   (int? (type-of w2)))
				  (and (float? (type-of w1))
					   (float? (type-of w2))))
			  (list (list (car op) (val-of w1) (val-of w2)) 'bool))
			 ((and (astring? (type-of w1))
				   (astring? (type-of w2)))
			  (list (list (car op) (val-of w1) (val-of w2)) 'bool))
			 ((and (enum? t1)
				   (enum? t2))
			  (let ((union (Union t1 t2)))
				(cond
				  ((null? union) (ty-error (cadr op) (caddr op) '(error alpha)
										   "Not compatible enumerator type instances"))
				  ((> (length union) 1)
				   (cond
					 ((equal? (cadr (val-of w1)) (cadr (val-of w2)))
					  (if (memq (car op) '(EQ LEQ GEQ))
						'((1 0) bool)
						'((0 0) bool)))
					 (else (ty-error (cadr op) (caddr op) '(error alpha)
									 "Ambiguous operands for comparison"))))
				  (else
					(list (list (car op)
								(let ((ke (assoc (cadr (val-of w1))
												 (cadr (lookup 'TYPE (caar union))))))
								  (if ke (list (cadr ke) 0) (val-of w1)))
								(let ((ke (assoc (cadr (val-of w2))
												 (cadr (lookup 'TYPE (caar union))))))
								  (if ke (list (cadr ke) 0) (val-of w2))))
						  'bool)))))

			 (else
			   (ty-error (cadr op) (caddr op) '(error alpha)
						 (symbol->string (car op))
						 " works on string, enumerator and numeric values of the same type"))))
		 )))
	(_ 'RERROR)))

(define do-relat_op
  (lambda (op) (let* ((op ((car op))))
				 (list (match op
							  (("=") 'EQ)
							  (("/=") 'NEQ)
							  (("<") 'LT)
							  (("<=") 'LEQ)
							  ((">") 'GT)
							  ((">=") 'GEQ)
							  (_ 'ERR)
							  ) line (- column (string-length (car op)))))))

(define do-simp_expr
  (match-lambda
	((un te lst)
	 (let* ((un (un))
			(te (te))
			(lst (lst))
			(te (cond
				  ((alpha? (type-of te)) te)
				  ((and (not (null? un))
						(eq? (caar un) 'MINUS))
				   (if (or (int? (type-of te))
						   (float? (type-of te)))
					 (list (list 'NEG (val-of te)) (type-of te))
					 (ty-error (cadar un) (caddar un) (list 'error 'alpha)
							   "Unary operations only work on numeric types")))
				  (else te))))
	   (let aloop ((te te)(lst lst))
		 (if (or (null? lst) (alpha? (type-of te)))
		   te
		   (aloop (let ((w1 te)
						(w2 (cadr lst))
						(op (car lst)))
					(cond
					  ((alpha? (type-of w1)) w1)
					  ((alpha? (type-of w2)) w1)
					  ((eq? (car op) 'AMP)
					   (if (and (astring? (type-of w1))
								(astring? (type-of w2)))

						 (list (list 'CONCAT (val-of w1) (val-of w2)) 'string)
						 (ty-error (cadr op) (caddr op) (list 'error 'alpha)
								   "Can only concatenate strings")))
					  ((or (and (int? (type-of w1)) (int? (type-of w2)))
						   (and (float? (type-of w1)) (float? (type-of w2))))
					   (list (list (car op) (val-of w1) (val-of w2))
							 (type-of w1) ;or w2
							 ))
					  (else
						(ty-error (cadr op) (caddr op) (list 'error 'alpha)
								  (car op) " works on numeric values of the same type"))))
				  (cddr lst))))))
	(_ 'SERROR)))

(define do-unary_op
  (lambda (op) (let* ((op ((car op))))
				 (match op
						(("+") (list 'PLUS line (1- column)))
						(("-") (list 'MINUS line (1- column)))
						(_ 'ERR)
						))))

(define do-adding_op
  (lambda (op) (let* ((op ((car op))))
				 (match op
						(("&") (list 'AMP line (1- column)))
						(un un)
						))))

(define do-term
  (match-lambda
	((fac lst)
	 (let aloop ((fac (fac))(lst (lst)))
	   (if (null? lst)
		 fac
		 (aloop (let ((w1 fac)
					  (w2 (cadr lst))
					  (op (car lst)))
				  (if (or (and (int? (type-of w1))
							   (int? (type-of w2)))
						  (and (float? (type-of w1))
							   (float? (type-of w2))))
					(list (list (car op) (val-of w1) (val-of w2))
						  (type-of w1) ;or w2
						  )
					(ty-error (cadr op) (caddr op) (list 'error 'alpha)
							  (symbol->string (car op))
							  " works on numeric values of the same type")))
				(cddr lst)))))
	(_ 'TERROR)))

(define do-mult_op
  (lambda (op) (let* ((op ((car op))))
				 (list (match op
							  (("/") 'DIV)
							  (("*") 'MUL)
							  (("mod") 'MOD)
							  (_ 'MERR)
							  ) line (- column (string-length (car op)))))))

(define do-factor
  (lambda (lst)
	(let* ((a ((car lst)))
		   (line line)
		   (column (1- column))
		   (b ((cadr lst))))
	  (match (list a b)
			 ((("not") pri) (cond
							  ((alpha? (type-of pri)) pri)
							  ((bool? (type-of pri))
							   (list (list 'NOT (val-of pri)) 'bool))
							  (else (ty-error line column (list 'error 'alpha)
											  "NOT takes a boolean type"))))
			 ((("abs") pri) (cond
							  ((alpha? (type-of pri)) pri)
							  ((or (int? (type-of pri))
								   (float? (type-of pri)))
							   (list (list 'ABS (val-of pri)) (type-of pri)))
							  (else (ty-error line column (list 'error 'alpha)
											  "ABS takes a numeric type"))))
			 ((pri ()) pri)
			 ((pri (("**") pro)) (cond
								   ((or (alpha? (type-of pri))
										(alpha? (type-of pro))) '(error alpha))
								   ((and (or (int? (type-of pri))
											 (float? (type-of pri)))
										 (int? (type-of pro)))
									(list (list 'POW (val-of pri) (val-of pro))
										  (type-of pri)))
								   (else
									 (ty-error line column (list 'error 'alpha)
											   "Power function can only raise numeric types to the power of a positive integer"))))
			 (_ 'ERACTOR)))))

;(no functions, records, arrays, aggregates!)
(define (do-primary e)
  (let* ((e (map myapply e)))
	(match e
		   ((("Id" l var) lst)
			(if (and (equal? (peek-token) "=>") (not (eq? 'Case (car do-scope))))
			  (list var 'agr)	; part of aggregate, ie. =>
			  (if (lookup 'FUN var)							; Function?
				(if (null? lst)
				  (let ((ret (unless (lookup 'FUN var) '()  ; No params
							   (map (lambda (f)
									  (match f
											 ((NUM '-> 'void ret) (list NUM ret))
											 (_ #f)))
									(lookup 'FUN var)))))
					(case (length (without #f ret))
					  ((0) (ty-error-expr "No compatible function found"))
					  ((1) (list (list 'CALL (string-append "_" (number->string (caar (without #f ret))) "_" var) '()) (cadar (without #f ret))))
					  (else (ty-error-expr "Ambiguous function call"))))

				  (let ((fun (map (lambda (f) (mama (car lst) (caddr f))) (lookup 'FUN var))))
					(case (length (without #f fun))
					  ((0) (ty-error-expr "No compatible function found"))
					  ((1) (let* ((n (find-ref fun))
								  (NUM (car (list-ref (lookup 'FUN var) n)))
								  (T (cadddr (list-ref (lookup 'FUN var) n))))
							 (list (list 'CALL (string-append "_" (number->string NUM) "_" var)
										 (map (match-lambda
												((a inout b (v T)) (list a inout b v))
												(x x))
											  (car (without #f fun)))) T)))
					  (else (ty-error-expr "Ambiguous function call"))))
				  )
				(let* ((v (lookup 'VAR var))				; Non-function
					   (T (lookup 'TYPE v)))
				  (if (or (and (not v) (not (lookup 'TYPE var))) (void? T))
					(if (void? T)
					  (ty-error-expr "Trying to use a variable of a not fully defined type")
					  (ty-error-expr "Undeclared variable `" var"'"))
					(let aloop ((left (if (lookup 'TYPE var)
										(list var 'typ)
										(list (list 'VAR var) v)))
								(lst lst))
					  (if (null? lst)
						left
						(match (car lst)
							   (('dot ('Id id))
								(let* ((v (type-of left))  ; v = "k"
									   (T (lookup 'TYPE v))) ; T = '(record (("Data" 'int) ...))
								  (cond
									((access? T)
									 (aloop (list (list 'DEREF (val-of left))
												  (cadr T))
											lst))
									((record? T)
									 (let ((r (assoc id (cadr T))))
									   (if (not r)
										 (ty-error-expr "Record `" v "' doesn't contain field `" id "'")
										 (aloop (list (list 'LOOKUP-FIELD (val-of left) v id) (cadr r))
												(cdr lst)))))
									(else 
									  (ty-error-expr "To use `.' (dot) left hand side must be a record")))))
							   (('dot 'all)
								(let* ((v (type-of left))
									   (T (lookup 'TYPE v)))
								  (unless (access? T)
									(ty-error-expr "`.all' dereferences accessor types")
									(aloop (list (list 'DEREF (val-of left))
												 (cadr T))
										   (cdr lst)))))
							   (('apo agg)
								(match agg
									   ("succ" (if (or (enum? (type-of left))
													   (enum? (lookup 'TYPE (type-of left)))
													   (int? (lookup 'TYPE (type-of left)))
													   (int? (type-of left))
													   )
												 (aloop (list (list 'PLUS (val-of left) '(1 0))
															  (type-of left))
														(cdr lst))
												 (ty-error-expr
												   "Attribute Succ works on numerical and enumerator values only")))
									   ("pred" (if (or (enum? (type-of left))
													   (enum? (lookup 'TYPE (type-of left)))
													   (int? (lookup 'TYPE (type-of left)))
													   (int? (type-of left))
													   )
												 (aloop (list (list 'MINUS (val-of left) '(1 0))
															  (type-of left))
														(cdr lst))
												 (ty-error-expr
												   "Attribute Pred works on numerical and enumerator values only")))
									   ("ceiling" (if (or (float? (lookup 'TYPE (type-of left)))
														  (float? (type-of left)))
													(aloop (list (list 'TOINT (list 'CEILING (val-of left))) 'int)
														   (cdr lst))
													(ty-error-expr
													  "Attribute Ceiling works on float values only")))
									   ("floor" (if (or (float? (lookup 'TYPE (type-of left)))
														(float? (type-of left)))
												  (aloop (list (list 'TOINT (list 'FLOOR (val-of left))) 'int)
														 (cdr lst))
												  (ty-error-expr
													"Attribute Floor works on float values only")))
									   ("float" (if (or (int? (lookup 'TYPE (type-of left)))
														(int? (type-of left)))
												  (aloop (list (list 'TOFLOAT (val-of left)) 'float)
														 (cdr lst))
												  (ty-error-expr
													"Attribute Float works on integer values only")))
									   ("pos" (if (or (enum? (type-of left))
													  (enum? (lookup 'TYPE (type-of left)))
													  (int? (lookup 'TYPE (type-of left)))
													  (int? (type-of left))
													  (bool? (lookup 'TYPE (type-of left)))
													  (bool? (type-of left)))
												(aloop (list (list 'POS (val-of left)) 'int)
													   (cdr lst))
												(ty-error-expr
												  "Attribute Pos works on numeric and enumerator values only")))
									   ("size" (match left
													  ((var 'typ)
													   (aloop (list (list 'SIZE var) 'int)
															  (cdr lst)))
													  (_ (ty-error-expr
														   "Attribute Size works only on Types"))))
									   ("last" (match left
													  ((var 'typ)
													   (if (or (int? (lookup 'TYPE var))
															   (bool? (lookup 'TYPE var))
															   (float? (lookup 'TYPE var))
															   (enum? (lookup 'TYPE var)))
														 (aloop (list (list 'LAST var) var)
																(cdr lst))))
													  (_ (ty-error-expr
														   "Attribute Last works only on Types"))))
									   ("first" (match left
													   ((var 'typ)
														(if (or (int? (lookup 'TYPE var))
																(bool? (lookup 'TYPE var))
																(float? (lookup 'TYPE var))
																(enum? (lookup 'TYPE var)))
														  (aloop (list (list 'FIRST var) var)
																 (cdr lst))))
													   (_ (ty-error-expr
															"Attribute First works only on Types"))))
									   ("length" (match left
														((var 'typ)
														 (if (array? (lookup 'TYPE var))
														   (aloop (list (list 'LENGTH var) 'int)
																  (cdr lst))
														   (ty-error-expr
															 "Attribute Length only works with array types")))
														(_ (ty-error-expr
															 "Attribute Length only works with array types"))))
									   ("Char" (if (or (int? (lookup 'TYPE (type-of left)))
													   (int? (type-of left)))
												 (aloop (list (list 'CHAR (val-of left)) 'string)
														(cdr lst))
												 (ty-error-expr
												   "Attribute Char works on integer values only")))
									   ("len" (if (or (astring? (lookup 'TYPE (type-of left)))
													  (astring? (type-of left)))
												(aloop (list (list 'LEN (val-of left)) 'int)
													   (cdr lst))
												(ty-error-expr
												  "Attribute Len works on string values only")))
									   (_ (ty-error-expr "Invalid Attribute usage"))))
							   ;(())
							   (_ '(error alpha))))))))))
		   ((("(") e (")")) e)
		   ((lit) lit)
		   (_ (list 'error 'alpha))
		   )))
;done
(define do-literal
  (lambda (e)
	(let* ((e ((car e))))
	  (match e
			 (("Int" j e) (list (list j e) 'int))
			 (("Float" i d e) (list (list i d e) 'float))
			 (("true") (list '(1 0) 'bool))
			 (("false") (list '(0 0) 'bool))
			 (("Str" s) (list s 'string))
			 (_ (list 'error 'alpha))
			 ))))

(define do-name-part
  (lambda (lst)
	(match (map myapply lst)
		   (((".") rest) (list 'dot rest))
		   ((("'") agg) (list 'apo agg))
		   ((lst) lst)
		   )))

(define do-agg
  (lambda (lst)
	(match (map myapply lst)
		   ((("Id" l id)) id)
		   (lst lst)
		   )))

(define do-agg-list
  (lambda (lst)
	(match (map myapply lst)
		   ((("(") name to rest (")"))
			(let* ((name (match name
								(((and x (? string?))) x)
								(x x)))
				   (v (match to				; handle range
							((("=>") expr) (list name 'as expr))
							(_ name))))
					 (cons v
						   (let aloop ((lst rest))
							 (if (null? lst)
							   '()
							   (let* ((a (car lst))
									  (b (cadr lst))
									  (c (caddr lst)))
								 (match (list a b c)
										(((",") name (("=>") name2))
										 (cons (list name 'as name2)
											   (aloop (cdddr lst))))
										(((",") name ())
										 (cons name
											   (aloop (cdddr lst))))
										(_ '()))))))))
		   (_ 'void))))

(define do-name-list
  (lambda (lst)
	(match (map myapply lst)
		   ((("others")) 'others)
		   (((v T) range rest)
			(let ((v (match range				; handle range
							((("..") (w S)) (list 'RANGE v w))		;check type compatibility
							(_ (list v T)))))
			  (let aloop ((v v)
						  (lst rest))
				(if (null? lst)
				  v
				  (let* ((e
						   (match
							 (car lst)
							 ((("|") (u T) (("..") (w S))) (list 'RANGE u w))	;check type compatibility
							 ((("|") (u T) ()) (list u T))						;check type compatibility
							 (_ '(void)))))
					(aloop (list 'OR v e) (cdr lst)))))))
		   (_ '(void)))))

(define do-name-rest
  (lambda (lst)
	(match ((car lst))
		   (("Id" l id) (list 'Id id))
		   (("Str" s) (list 'Str s))
		   (("all") 'all)
		   (_ 'void))))
