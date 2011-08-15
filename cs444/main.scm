(load "parser.scm")
(load "py-gen.scm")

(require (lib "pretty.ss"))

(define help
  (lambda ()
	(display "Usage: nyac [OPTIONS] files...\n")
	(display "Options are:\n")
	(display "\t-p Evaluate parser and output parse tree\n")
	(display "\t-t Typecheck parse tree, display types of expressions, do not compile\n")
	(display "\t-s Show scope information\n")
	(display "\t-sy Print Symbol Table\n")
	(display "\t-i Display Intermediate Representation\n")
	(display "\t-h Display this help\n")
	(exit)))

(define *scope* #f)
(define *parser* #f)
(define *types* #f)
(define *symbol* #f)
(define *inter* #f)

(define *trees* '())

(do ((i 0 (+ i 1)))
  ((= i (vector-length argv)))
  (cond
	((equal? (vector-ref argv i) "-p") (set! *parser* #t))
	((equal? (vector-ref argv i) "-t") (set! *types* #t))
	((equal? (vector-ref argv i) "-s") (set! *scope* #t))
	((equal? (vector-ref argv i) "-sy") (set! *symbol* #t))
	((equal? (vector-ref argv i) "-i") (set! *inter* #t))
	((equal? (vector-ref argv i) "-h") (help))
	(else
	  (set! *trees*
		(append *trees*
				(with-input-from-file (vector-ref argv i)
									  parser))))))

(if (null? *trees*)
  (begin
	(display "nyac: No input files\n")
	(newline)
	(help)))

;(if (or error terror) (exit 1))
(if (or error terror)
  (begin
    (display "\n------\nCompilation error\n------\n")
    (exit)))
(unless main-defined
  (begin
	(ty-error 0 0 'void "Package `MAIN' must be defined")
	(exit))
  (if prev-class
	(ty-error-stmt "Package `" prev-class "' has no body defined.")))

(newline)
(newline)
(if *inter* (pretty-print *trees*))

(define generate-code
  (lambda ()
    (begin
      (code #f "#!/usr/bin/env python\n")
      (prepare-py)
      (for-each py-gen *trees*)
      (code #f "main()\n"))))

(with-output-to-file "a.out" generate-code)

(exit 0)
