;;;; srfi-31.asd

(cl:in-package :asdf)

(defsystem :srfi-31
  :serial t
  :depends-on (:mbe :fiveam)
  :components ((:file "package")
               (:file "srfi-31")))

(defmethod perform ((o test-op) (c (eql (find-system :srfi-31))))
  (load-system :srfi-31)
  (or (flet ((_ (pkg sym)
               (intern (symbol-name sym) (find-package pkg))))
         (let ((result (funcall (_ :fiveam :run) (_ :srfi-31.internal :srfi-31))))
           (funcall (_ :fiveam :explain!) result)
           (funcall (_ :fiveam :results-status) result)))
      (error "test-op failed") ))

