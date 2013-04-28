;;;; package.lisp

(defpackage #:github-osx-notifications
  (:use #:cl)
  (:export #:start
	   #:stop
	   #:*events-endpoint*
	   #:*period*))

