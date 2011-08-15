;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;
;; PARTs B and D
;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define make-abs (lambda (var expr) `(fun ,var ,expr)))
(define make-app (lambda (rator rand) `(,rator ,rand)))
(define make-if (lambda (E1 E2 E3) `(if ,E1 ,E2 ,E3)))
(define make-fix (lambda (x E) `(fix ,x ,E)))
(define make-let (lambda (x E1 E2) `(let ,x ,E1 ,E2)))
(define make-type-var (lambda (alpha) `(,alpha)))
(define make-fxn-type (lambda (head tail) `(-> ,head ,tail)))

(define abs?
  (lambda (expr) 
    (and (list? expr) (= (length expr) 3) (eq? 'fun (car expr)))))

(define app? 
  (lambda (expr)
    (and (list? expr) (= (length expr) 2))))

(define var? symbol?)

(define if?
  (lambda (expr)
    (and (list? expr) (= (length expr) 4) (eq? 'if (car expr)))))

(define fix?
  (lambda (expr)
    (and (list? expr) (= (length expr) 3) (eq? 'fix (car expr)))))

(define let?
  (lambda (expr)
    (and (list? expr) (= (length expr) 3) (eq? 'let (car expr)))))

(define letex?
  (lambda (expr)
    (and (list? expr) (= (length expr) 3) (eq? 'letex (car expr)))))

(define raise?
  (lambda (expr)
    (and (list? expr) (= (length expr) 2) (eq? 'raise (car expr)))))

(define handle?
  (lambda (expr)
    (and (list? expr) (= (length expr) 4) (eq? 'handle (car expr)))))

;; prim-type ::= <bool> | <number>
(define prim-type?
  (lambda (t)
    (or (equal? 'bool t) (equal? 'int t) (equal? 'exception t))))

;; type-var ::= "a"
(define type-var?
  (lambda (alpha)
    (string? alpha)))

;; fxn-type ::= '(-> <mono-type> <mono-type>)
(define fxn-type?
  (lambda (tau)
    (and (list? tau)
         (= 3 (length tau))
         (equal? '-> (car tau))
         (mono-type? (cadr tau))
         (mono-type? (caddr tau)))))

;; mono-type ::= prim-type | type-var | fxn-type
(define mono-type?
  (lambda (tau)
    (or (prim-type? tau)
        (type-var? tau)
        (fxn-type? tau))))

;; poly-type ::= mono-type | '(forall <type-var> <poly-type>)
(define poly-type?
  (lambda (tau)
    (or (mono-type? tau)
        (and (list? tau)
             (= 3 (length tau))
             (equal? 'forall (car tau))
             (type-var? (cadr tau))
             (poly-type? (caddr tau))))))

(define var-of cadr)
(define body-of caddr)

(define rator-of car)
(define rand-of cadr)

(define head-of cadr)
(define tail-of caddr)

(define (foldl f i L)
  (if (null? L)
      i
      (foldl f (f (car L) i) (cdr L))))

(define in-list?
  (lambda (x lst)
    (foldl (lambda (n i) (or i (equal? n x))) #f lst)))

(define (foldr f i L)
  (if (null? L)
      i
      (f (car L) (foldr f i (cdr L)))))

;; using t[1,2,3,...] as the "new" variables
(define myvar "t")
(define counter 0)

;; returns a new type-var
(define new-typevar
  (lambda ()
    (set! counter (+ counter 1))
    (string-append myvar (number->string counter))))

(define error
  (lambda (name)
    (display
      (string-append "Error[" (symbol->string name) "]: Fatal error occured. Exiting\n"))
    '()))

(define emptyenv '())

(define initenv
  '((add (-> int (-> int int)))
    (neg (-> int int))
    (mult (-> int (-> int int)))
    (div (-> int (-> int int)))
    (and (-> bool (-> bool bool)))
    (or (-> bool (-> bool bool)))
    (not (-> bool bool))
    (eq (-> int (-> int bool)))
    (lt (-> int (-> int bool)))
    (gt (-> int (-> int bool)))
    (raise (forall "taxicab" (-> exception "taxicab")))))

(define s1
  (lambda (rule expr)
    (if (null? rule)
        expr
        (let* ((tau (car rule)) (alpha (cadr rule)))
          (cond
            ((null? tau) expr) ;; empty substitution
            ((type-var? expr) (if (equal? expr alpha)
                                  tau
                                  expr))
            ((prim-type? expr) expr)
            ((fxn-type? expr) (make-fxn-type (s1 rule (head-of expr))
                                             (s1 rule (tail-of expr))))
            ((poly-type? expr) (list (car expr) (cadr expr) (s1 rule (caddr expr))))
            (else (error 's1)))))))

(define type-subst
  (lambda (composition expr)
    (foldr (lambda (x i) (s1 x i)) expr composition)))

(define env-subst
  (lambda (composition A)
    (map (lambda (x) (list (car x) (type-subst composition (cadr x)))) A)))

(define unify
  (lambda (tau1 tau2)
    (cond
      ((and (prim-type? tau1) (prim-type? tau2))
       (if (equal? tau1 tau2)
           '()
           (error 'unify)))
      ((and (prim-type? tau1) (fxn-type? tau2)) "Error2: No unifier exists")
      ((and (fxn-type? tau1) (fxn-type? tau2))
       (let* ((S1 (unify (head-of tau1) (head-of tau2)))
              (S2 (unify (type-subst `(,@S1) (tail-of tau1))
                         (type-subst `(,@S1) (tail-of tau2)))))
         `(,@S2 ,@S1)))
      ((and (type-var? tau1) (mono-type? tau2))
       (if (equal? tau1 tau2)
           '()
           (if (occurs? tau1 tau2)
               (error 'unify)
               `((,tau2 ,tau1)))))
      ((and (mono-type? tau1) (type-var? tau2))
       (if (equal? tau1 tau2)
           '()
           (if (occurs? tau2 tau1)
               (error 'unify)
               `((,tau1 ,tau2)))))
      (else (error 'unify)))))

(define occurs?
  (lambda (alpha tau)
    (cond
      ((prim-type? tau) #f)
      ((type-var? tau) #f)
      ((fxn-type? tau) (or (occurs? alpha (head-of tau)) (occurs? alpha (body-of tau))))
      (else (error 'occurs?)))))

(define W
  (lambda (expr A)
    (cond
      ((app? expr)
       (let* ((tmp1 (W (rator-of expr) A))
              (S1 (car tmp1))
              (tau1 (cadr tmp1))
              (tmp2 (W (rand-of expr) (env-subst S1 A)))
              (S2 (car tmp2))
              (tau2 (cadr tmp2))
              (newvar (new-typevar))
              (S3 (unify (type-subst S2 tau1) `(-> ,tau2 ,newvar))))
         `((,@S3 ,@S2 ,@S1) ,(type-subst S3 newvar))))
      ((if? expr)
       (let* ((E1 (cadr expr))
              (E2 (caddr expr))
              (E3 (cadddr expr))
              (tmp1 (W E1 A))
              (S1 (car tmp1))
              (tau1 (cadr tmp1))
              (S2 (unify 'bool tau1))
              (tmp2 (W E2 (env-subst `(,@S2 ,@S1) A)))
              (S3 (car tmp2))
              (tau3 (cadr tmp2))
              (tmp4 (W E3 (env-subst `(,@S3 ,@S2 ,@S1) A)))
              (S4 (car tmp4))
              (tau4 (cadr tmp4))
              (S5 (unify (type-subst S4 tau3) tau4)))
         `((,@S5 ,@S4 ,@S3 ,@S2 ,@S1) ,(type-subst S5 tau4))))
      ((let? expr)
       (let* ((E1 (cadadr expr))
              (E2 (caddr expr))
              (tmp1 (W E1 A))
              (S1 (car tmp1))
              (tau1 (cadr tmp1))
              (tau1_prime (quantify tau1 (env-subst S1 A)))
              (tmp2 (W E2 (env-subst S1 (append A `((,(caadr expr) ,tau1_prime))))))
              (S2 (car tmp2))
              (tau2 (cadr tmp2)))
         `((,@S2 ,@S1) ,tau2)))
      ((letex? expr)
       (let* ((var (cadr expr))
              (E (caddr expr))
              (tmp1 (W E (append A `((,var exception)))))
              (S1 (car tmp1))
              (tau1 (cadr tmp1)))
         `((,@S1) ,tau1)))
      ((handle? expr)
       (let* ((E1 (cadr expr))
              (E2 (caddr expr))
              (E3 (cadddr expr))
              (tmp1 (W E1 A))
              (S1 (car tmp1))
              (tau1 (cadr tmp1))
              (S2 (unify 'exception tau1))
              (tmp3 (W E2 (env-subst `(,@S2 ,@S1) A)))
              (S3 (car tmp3))
              (tau3 (cadr tmp3))
              (tmp4 (W E3 (env-subst `(,@S3 ,@S2 ,@S1) A)))
              (S4 (car tmp4))
              (tau4 (cadr tmp4))
              (S5 (unify (type-subst S4 tau3) tau4)))
         `((,@S5 ,@S4 ,@S3 ,@S2 ,@S1) ,(type-subst S5 tau4))))
      ((var? expr) `(() ,(lookup expr A)))
      ((abs? expr)
       (let* ((newvar (new-typevar))
              (tmp (W (body-of expr) (append `((,(var-of expr) ,newvar)) A)))
              (S (car tmp))
              (tau (cadr tmp)))
         `(,S (-> ,(type-subst S newvar) ,tau))))

      ((fix? expr)
       (let* ((E (caddr expr))
              (newvar (new-typevar))
              (tmp1 (W E (append A `((,(cadr expr) ,newvar)))))
              (S1 (car tmp1))
              (tau1 (cadr tmp1))
              (S2 (unify (type-subst S1 newvar) tau1)))
         `((,@S2 ,@S1) ,(type-subst S2 tau1))))
      ((integer? expr) `(() int))
      ((boolean? expr) `(() bool))
      (else (error 'W)))))

(define lookup
  (lambda (var A)
    (cond
      ((number? var) 'int)
      ((boolean? var) 'bool)
      ((assq var A) (strip (cadr (assq var A))))
      (else (error 'lookup)))))

(define quantify
  (lambda (tau A)
    (cond
      ((prim-type? tau) tau)
      ((type-var? tau) `(forall ,tau ,tau))
      ((fxn-type? tau) (foldl (lambda (x i) (list 'forall x i)) tau (get-typevars tau '() A)))
      (else (error 'quantify)))))

(define get-typevars
  (lambda (tau i A)
    (cond
      ((prim-type? tau) i)
      ((type-var? tau) (if (or (in-list? tau i) (assq tau A)) i (cons tau i)))
      ((fxn-type? tau) (get-typevars (tail-of tau) (get-typevars (head-of tau) i A) A))
      ((poly-type? tau) (get-typevars (caddr tau) i A))
      (else (error 'get-typevars)))))

(define strip
  (lambda (tau)
    (cond
      ((prim-type? tau) tau)
      ((type-var? tau) tau)
      ((fxn-type? tau) tau)
      ((poly-type? tau) (type-subst `((,(new-typevar) ,(cadr tau))) (strip (caddr tau)))))))

;(equal? (type-subst '((int "alpha")) "alpha") 'int)
;(equal? (type-subst '(("gamma" "beta") ("beta" "alpha")) "alpha") "gamma")
;(equal? (type-subst '((int "beta")) '(-> "alpha" (-> "beta" "alpha")))
;        '(-> "alpha" (-> int "alpha")))
;(equal? (type-subst '((int "alpha") (int "beta"))
;                    '(-> "alpha" (-> "beta" "alpha"))) '(-> int (-> int int)))
;(let ((S (unify '(-> "alpha" (-> "beta" "alpha")) '(-> "alpha" (-> int "alpha")))))
;  (equal? (type-subst S '(-> "alpha" (-> "beta" "alpha")))
;          (type-subst S '(-> "alpha" (-> int "alpha")))))
;(let ((S (unify '(-> "a" "b") '(-> "b" int))))
;  (equal? (type-subst S '(-> "a" "b"))
;          (type-subst S '(-> "b" int))))
;
;(define e1 '(fun f (fun g (fun x (f (g x))))))
;(define e2 '(let (f (fun x x)) (if (f #t) (f 1) 0)))
(define e3 '(fix s (fun x (fun y (if ((eq 0) x) y ((s ((add 1) x)) ((add -1) y)))))))
(define e4 '(letex divzero 
                   (let 
                       (safediv 
                        (fun x 
                             (fun y
                                  (if ((eq y) 0)
                                      (raise divzero)
                                      ((div x) y)))))
                     ((add (handle divzero ((safediv 8) 4) 0))
                           (handle divzero ((safediv 3) 0) 0)))))

;(define e1 '(let (id (fun x x)) (let (foo (fix s (fun x (if (id ((eq 0) x)) (id 0) (s ((add -1) x)))))) (foo 5))))
