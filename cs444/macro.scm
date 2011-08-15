(define-syntax unless
  (syntax-rules ()
				((unless test stmt1 stmt2)
				 (if (not test)
				   stmt1
				   stmt2))))
