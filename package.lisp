;;;; package.lisp

(cl:in-package cl-user)

(defpackage "https://github.com/g000001/srfi-31"
  (:use)
  (:export rec)
  (:size 1))

(defpackage "https://github.com/g000001/srfi-31#internals"
  (:use "https://github.com/g000001/srfi-31"
        cl
        fiveam
        mbe))

