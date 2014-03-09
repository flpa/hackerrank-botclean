; Pathfinder is a searching agent with minor reflexive behavior:
; - if standing on dirt, always clean (reflex)
; - if no instruction list is available, build one
; -- create list of dirt locations (represented by two-element lists)
; -- create permutations
; -- for each permutation, generate instruction list, minimizing the path length
; -- the winning instruction list is our instruction list
; - pop the next instruction from the list


(defun permutate (list)
  (if (null list) '(())
  (mapcan #'(lambda (x)
    (mapcar #'(lambda (y) (cons x y))
      (permutate (remove x list :count 1)))) list)))

(defconstant +field-size+ 5)
(defconstant +dirty-cell+ #\d)
(defparameter *instructions* nil)

(defun read-field () 
  "Reads the field into a list of strings."
  (loop repeat +field-size+ collecting (read-line)))

(defun standing-on-dirt (x y field)
  (eql +dirty-cell+ (elt (elt field y) x)))

(defun next-instr (x y field)
  "Determines the next instruction."
  (if (standing-on-dirt x y field)
      "CLEAN"
      (progn
	(unless *instructions* (build-instructions))
	(pop-instruction))))

(defun build-instructions ()
  )

(defun find-dirt-locations (field)
  (loop repeat (* +field-size+ +field-size+)
     for x = 0 then
       (if (eql (- +field-size+ 1) x)
	   0
	   (+ 1 x)) 
     and y = 0 then (floor x +field-size+)
     if (standing-on-dirt x y field) collect (list x y)))

(defun pop-instruction()
  (let ((instr (first *instructions*)))
    (setf *instructions* (rest *instructions*))
    instr))
    
; ----------------
; Actual execution
; ----------------
(let ((y (read)) (x (read)) (field (read-field)))
  (format t "~a" (next-instr x y field)))

