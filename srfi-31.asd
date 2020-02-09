;;;; srfi-31.asd

(cl:in-package :asdf)


(defsystem :srfi-31
  :version "20200209"
  :description "SRFI 31 CL: A special form `rec' for recursive evaluation"
  :long-description "SRFI 31 CL: A special form `rec' for recursive evaluation
https://srfi.schemers.org/srfi-31"
  :author "Mirko.Luedde@Computer.Org"
  :maintainer "CHIBA Masaomi"
  :license "Unlicense"
  :serial t
  :depends-on (:mbe :fiveam)
  :components ((:file "package")
               (:file "srfi-31")))


(defmethod perform :after ((o load-op) (c (eql (find-system :srfi-31))))
  (let ((name "https://github.com/g000001/srfi-31")
        (nickname :srfi-31))
    (if (and (find-package nickname)
             (not (eq (find-package nickname)
                      (find-package name))))
        (warn "~A: A package with name ~A already exists." name nickname)
        (rename-package name name `(,nickname)))))


(defmethod perform ((o test-op) (c (eql (find-system :srfi-31))))
  (let ((*package*
         (find-package
          "https://github.com/g000001/srfi-31#internals")))
    (eval
     (read-from-string
      "
      (or (let ((result (run 'srfi-31)))
            (explain! result)
            (results-status result))
          (error \"test-op failed\") )"))))


;;; *EOF*
