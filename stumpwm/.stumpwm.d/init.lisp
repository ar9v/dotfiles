(in-package :stumpwm)

(defcommand kitty () () (run-or-raise "kitty" '(:class "kitty")))
(defcommand firefox () () (run-or-raise "firefox" '(:class "firefox")))
(defcommand emacsclient () () (run-or-raise "emacsclient -c" '(:class "Emacs")))

(define-key *top-map* (kbd "s-o") "exec rofi -show drun")
(define-key *top-map* (kbd "s-w") "exec rofi -show window")
(define-key *root-map* (kbd "C-c") "kitty")
(define-key *top-map* (kbd "s-f") "firefox")
(define-key *top-map* (kbd "s-e") "emacsclient")
