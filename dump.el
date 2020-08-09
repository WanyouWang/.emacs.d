
;; (require 'package)
;; load autoload files and populate load-path’s
;; (package-initialize)
;; (package-initialize) doens’t require each package, we need to load
;; those we want manually

(load (expand-file-name "init.el" user-emacs-directory))
(setq sirius-dumped-load-path load-path
      sirius-dumped t)
;; (package-initialize)

(dolist 
    (
        package 
        '(
            use-package 
            company 
            company-box
            company-tabnine
            which-key
            helm
            helm-swoop
            smartparens
            hl-todo
            highlight-indentation
            highlight-parentheses
            rainbow-delimiters
            solarized-theme
            solarized-dark-theme
            spaceline
            all-the-icons
            spaceline-all-the-icons
            linum-relative
            smooth-scrolling
            dash
            diminish
            bind-key
            bind-map
            async
            delsel
            recentf
            eldoc
            savehist
        )
    )
    (require package)
)

(use-package solarized-theme
    :init
        (load-theme 'solarized-dark t t)
)

;; dump image
(dump-emacs-portable "~/.emacs.d/emacs.pdmp")