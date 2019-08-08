;; -*-lisp-*-
;; My own stumpwmrc

(in-package :stumpwm)
(require :swank)
(set-module-dir "/home/niyx/.stumpwm.d/mods/")

;; Most of my definitiones are withing :stumpwm, so might as well
(setf *default-package* :stumpwm)

;; Load modules
(map nil #'load-module '("battery-portable"
			 "cpu"
			 "disk"
			 "mem"
			 "net"
			 "wifi"
			 "kbd-layouts"
			 "amixer"
			 "ttf-fonts"))
;;			 :stumpwm-base16))

;; ;; Modeline and message colors
(setf *mode-line-background-color* "black")
(setf *mode-line-foreground-color* "white")
(set-bg-color "black")
(set-fg-color "white")

;; Font
(set-font (make-instance 'xft:font :family "Iosevka" :subfamily "Regular" :size 11))

;; Initialization
(cond (*initializing*
       ;; Swank Magic
       (swank-loader:init)
       (swank:create-server :port 4004
			    :style swank:*communication-style*
			    :dont-close t)
       ;; Activate the mode-line
       ;; Make the mode-line appear at the bottom
       ;; Make Stumpwm reserve space for polybar in the bottom of the frame
       (setf *mode-line-position* :bottom)
       (setf *mode-line-timeout* 1)
       (run-commands "mode-line"))
      (t nil))

;; Keyboard layouts and switch bind
(kbd-layouts:keyboard-layout-list "us" "latam")
(define-key *root-map* (kbd "s-SPC") "switch-keyboard-layout")

;; New startup message
(setf *startup-message* "Welcome, niyx")

;; Ignore duplicates in command/eval history
(setf *input-history-ignore-duplicates* t)

;; Change naming source (C-t ') to class instead of title
(setf *window-name-source* :class)

;; Change terminal to urxvt
(map 'list (lambda (x)
	     (define-key *root-map* x "exec urxvt"))
     (list (kbd "C-c") (kbd "c")))

;; Modeline customization
(setf *screen-mode-line-format* (list "^B%n^b | "
				      "%W ^> | "
				      "%C | "
				      "%M | "
				      "%B | "
				      "%D | "
				      "%d | "
				      "%I "))

;; Start window numbering from 1. Gets funky with more than 9 windows in a group
(setq *window-number-map* "1234567890")

;;;; Keybindings

;; Systemctl operations (locking, poweroff, rebooting, suspending)
(defcommand power-mode () ()
  (let ((cmd (select-from-menu (current-screen)
			       '(("lock") ("suspend") ("shutdown") ("reboot"))
			       "Select: ")))
       (run-shell-command (concat "i3exit " (car cmd)))))

(define-key *root-map* (kbd "C-s") "power-mode")

;; Frame movement
(define-key *root-map* (kbd "o") "fnext")

;; Volume Control
(define-key *top-map* (kbd "XF86AudioLowerVolume") "amixer-Master-1-")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "amixer-Master-1+")
(define-key *top-map* (kbd "XF86AudioMute") "amixer-Master-toggle")

;; Browser keybinding
(defcommand firefox () ()
	    (run-or-raise "firefox" '(:class "Firefox")))

(define-key *root-map* (kbd "C-q") "firefox")

;; Backlight keybindings
(define-key *top-map* (kbd "XF86MonBrightnessUp") "run-shell-command xbacklight -inc 5%")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "run-shell-command xbacklight -dec 5%")

;; Window programming
(define-key *root-map* (kbd "C-TAB") "pull-hidden-next")
(define-key *root-map* (kbd "q") "remove-split")

(defparameter *workflow-execs* (list (cons '|react-work| '("emacs" "firefox" "urxvt" "zathura"))
				     (cons '|Default| '())))

(defun load-flow (group)
  (let ((path (concat "~/.stumpwm.d/" group)))
        (restore-from-file (concat path ".rule"))
	(restore-window-placement-rules (concat path ".window"))))

(defun run-flow (flow-progs)
  (mapcar #'run-shell-command (cdr flow-progs)))

(defcommand workflow () ()
	    (clear-window-placement-rules)
	    (let ((flow (car (select-from-menu (current-screen)
					       '(("Default") ("react-work"))
					       "Workflow: "))))
	      ;; (select-from-menu) returns a singleton whose element is the string needed
	      (run-commands (concat "grename " flow))
	      (cond ((string-equal flow "Default") nil)
		    (t (load-flow flow) (run-flow (assoc (intern flow) *workflow-execs*))))))

(define-key *root-map* (kbd "z") "workflow")
