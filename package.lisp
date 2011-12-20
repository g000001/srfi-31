;;;; package.lisp

(cl:in-package :cl-user)

(defpackage :srfi-31
  (:use)
  (:export :rec))

(defpackage :srfi-31.internal
  (:use :srfi-31 :cl :fiveam :mbe))

