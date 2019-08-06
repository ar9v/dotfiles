;; No backups
(setq make-backup-files nil)
(setq auto-save-default nil)

;; Add repositories to alist
(require 'package)
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))

  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  ;; (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
    (add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t))

;; Javascript and React (js2-mode and rsjx-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . rjsx-mode))

;; Org-mode
(setq org-list-allow-alphabetical t)
(setq org-latex-pdf-process
      '("pdflatex -interaction nonstopmode -output-directory %o %f"
        "bibtex %b"
        "pdflatex -interaction nonstopmode -output-directory %o %f"
        "pdflatex -interaction nonstopmode -output-directory %o %f"))

;; Ido-mode
(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; Easier buffer movement
(global-set-key (kbd "M-o") 'other-window)

;; Occur mode context
(setq list-matching-lines-default-context-lines 1)

;; Imenu rebinding
(global-set-key (kbd "M-i") 'imenu)

;;;; Automatic Stuff ;;;;

(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#021012" "#16c1d9" "#4dd0e1" "#80deea" "#00bcd4" "#00acc1" "#00bcd4" "#095b67"])
 '(ansi-term-color-vector
   [unspecified "#021012" "#16c1d9" "#4dd0e1" "#80deea" "#00bcd4" "#00acc1" "#00bcd4" "#095b67"])
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(fancy-splash-image "~/Pictures/mdh-emacs.png")
 '(package-selected-packages
   (quote
    (dashboard ample-theme alect-themes airline-themes ahungry-theme abyss-theme helm bison-mode rjsx-mode js2-mode base16-theme markdown-mode org-ref magit haskell-mode org-link-minor-mode paredit togetherly racket-mode slime)))
 '(vc-annotate-background "#222222")
 '(vc-annotate-color-map
   (quote
    ((20 . "#fa5151")
     (40 . "#ea3838")
     (60 . "#f8ffa0")
     (80 . "#e8e815")
     (100 . "#fe8b04")
     (120 . "#e5c900")
     (140 . "#32cd32")
     (160 . "#8ce096")
     (180 . "#7fb07f")
     (200 . "#3cb370")
     (220 . "#099709")
     (240 . "#2fdbde")
     (260 . "#1fb3b3")
     (280 . "#8cf1f1")
     (300 . "#94bff3")
     (320 . "#62b6ea")
     (340 . "#30a5f5")
     (360 . "#e353b9"))))
 '(vc-annotate-very-old-color "#e353b9"))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;;; "Requires" and some other stuff

(global-company-mode)

;; Setting slime repl program (sbcl) and Quicklisp stuff
(require 'slime-autoloads)
(setq inferior-lisp-program "/usr/bin/sbcl"
      slime-contribs '(slime-fancy))
(slime-setup '(slime-company))
(load (expand-file-name "~/quicklisp/slime-helper.el"))

;; Helm
(require 'helm-config)

;; Auto-insert-mode
(auto-insert-mode)
;; (setq auto-insert-query nil)
(setq auto-insert-directory "~/dotfiles/emacs/.emacs.d/file-templates/")
(define-auto-insert "~/Desktop/TecDeMty/.*\.org" "front-page-template.org")

;; Change splash-screen text
;;;; By inhibiting the splash screen, files opened via ranger do not prompt the
;;;; default Emacs splash screen
(setq inhibit-splash-screen t)
(use-package dashboard
    :ensure t
    :diminish dashboard-mode
    :config
    (setq dashboard-banner-logo-title "Welcome, niyx")
    (setq dashboard-startup-banner "~/Pictures/mdh-emacs.png")
    (setq dashboard-items '((recents  . 10)
                            (bookmarks . 10)))
    (dashboard-setup-startup-hook))

;; Compositing/Transparency
;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
;;(set-frame-parameter (selected-frame) 'alpha <both>)
(set-frame-parameter (selected-frame) 'alpha '(85 . 80))
(add-to-list 'default-frame-alist '(alpha . (85 . 80)))

;; Set the base16 theme and other aesthetics
;; (load-theme 'base16-gruvbox-dark-hard t)
(scroll-bar-mode -1)
