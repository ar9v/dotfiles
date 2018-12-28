;; -*-lisp-*-
;; My own stumpwmrc

(in-package :stumpwm)
(require :swank)

(setf *mode-line-position* :bottom)
;; Initialization
(cond (*initializing*
       ;; Swank Magic
       (swank-loader:init)
       (swank:create-server :port 4005
			    :style swank:*communication-style*
			    :dont-close t)
       ;; Activate the mode-line
       ;; Make the mode-line appear at the bottom
       (setf *mode-line-position* :bottom)
       (run-commands "mode-line"))
      (t nil))
       
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
(let ((state-cmd "acpi | awk '{ print $3 }' | sed 's/,/ /g' | head -c -1")
      (percentage-cmd "acpi | awk '{ print $4 }' | sed 's/,/ /g' | head -c -1"))
  (setf *screen-mode-line-format* (list "^B%n^b | "
					"%W "
					`(:eval (run-shell-command ,state-cmd t))
					`(:eval (run-shell-command ,percentage-cmd t)))))
				                  
  
;; Systemctl operations (locking, poweroff, rebooting, suspending)
(defcommand power-mode () ()
  (let ((cmd (select-from-menu (current-screen)
			       '(("lock") ("suspend") ("shutdown") ("reboot"))
			       "Select: ")))
       (run-shell-command (concat "i3exit " (car cmd)))))

(define-key *root-map* (kbd "C-s") "power-mode")

;; Message window font
(set-font "-uw-*-medium-r-*-*-13-*-*-*-*-*-iso10646-1")
