## Github + OS X Notifications + Common Lisp

The other day I noticed that one thing I'm constantly doing is refreshing my Github page
to see if anything new is up.

I thought, wouldn't it be cool to have notifications for my news feed?

A simple call to the Events API, retrieve some basic attributes to get an idea of what the update is
about and a timer.

```lisp
(setf *events-endpoint* "/users/:user/received_events")
(setf *period* 120)
(start)
``` 

### Depends on:

* [Clozure Common Lisp](http://ccl.clozure.com/) for its Objective-C bridge, v1.9 for OS X 10.8 interfaces, namely NSUserNotification
* [cl-github-v3](https://github.com/hanshuebner/cl-github-v3) Common Lisp interface to the github V3 API
* [Local-Time](https://github.com/dlowe-net/local-time) Time manipulation library for Common Lisp
