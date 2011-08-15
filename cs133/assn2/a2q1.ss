(start 500 300)
(define width 200)
(define height 150)
(define top-left (make-posn 100 60))
(draw-solid-rect top-left width height 'blue)

;; draw-dot: posn symbol -> "dot"
;; to draw a colored dot on the screen
(define (draw-dot dot-pos color)
  (draw-solid-line dot-pos dot-pos color)) ;; draws a "line" 1 pixel long so simulate drawing a dot

;; testing "draw-dot" using (wait-for-mouse-click)
;; (draw-dot (wait-for-mouse-click) 'red)
 
;; green-in-box-else-red: posn num num posn -> "dot"
;; draws a small green dot centred at the position represented by the 2nd posn if it is within the rectangle, and a red dot otherwise
;; eg. (green-in-box-else-red top-left width height (1 1) => "red dot"
;; (green-in-box-else-red top-left width height (110 70) => "green dot"
(define (green-in-box-else-red top-left width height dot-pos)
  (cond
    [(and
      (and (<= (posn-x top-left) (posn-x dot-pos))
           (<= (posn-x dot-pos) (+ (posn-x top-left) width)))
      
      (and (<= (posn-y top-left) (posn-y dot-pos))
           (<= (posn-y dot-pos) (+ (posn-y top-left) height)))) (draw-dot dot-pos 'green)]
    
    [else (draw-dot dot-pos 'red)]))

;; tests
(green-in-box-else-red top-left width height (wait-for-mouse-click))
(green-in-box-else-red top-left width height (wait-for-mouse-click))
(green-in-box-else-red top-left width height (wait-for-mouse-click))