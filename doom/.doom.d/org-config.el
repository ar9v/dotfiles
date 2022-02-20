;;; ../dotfiles/doom/.doom.d/org-config.el -*- lexical-binding: t; -*-

;; Regular Org stuff
(add-hook! org-mode
  (org-bullets-mode 1)
  (setq org-startup-indented t
        org-bullets-bullet-list '(" ") ;; no bullets, needs org-bullets package
        org-ellipsis "  "             ;; folding symbol
        org-pretty-entities t
        org-hide-emphasis-markers t
        ;; show actually italicized text instead of /italicized text/
        org-agenda-block-separator ""
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-fontify-quote-and-verse-blocks t))

;; Org LaTeX process
(setq org-latex-listings 'minted
      org-latex-packages-alist '(("" "minted"))
      org-latex-pdf-process
      '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

(map! :map org-mode-map
      "C-c b" 'org-previous-item
      "C-c f" 'org-next-item
      "C-c u" 'org-up-element
      "C-c d" 'org-down-element)
