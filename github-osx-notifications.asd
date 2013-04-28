;;;; github-osx-notifications.asd

(asdf:defsystem #:github-osx-notifications
  :serial t
  :description "Github + OS X Notifications + Common Lisp"
  :author "Jose Pereira <jsmpereira@gmail.com>"
  :license "Specify license here"
  :depends-on (#:cl-github-v3
	       #:local-time)
  :components ((:file "package")
               (:file "github-osx-notifications")))

