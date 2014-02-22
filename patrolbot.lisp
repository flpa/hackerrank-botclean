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

(defun next-instr (x y field)
  "Determines the next instruction."
  (if (eql +dirty-cell+ (elt (elt field y) x))
      "CLEAN"
      (if (evenp y)
	 (if (eql x (- +field-size+ 1))
	     "DOWN"
	     "RIGHT")
	 (if (eql x 0)
	     "DOWN"
	     "LEFT"))))

(let ((y (read)) (x (read)) (field (read-field)))
  (format t "~a" (next-instr x y field)))
