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

;; Modeline and message colors
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
       
       ;; Groups
       ;;;; Create the groups needed to match up with the polybar config
       (dolist (x '("Web" "Reading" "Random"))
	 (run-commands (concat "gnewbg " x)))

       ;; Activate the mode-line
       ;; Make the mode-line appear at the bottom
       ;; To be able to use polybar, I had to hack mode-line.lisp by changing "update-mode-line-position"
       (setf *mode-line-position* :bottom)
       (setf *mode-line-timeout* 1)
       (run-shell-command "polybar -r example"))
      (t nil))

;; Keyboard layouts and switch bind
(kbd-layouts:keyboard-layout-list "us" "latam")
(run-shell-command "xmodmap ~/.Xmodmap")
(define-key *root-map* (kbd "s-SPC") "switch-keyboard-layout")

;; Remove startup message
(setf *startup-message* nil)

;; Ignore duplicates in command/eval history
(setf *input-history-ignore-duplicates* t)

;; Change naming source (C-t ') to class instead of title
(setf *window-name-source* :class)

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
(define-key *top-map* (kbd "s-h") "move-focus left")
(define-key *top-map* (kbd "s-j") "move-focus down")
(define-key *top-map* (kbd "s-k") "move-focus up")
(define-key *top-map* (kbd "s-l") "move-focus right")

;; Volume Control
(define-key *top-map* (kbd "XF86AudioLowerVolume") "amixer-Master-1-")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "amixer-Master-1+")
(define-key *top-map* (kbd "XF86AudioMute") "amixer-Master-toggle")

;; Keybindings for main programs
(defcommand firefox () ()
	    (run-or-raise "firefox" '(:class "Firefox")))

(defcommand urxvt () ()
	    (run-or-raise "urxvt" '(:class "URxvt")))

;;;; Cycle through the open instances
;;;; (Emacs already does this)
(define-key *root-map* (kbd "C-q") "firefox")
(define-key *root-map* (kbd "C-c") "urxvt")

;;;; Open new instances
(define-key *root-map* (kbd "C-Q") "exec firefox")
(define-key *root-map* (kbd "C-C") "exec urxvt")
(define-key *root-map* (kbd "C-E") "exec emacs")

;; Backlight keybindings
(define-key *top-map* (kbd "XF86MonBrightnessUp") "run-shell-command xbacklight -inc 5%")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "run-shell-command xbacklight -dec 5%")

;; Refresh mode-line (for polybar customization purposes)
(define-key *root-map* (kbd "_") "mode-line")

;;;; Window programming

;; Keybindings
(define-key *root-map* (kbd "C-TAB") "pull-hidden-next")
(define-key *root-map* (kbd "q") "remove-split")

;; Programming workflows
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
