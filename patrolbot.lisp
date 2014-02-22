; Patrolbot is on patrol and will visit every field
; This guarantees he'll find all the dirt, but he's very inefficient

(defconstant +field-size+ 5)
(defconstant +dirty-cell+ #\d)

(defun read-field () 
  "Reads the field into a list of strings."
  (let ((field nil))
    (dotimes (i +field-size+)
      (setf field (append field (list (read-line)))))
    field))

(defun standing-on-dirt (x y field)
  (eql +dirty-cell+ (elt (elt field y) x)))

(defun on-right-edge (x)
  (eql x (- +field-size+ 1)))

(defun on-left-edge (x)
  (eql x 0))

(defun next-instr (x y field)
  "Determines the next instruction."
  (if (standing-on-dirt x y field)
      "CLEAN"
      (if (evenp y)
	 (if (on-right-edge x)
	     "DOWN"
	     "RIGHT")
	 (if (on-left-edge x)
	     "DOWN"
	     "LEFT"))))

(let ((y (read)) (x (read)) (field (read-field)))
  (format t "~a" (next-instr x y field)))
