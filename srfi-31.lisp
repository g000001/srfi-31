;;;; srfi-31.lisp

(cl:in-package :srfi-31.internal)

(def-suite srfi-31)

(in-suite srfi-31)

(defmacro letrec ((&rest binds) &body body)
  `(let (,@(mapcar (cl:lambda (x)
                     `(,(car x) #'values))
             binds))
     (declare (optimize (debug 0) (space 3)))
     (labels (,@(remove nil
                  (mapcar (cl:lambda (x &aux (name (car x)))
                            `(,name
                               (&rest args)
                               (apply ,name args)))
                          binds)))
       (psetq ,@(apply #'append binds))
       ,@body)))

(define-syntax rec
  (syntax-rules ()
    ((rec (NAME . VARIABLES) . BODY)
     (letrec ( (NAME (lambda VARIABLES . BODY)) ) NAME))
    ((rec NAME EXPRESSION)
     (letrec ( (NAME EXPRESSION) ) NAME))))

(test rec-var
  (is (equal (labels ((|funcall . cdr| (x times)
                        (if (>= 1 times)
                            (funcall (cdr x))
                            (funcall (cdr (|funcall . cdr| x (1- times)))) )))
               (let ((x (rec s (cons 1 (lambda () s)))))
                 (list (car x)
                       (car (|funcall . cdr| x 1))
                       (car (|funcall . cdr| x 2))
                       (car (|funcall . cdr| x 3))
                       (car (|funcall . cdr| x 4)) )))
             '(1 1 1 1 1) )))

(test rec-fun
  (is (= (funcall
          (rec (F N)
               (funcall
                (rec (G K L)
                     (if (zerop K) L
                         (G (- K 1) (* K L)) )) N 1))
          10)
         3628800)))

;;; eof