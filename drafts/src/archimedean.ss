;; Archiemdean computation of π (using streams)
;; Abstraction in numerical methods, Halfant & Sussman, 1988.
;;
;; Note:
;; The implementation of streams is provided in the SICP;
;; the SRFI 40/41 uses different names for the proc belows
;; (e.g., stream-cons instead of cons-stream).

(define (refine-by-doubling s)
  (/ s (sqrt (- 4 (* s s)))))

(define (stream-of-iterates next value)
  (cons-stream value
               (stream-of-iterates next (next value))))

(define side-lengths
  (stream-of-iterates refine-by-doubling (sqrt 2)))

(define side-numbers
  (stream-of-iterates (lambda (n) (* 2 n)) 4))

(define (semi-perimeter length-of-side number-of-sides)
  (* (/ number-of-sides 2) length-of-side))

(define archimedean-pi-sequence
  (map-streams semi-perimeter side-lengths side-numbers))

(print-stream archimedean-pi-sequence)
