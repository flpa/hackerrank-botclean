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
	(unless *instructions* (build-instructions x y field))
	(pop-instruction))))

(defun build-instructions (x y field)
  (loop for option in (permutate (find-dirt-locations field))
     do (setf option (append `((,x ,y)) option)) ; path from robot
     when (or
	   (not *instructions*) ; not set
	   (< (path-length option) (path-length *instructions*))) ; shorter
     do (setf *instructions*  option)))

; TODO actually this is wrong, path length is instruction count, we need a
; function for creating instructions for coordinates
(defun path-length (coordinates)
  )

(defun find-dirt-locations (field)
  "Returns a list of all dirt coordinates in field. Coordinates are
   represented by two-element lists in format (x y), e.g. (0 1)"
  (loop for i from 0 below (* +field-size+ +field-size+)
     for x = (mod i +field-size+)
     for y = (floor i +field-size+)
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

