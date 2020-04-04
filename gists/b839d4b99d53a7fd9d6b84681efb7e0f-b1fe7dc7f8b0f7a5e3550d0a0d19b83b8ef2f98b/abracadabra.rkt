#lang racket

;; Euler problem 15

(define (reduce f xs)
  (and (not (empty? xs)) (foldl f (first xs) (rest xs))))

(define (f n)
  (reduce (lambda (x y) (* x y)) (range 1 (add1 n))))

(define (sol-015 [n 20])
  (ceiling (/ (f (* n 2)) (f n) (f n))))
