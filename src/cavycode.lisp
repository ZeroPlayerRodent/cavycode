(defvar code)

(defun split-string (foo) ; Function that tokenizes a string of CavyCode code.
  (let ((i 0) (s "") (l (list 1)))
    (loop
      (loop
        (when (>= i (length foo))(return))
        (when (equal #\" (char foo i))
          (loop
            (setf i (+ i 1))
            (when (equal #\" (char foo i))(return))
            (setf s (concatenate 'string s (string (char foo i))))
          )
          (return)
        )
        (when (equal #\| (char foo i))
          (loop
            (setf i (+ i 1))
            (when (equal #\| (char foo i))(return))
          )
          (return)
        )
        (when (equal #\Space (char foo i))(return))
        (when (equal #\Newline (char foo i))(return))
        (when (equal #\Tab (char foo i))(return))
        (setf s (concatenate 'string s (string (char-upcase (char foo i)))))
        (setf i (+ i 1))
      )
      (when (> (length s) 0)(push s (cdr (last l))))
      (setf s "")
      (setf i (+ i 1))
      (when (>= i (length foo))(return))
    )
    (pop l)
    l
  )
)

(defun parse-float (foo) ; Function that parses floats from strings
  (let ((str "")(counting 0)(count 0))
    (loop for c across foo
      do (when (= counting 1) (setf count (+ count 1)))
      do (when (not (equal c #\.)) (setf str (concatenate 'string str (list c))))
      do (when (equal c #\.) (setf counting 1))
    )
    (if (= counting 1)
      (coerce (* (parse-integer str) (expt 10 (- count))) 'double-float)
      (parse-integer str)
    )
  )
)

(defvar pf-variable ; Variable that stores parse-float function
  (quote
    (defun parse-float (foo)
      (let ((str "")(counting 0)(count 0))
        (loop for c across foo
          do (when (= counting 1) (setf count (+ count 1)))
          do (when (not (equal c #\.)) (setf str (concatenate 'string str (list c))))
          do (when (equal c #\.) (setf counting 1))
        )
        (if (= counting 1)
          (coerce (* (parse-integer str) (expt 10 (- count))) 'double-float)
          (parse-integer str)
        )
      )
    )
  )
)

(defun is-symbol (foo) ; Function that determines if an element of code is a keyword.
  (cond ((string= "TUNNEL" foo)'(elt (queue) 0))
        ((string= "BOWL" foo)'acc)
        ((string= "BEG-INT" foo)'(parse-integer (read-line t)))
        ((string= "BEG-FLOAT" foo)'(parse-float (read-line t)))
        ((string= "BEG-CHAR" foo)'(char-code (read-char t nil (code-char 0))))
        (t (parse-float foo))
  )
)

(defun compile-list (foo) ; Function that takes a list of CavyCode commands, and returns a list of equivalent Lisp commands.
  (let ((i 0) (l (list 1)))
    (loop
      (when (>= i (length foo))(return))
      (cond ((string= "WHEEK-INT" (elt foo i))
            (push `(format t "~d" ,(is-symbol (elt foo (+ i 1)))) (cdr (last l))))
            
            ((string= "WHEEK-FLOAT" (elt foo i))
            (push `(format t "~,f" ,(is-symbol (elt foo (+ i 1)))) (cdr (last l))))
            
            ((string= "WHEEK-CHAR" (elt foo i))
            (push `(format t "~c" (code-char ,(is-symbol (elt foo (+ i 1))))) (cdr (last l))))
            
            ((string= "WHEEK-STRING" (elt foo i))
            (progn(push `(format t ,(elt foo (+ i 1))) (cdr (last l))) (setf i (+ i 1))))
            
            ((string= "WHEEK-LOUD" (elt foo i))
            (push '(print (queue)) (cdr (last l))))
            
            ((string= "WHEEK-LOUDER" (elt foo i))
            (push '(print ql) (cdr (last l))))
            
            ((string= "EAT-PELLET" (elt foo i))
            (push `(nconc (queue) (list ,(is-symbol (elt foo (+ i 1))))) (cdr (last l))))
            
            ((string= "EAT-HAY" (elt foo i))
            (push `(setf (elt (queue) 0) (+ (elt (queue) 0) ,(is-symbol (elt foo (+ i 1))))) (cdr (last l))))
            
            ((string= "EAT-LETTUCE" (elt foo i))
            (push `(setf acc ,(is-symbol (elt foo (+ i 1)))) (cdr (last l))))
            
            ((string= "EAT-TOMATO" (elt foo i))
            (push `(setf (elt (queue) 0) (* (elt (queue) 0) ,(is-symbol (elt foo (+ i 1))))) (cdr (last l))))

            ((string= "EAT-CARROT" (elt foo i))
            (push `(setf (elt (queue) 0) (expt (elt (queue) 0) ,(is-symbol (elt foo (+ i 1))))) (cdr (last l))))
            
            ((string= "POOP" (elt foo i))
            (push '(pop (queue)) (cdr (last l))))
            
            ((string= "RUMBLE-STRUT" (elt foo i))
            (push `(progn (setf (elt ql ,(is-symbol (elt foo (+ i 1)))) nil) (setf ql (remove nil ql)) (setf qi 0)) (cdr (last l))))
            
            ((string= "CHATTER" (elt foo i))
            (push `(setf (elt (queue) 0) (- (elt (queue) 0) ,(is-symbol (elt foo (+ i 1))))) (cdr (last l))))
            
            ((string= "CHATTER-LOUD" (elt foo i))
            (push `(setf (elt (queue) 0) (coerce (/ (elt (queue) 0) ,(is-symbol (elt foo (+ i 1)))) 'double-float)) (cdr (last l))))
            
            ((string= "TRIM-NAILS" (elt foo i))
            (push '(setf (elt (queue) 0) (truncate (elt (queue) 0))) (cdr (last l))))
            
            ((string= "FORAGE-FOOD" (elt foo i))
            (push `(nconc (queue) (list (random ,(is-symbol (elt foo (+ i 1))) (make-random-state t)))) (cdr (last l))))
            
            ((string= "GROOM-SELF" (elt foo i))
            (push '(setf (queue) (reverse (queue))) (cdr (last l))))
            
            ((string= "NEW-TUNNEL" (elt foo i))
            (push '(nconc ql (list (list 0))) (cdr (last l))))
            
            ((string= "BURROW-IN" (elt foo i))
            (push `(setf qi ,(is-symbol (elt foo (+ i 1)))) (cdr (last l))))
            
            ((string= "POPCORN-IF" (elt foo i))
            (push `(when (= (elt (queue) 0) ,(is-symbol(elt foo (+ i 1))))(setf i (+ i 1))) (cdr (last l))))

            ((string= "POPCORN-BELOW" (elt foo i))
            (push `(when (< (elt (queue) 0) ,(is-symbol(elt foo (+ i 1))))(setf i (+ i 1))) (cdr (last l))))
            
            ((string= "POPCORN-ABOVE" (elt foo i))
            (push `(when (> (elt (queue) 0) ,(is-symbol(elt foo (+ i 1))))(setf i (+ i 1))) (cdr (last l))))
            
            ((string= "POPCORN-NOT" (elt foo i))
            (push `(unless (= (elt (queue) 0) ,(is-symbol(elt foo (+ i 1))))(setf i (+ i 1))) (cdr (last l))))
            
            ((string= "MARK-TERRITORY" (elt foo i))
            (push (is-symbol(elt foo (+ i 1))) (cdr (last l))))
            
            ((string= "ZOOMIES-TO" (elt foo i))
            (push `(setf i (position ,(is-symbol(elt foo (+ i 1))) code :test #'equal)) (cdr (last l))))
      )
      (setf i (+ i 1))
    )
    (pop l)
    l
  )
)

(defun get-file-contents (filename) ; Function that gets contents of a file as a string
  (with-open-file (stream filename)
    (let ((contents (make-string (file-length stream))))
      (read-sequence contents stream)
      contents)
    )
)

(defun cavy-i (foo) ; Function that interprets a CavyCode program.
  (defvar ACC 0)
  (defvar QI 0)
  (defmacro QUEUE () '(elt QL QI))
  (defvar QL (list '(0)))
  (setf code (compile-list (split-string (get-file-contents foo))))
  (progn
    (defvar i 0)
    (loop
      (when(>= i (length code))(return))
      (when(equal (queue) '())(return))
      (eval (elt code i))
      (setf i (+ i 1))
    )
  )
)

(defun cavy-c (foo) ; Function that compiles a CavyCode program to Lisp.
  (setf code (compile-list (split-string (get-file-contents foo))))
  (with-open-file (str "a.lisp"
                       :direction :output
                       :if-exists :supersede
                       :if-does-not-exist :create)
    (format str "~s~C" pf-variable #\Return)
    (format str "(DEFVAR ACC 0)~C" #\Return)
    (format str "(DEFVAR QI 0)~C" #\Return)
    (format str "(DEFMACRO QUEUE () '(ELT QL QI))~C" #\Return)
    (format str "(DEFVAR QL (LIST '(0)))~C" #\Return)
    (format str "(DEFVAR CODE (LIST~C" #\Return)
    (let ((i 0))
      (loop
        (when (>= i (length code))(return))
        (format str "(QUOTE ")
        (format str "~s" (elt code i))
        (format str ")~C" #\Return)
        (setf i (+ i 1))
      )
    )
    (format str "))")
    (format str "~s" '(progn
    (defvar i 0)
    (loop
      (when(>= i (length code))(return))
      (when(equal (queue) '())(return))
      (eval (elt code i))
      (setf i (+ i 1))
    )
    ))
  )
  (format t "Successfully compiled to a.lisp")
)
 
