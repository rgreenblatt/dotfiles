;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; Start of xbindkeys configuration ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; This configuration is guile based.
;;
;; This configuration allow combo keys.
;; ie Control+z Control+e -> xterm
;;    Control+z z         -> rxvt
;;    Control+z Control+g -> quit second mode
;;
;; It also allow to add or remove a key on the fly!

(use-modules (ice-9 popen))
(use-modules (ice-9 rdelim))


(define (display-n str)
  "Display a string then newline"
  (display str)
  (newline))


(define (Layer-0)
  (ungrab-all-keys)
  (remove-all-keys)
  ;i3 + vim integration
  (xbindkey-function 
    '(Alt h)
    (lambda () 
      (if 
	(string=? (let* ((port (open-input-pipe "xdotool getwindowname $(xdotool getwindowfocus)"))
			 (str  (read-line port)))
		    (close-pipe port)
		    str)
		  "nvim")
	(run-command "xvkbd -xsendevent -text '\\C\\\\\\Cngzh'")
	(run-command "i3-msg focus right"))))
  (xbindkey-function 
    '(Alt j)
    (lambda () 
      (if 
	(string=? (let* ((port (open-input-pipe "xdotool getwindowname $(xdotool getwindowfocus)"))
			 (str  (read-line port)))
		    (close-pipe port)
		    str)
		  "nvim")
	(run-command "xvkbd -xsendevent -text '\\C\\\\\\Cngzj'")
	(run-command "i3-msg focus down"))))
  (xbindkey-function 
    '(Alt k)
    (lambda () 
      (if 
	(string=? (let* ((port (open-input-pipe "xdotool getwindowname $(xdotool getwindowfocus)"))
			 (str  (read-line port)))
		    (close-pipe port)
		    str)
		  "nvim")
	(run-command "xvkbd -xsendevent -text '\\C\\\\\\Cngzk'")
	(run-command "i3-msg focus up"))))
  (xbindkey-function 
    '(Alt l)
    (lambda () 
      (if 
	(string=? (let* ((port (open-input-pipe "xdotool getwindowname $(xdotool getwindowfocus)"))
			 (str  (read-line port)))
		    (close-pipe port)
		    str)
		  "nvim")
	(run-command "xvkbd -xsendevent -text '\\C\\\\\\Cngzl'")
	(run-command "i3-msg focus left"))))

  ;peek layer 1
  (xbindkey-function '(XF86Calculator) Layer-1)
  (grab-all-keys))

(define (Layer-1)
  "Second binding"
  (display "New binding")
  (ungrab-all-keys)
  (remove-all-keys)

  (xbindkey-function '(q)
		     (lambda () 
		       (run-command "xvkbd -xsendevent -text '1'")
		       (Layer-0)))
  (xbindkey-function '(w) 
		     (lambda () 
		       (run-command "xvkbd -xsendevent -text '2'")
		       (Layer-0)))
  (xbindkey-function '(e) 
		     (lambda () 
		       (run-command "xvkbd -xsendevent -text '3'")
		       (Layer-0)))
  (xbindkey-function '(r)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '4'")
		       (Layer-0)))
  (xbindkey-function   '(t)
		       (lambda ()
			 (run-command "xvkbd -xsendevent -text '5'")
			 (Layer-0)))
  (xbindkey-function '(y)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '6'")
		       (Layer-0)))
  (xbindkey-function '(u)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '7'")
		       (Layer-0)))
  (xbindkey-function '(i)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '8'")
		       (Layer-0)))
  (xbindkey-function '(o)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '9'")
		       (Layer-0)))
  (xbindkey-function '(p)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '0'")
		       (Layer-0)))
  (xbindkey-function '(shift q)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '!'")
		       (Layer-0)))
  (xbindkey-function '(shift w)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '@'")
		       (Layer-0)))
  (xbindkey-function '(shift e)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '#'")
		       (Layer-0)))
  (xbindkey-function '(shift r)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '$'")
		       (Layer-0)))
  (xbindkey-function '(shift t)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '%'")
		       (Layer-0)))
  (xbindkey-function '(shift y)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '^'")
		       (Layer-0)))
  (xbindkey-function '(shift u)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '&'")
		       (Layer-0)))
  (xbindkey-function '(shift i)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '*'")
		       (Layer-0)))
  (xbindkey-function '(shift o)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text '('")
		       (Layer-0)))
  (xbindkey-function '(shift p)
		     (lambda ()
		       (run-command "xvkbd -xsendevent -text ')'")
		       (Layer-0)))
  (xbindkey-function '(Escape) Layer-0)
  (grab-all-keys))




(Layer-0)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; End of xbindkeys configuration ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
