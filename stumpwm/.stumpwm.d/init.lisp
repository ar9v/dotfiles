;; -*-lisp-*-
;; My own stumpwmrc

(in-package :stumpwm)
(require :swank)
(require :slynk)
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
                         "ttf-fonts"
                         "swm-gaps"))

;; Modeline and message colors
(setf *mode-line-background-color* "black")
(setf *mode-line-foreground-color* "white")
(set-bg-color "black")
(set-fg-color "white")

;; Font
(set-font (make-instance 'xft:font :family "Iosevka" :subfamily "Regular" :size 11))

;; Outline modification
(set-frame-outline-width 0)

;; Initialization
(cond (*initializing*
       ;; Swank Magic
       (swank-loader:init)
       (swank:create-server :port 4004
                            :style swank:*communication-style*
                            :dont-close t)

       ;; Slynk server
       (slynk:create-server :port 4008 :dont-close t)

       ;; Emacs Daemon
       (run-shell-command "emacs --daemon")

       ;; Groups
       ;;;; Create the groups needed to match up with the polybar config
       (run-commands "grename term") ;; Default -> term
       (dolist (x '("web" "reading"))
         (run-commands (concat "gnewbg " x)))

       (run-commands "gnewbg-float random")

       ;; Activate the mode-line
       ;; Make the mode-line appear at the bottom
       ;; To be able to use polybar, I had to hack mode-line.lisp by changing "update-mode-line-position"
       (setf *mode-line-position* :bottom)
       (setf *mode-line-timeout* 1)
       (run-shell-command "launch-poly.sh"))
      (t nil))

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

(defcommand emacsclient () ()
  (run-or-raise "emacsclient -c" '(:class "Emacs")))

;;;; Cycle through the open instances
;;;; (Emacs already does this)
(define-key *root-map* (kbd "C-q") "firefox")
(define-key *root-map* (kbd "C-c") "urxvt")
(define-key *root-map* (kbd "C-e") "emacsclient")

;;;; Open new instances
(define-key *root-map* (kbd "C-Q") "exec firefox")
(define-key *root-map* (kbd "C-C") "exec urxvt")
(define-key *root-map* (kbd "C-E") "exec emacsclient -c")

;; Backlight keybindings
(define-key *top-map* (kbd "XF86MonBrightnessUp") "run-shell-command xbacklight -inc 5%")
(define-key *top-map* (kbd "XF86MonBrightnessDown") "run-shell-command xbacklight -dec 5%")

;; Refresh mode-line (for polybar customization purposes)
(define-key *root-map* (kbd "_") "mode-line")

;; Flameshot control
(define-key *top-map* (kbd "Print") "run-shell-command flameshot gui")
(define-key *top-map* (kbd "C-Print") "run-shell-command pkill flameshot")

;;;; Window programming

;; swm-gaps configuration
;; (run-commands "toggle-gaps")

;; Keybindings
(define-key *root-map* (kbd "C-TAB") "pull-hidden-next")
(define-key *root-map* (kbd "q") "remove-split")

;;;; Commands for programs that must be opened with floating windows

;; Open Android Studio
(defcommand android-studio () ()
  "Start Android Studio in the random group (floating group)"
  (run-commands "gselect random")
  (run-shell-command "studio.sh" nil))

;; Open Zoom
(defcommand zoom () ()
  "Start Zoom in the random group (floating group)"
  (run-commands "gselect random")
  (run-shell-command "zoom" nil))
