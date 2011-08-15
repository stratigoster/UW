;; make-address-book :  ->  address-book
;; to create a function that manages all the services for a hidden address book
(define (make-address-book title)
  (local ((define-struct entry (name number))
          ;; address-book : (listof entry)
          ;; to maintain a list of name-phone number associations
          (define address-book empty)
          
          ;; add-to-address-book : symbol number -> void
          ;; effect: to add a name-phone number association to address-book
          (define (add-to-address-book name phone)
            (cond
              [(ormap (lambda (x) (equal? (entry-name x) name)) address-book) false]
              [else (set! address-book (cons (make-entry name phone) address-book))]))
          
          ;; lookup : symbol (listof entry)  ->  number or false
          ;; to lookup the phone number for name in address-book
          (define (lookup name ab)
            (cond
              [(empty? ab) false]
              [else (cond
                      [(symbol=? (entry-name (first ab)) name)
                       (entry-number (first ab))]
                      [else (lookup name (rest ab))])]))
          
          ;; delete : symbol address-book -> boolean
          ;; to delete a name-phone number association from the address-book
          (define (remove name ab acc)
            (cond
              [(empty? (rest acc)) false]
              [else
               (cond
                 [(equal? (entry-name (second acc)) name) (begin (set-rest! acc (rest (rest acc))) true)]
                 [else (remove name ab (rest acc))])]))
          
          ;; service-manager : address-book object
          ;; to manage addition to, and searches in, the address book 
          (define (service-manager msg)
            (cond
              [(symbol=? msg 'add)
               add-to-address-book]
              [(symbol=? msg 'search)
               (lambda (name)
                 (lookup name address-book))]
              [(symbol=? msg 'remove)
               (lambda (name)
                 (cond
                   [(empty? address-book) false]
                   [(equal? (entry-name (first address-book)) name)
                      (begin
                        (set-first! address-book (rest address-book))
                        (set-rest! address-book empty)
                        (set! address-book (first address-book))
                        true)]
                   [(empty? (rest address-book)) false]
                   [else (remove name address-book address-book)]))]
              [else (error 'address-book "message not understood")])))
    service-manager))


;; tests
(define home (make-address-book empty))
((home 'add) 'Mark 9876)
((home 'add) 'Mom 123)

(equal? ((home 'search) 'Mom) 123)
(equal? ((home 'remove) 'Mom) true)

(equal? ((home 'search) 'Mom) false)
(equal? ((home 'add) 'Mark 777) false)

(equal? ((home 'search) 'Mark) 9876)
(equal? ((home 'remove) 'Mark) true)
((home 'add) 'Mark 9001)
(equal? ((home 'search) 'Mark) 9001)

((home 'add) 'Kate 543)
(equal? ((home 'search) 'Kate) 543)
(equal? ((home 'add) 'Kate 222) false)