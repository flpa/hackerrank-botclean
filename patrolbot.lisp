; Patrolbot is on patrol and will visit every field
; This guarantees he'll find all the dirt, but he's very inefficient

(defun read-field () 
  "Reads the field into a list of strings."
  (let ((field nil))
    (dotimes (i 5)
      (setf field (append field (list (read-line)))))
    field))

(defun next-instr (x y field)
  "Determines the next instruction."
  (if (eql #\d (elt (elt field y) x))
      "CLEAN"
      (case (mod (+ y 1) 2)
	(1 ; first row, third etc
	 (if (eql x 4)
	     "DOWN"
	     "RIGHT"))
	(0 ; second row, fourth
	 (if (eql x 0)
	     "DOWN"
	     "LEFT")))))

(let ((y (read)) (x (read)) (field (read-field)))
  (format t "~a" (next-instr x y field)))
