;; middle-of-3: num num num -> num
;; to find the 2nd largest number if the numbers were arranged in increasing order
;; eg. (middle-of-3 4 6 5) => 5
;; N.B. this function assumes that no 2 numbers are equal.

(define (middle-of-3 num1 num2 num3)
  (cond
    [(= (max num1 num2) (max num2 num3)) (max num1 num3)] ;; if num2 is max, then middle # is max of num1 and num3     
    [(< (max num1 num2) (max num2 num3)) (max num1 num2)] ;; if the max of the first 2 is less than the max of the last 2 then the middle # is the lesser max 
    [else (max num2 num3)])) ;; otherwise the middle # is the greater max

;; tests
(= 5 (middle-of-3 4 5 6))
(= 5 (middle-of-3 5 4 6))
(= 5 (middle-of-3 4 6 5))
(= 5 (middle-of-3 6 5 4))
(= 5 (middle-of-3 5 6 4))
(= 5 (middle-of-3 6 4 5))