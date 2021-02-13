(in-package :stumpwm)

;;;; Window programming

;;; Keybindings
(define-key *root-map* (kbd "C-TAB") "pull-hidden-next")
(define-key *root-map* (kbd "q") "remove-split")

;;; Group navigation
(define-key *top-map* (kbd "M-F1") "gselect 1")
(define-key *top-map* (kbd "M-F2") "gselect 2")
(define-key *top-map* (kbd "M-F3") "gselect 3")
(define-key *top-map* (kbd "M-F4") "gselect 4")
