;; -*-lisp-*-
;; My own stumpwmrc

(in-package :stumpwm)
;; (require :slynk)

;; Most of my definitiones are within :stumpwm, so might as well
(setf *default-package* :stumpwm)

;; I need to specify where the modules are
(set-module-dir "/usr/share/stumpwm/contrib")

;; Load modules
(dolist (module (list "swm-gaps"
                      "windowtags"
                      "kbd-layouts"))
  (load-module module))

;; Initialization
(cond (*initializing*
       ;; Slynk server
       ;; (slynk:create-server :port 4008 :dont-close t)

       ;; Emacs Daemon
       (run-shell-command "emacs --daemon")

       ;; Window border style
       (setf *window-border-style* :thin)

       ;; Gaps
       ;;; NOTE: Having gaps causes Stump to crash when using Zoom
       ;;; Inner gaps run along all the 4 borders of a window
       (setf swm-gaps:*inner-gaps-size* 5)

       ;;; Outer gaps add more padding to the outermost borders of a window (touching
       ;;; the screen border)
       (setf swm-gaps:*outer-gaps-size* 15)

       ;; Groups
       ;;;; Create the groups needed to match up with the xworkspaces polybar config
       (run-commands "grename term") ;; Default -> term
       (dolist (x '("web" "reading"))
         (run-commands (concat "gnewbg " x)))

       (run-commands "gnewbg-float random")

       ;; Variables
       (setf *suppress-echo-timeout* t) ;; This keeps messages (Ctrl-t m) up indefinitely

       ;; Activate the mode-line
       (setf *mode-line-timeout* 1)
       (run-shell-command "launch-poly.sh")

       ;; Toggle gaps
       (run-commands "toggle-gaps")

       ;; God knows why but StumpWM does not handle dual-monitor polybars so.. time to hack
       ;; Do note that this must be changed. Changes that fire XrandR (e.g. disconnecting the monitor)
       ;; will invariably revert this resizing
       (let ((heads (screen-heads (current-screen))))
         (dolist (head heads)
           (let ((nh (make-head :number 0 ;; number doesn't matter for scaling
                                :x (head-x head) :y (head-y head)
                                :width (head-width head)
                                :height (- (head-height head) 30) ;; We make the head vertically smaller to fit polybar
                                :window nil)))
             (scale-head (current-screen)
                         head
                         nh)))))
      (t nil))

;; Mouse focus rule
(setf *mouse-focus-policy* :sloppy)

;; Keyboard layouts and switch bind
(kbd-layouts:keyboard-layout-list "us" "latam")
(run-shell-command "xmodmap ~/.Xmodmap")
(define-key *root-map* (kbd "s-SPC") "switch-keyboard-layout")

;; Remove startup message and frame indicator
(setf *startup-message* nil)

;; Ignore duplicates in command/eval history
(setf *input-history-ignore-duplicates* t)

;; Change naming source (C-t ') to class instead of title
(setf *window-name-source* :class)

;; Start window numbering from 1. Gets funky with more than 9 windows in a group
(setq *window-number-map* "1234567890")

;; Change Message/Input bar font
(set-font "-uw-ttyp0-medium-*-*-*-14-*-*-*-*-*-*-*")

;;;; Keybindings

;; Opening programs with rofi
(defvar *rofi-bindings*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "RET") "run-shell-command rofi -show drun")
    (define-key m (kbd "w") "run-shell-command rofi -show window")
    m))

(define-key *root-map* (kbd "RET") '*rofi-bindings*)

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

(define-key *root-map* (kbd "M-h") "move-window left")
(define-key *root-map* (kbd "M-j") "move-window down")
(define-key *root-map* (kbd "M-k") "move-window up")
(define-key *root-map* (kbd "M-l") "move-window right")

;; Volume Control
(define-key *top-map* (kbd "XF86AudioLowerVolume") "run-shell-command amixer -q sset Master 3%-")
(define-key *top-map* (kbd "XF86AudioRaiseVolume") "run-shell-command amixer -q sset Master 3%+")
(define-key *top-map* (kbd "XF86AudioMute") "run-shell-command amixer -q sset Master toggle")

;; Keybindings for main programs
(defcommand firefox () ()
	    (run-or-raise "firefox" '(:class "firefox")))

(defcommand terminal () ()
	    (run-or-raise "urxvt" '(:class "URxvt")))

(defcommand emacsclient () ()
  (run-or-raise "emacsclient -c" '(:class "Emacs")))

(defcommand discord () ()
  (run-or-raise "discord" '(:class "Discord")))

;;;; Cycle through the open instances
;;;; (Emacs already does this)
(define-key *root-map* (kbd "C-q") "firefox")
(define-key *root-map* (kbd "C-c") "terminal")
(define-key *root-map* (kbd "C-e") "emacsclient")
(define-key *root-map* (kbd "C-d") "discord")

;;;; Open new instances
(define-key *root-map* (kbd "C-Q") "exec firefox")
(define-key *root-map* (kbd "C-C") "exec urxvt")
(define-key *root-map* (kbd "C-E") "exec emacsclient -c")

;; Backlight keybindings
(define-key *top-map* (kbd "XF86MonBrightnessUp") "run-shell-command light -A 3")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "run-shell-command light -U 3")

;; Refresh mode-line (for polybar customization purposes)
(define-key *root-map* (kbd "_") "mode-line")

;; Flameshot control
(define-key *top-map* (kbd "Print") "run-shell-command flameshot gui")
(define-key *top-map* (kbd "C-Print") "run-shell-command pkill flameshot")

;;;; Window programming

;;; Keybindings
(define-key *root-map* (kbd "C-TAB") "pull-hidden-next")
(define-key *root-map* (kbd "q") "remove-split")

;;; Group navigation
(define-key *top-map* (kbd "M-F1") "gselect 1")
(define-key *top-map* (kbd "M-F2") "gselect 2")
(define-key *top-map* (kbd "M-F3") "gselect 3")
(define-key *top-map* (kbd "M-F4") "gselect 4")

;;;; Commands for programs that must be opened with floating windows
;; Open Zoom
(defcommand zoom () ()
  "Start Zoom in the random group (floating group)"
  (run-commands "gselect random")
  (run-shell-command "zoom" nil))


(defun hide-all-lower-windows (current last)
  (declare (ignore current last))
  (when (typep (current-group) 'stumpwm::tile-group)
    (mapc (lambda (win)
            (unless (eq win (stumpwm::frame-window
                             (stumpwm::window-frame win)))
              (stumpwm::hide-window win)))
          (group-windows (current-group)))))

(defcommand enable-hiding-lower-windows () ()
  "Enable a hook that hides all windows that aren't at the top of
      their frame.
    This is primarily useful when you have (a) transparent window(s) and
    want to
    see the wallpaper underneath instead of other windows."
  (add-hook *focus-window-hook* 'hide-all-lower-windows))
