;;;; github-osx-notifications.lisp

(in-package #:github-osx-notifications)

(require "cocoa")

;;; "github-osx-notifications" goes here. Hacks and glory await!

(defparameter *events-endpoint* "/users/:user/received_events")
(defparameter *latest* (local-time:now))
(defparameter *scheduler* nil)
(defparameter *period* 120)

(defun ns-string (string)
  (ccl::%make-nsstring string))

(defun osx-notification (title text)
  (let ((notification (make-instance 'ns:ns-user-notification))
	(center (#/defaultUserNotificationCenter ns:ns-user-notification-center)))
    (#/setTitle: notification title)
    (#/setInformativeText: notification text)
    (#/deliverNotification: center notification)))

(defun check-latest (created-at)
  (let ((timestamp (local-time:parse-timestring created-at)))
    (when (local-time:timestamp> timestamp *latest*)
      (setf *latest* timestamp))))

(defun github-event ()
  (let* ((event (first (cl-github:api-command *events-endpoint* :method :get)))
	 (type (getf event :type))
	 (login (getf (getf event :actor) :login))
	 (repo (getf (getf event :repo) :url))
	 (created-at (getf event :created-at)))
    (when (check-latest created-at)
      (osx-notification 
       (ns-string (format nil "~A : ~A" login type))
       (ns-string (format nil "~A at ~A" repo created-at))))))

(defun start ()
  (setf *scheduler*
	(ccl:process-run-function "scheduler"
				  #'(lambda ()
				      (loop
				       (github-event)
				       (sleep *period*))))))

(defun stop ()
  (ccl:process-kill *scheduler*))
