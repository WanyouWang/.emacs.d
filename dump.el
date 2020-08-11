
;; (require 'package)
;; load autoload files and populate load-path’s
;; (package-initialize)
;; (package-initialize) doens’t require each package, we need to load
;; those we want manually

(load (expand-file-name "init.el" user-emacs-directory))
(setq sirius-dumped-load-path load-path
      sirius-dumped t)
;; (package-initialize)

;;package could not be dumped
;;------------------
;;evil
;;dashboard
;;treemacs
;;------------------
(dolist 
    (
        package 
        '(
            use-package 
            diminish
            bind-key
            bind-map

            company 
            company-box
            company-tabnine

            which-key

            helm
            helm-swoop
            helm-projectile

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
            winum

            smooth-scrolling
            dash
            
            async
            delsel
            recentf
            eldoc
            savehist

            projectile

            dired
            diff-hl
            all-the-icons-dired
            dired-git-info
            dired-quick-sort
            diredfl

            org
            toc-org
            org-pomodoro
            org-bullets
            org-fancy-priorities


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
