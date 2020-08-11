(defun sirius/init-treemacs ()
    (if (not sirius-dumped)
        (progn
            (sirius/init-treemacs-base)
            ;; (sirius/init-treemacs-evil)
            ;; (sirius/init-treemacs-projectile)
            ;; (sirius/init-treemacs-icons-dired)
            ;; (sirius/init-treemacs-magit)
            ;; (sirius/init-treemacs-persp)
        )    
    )
)

(defun sirius/init-treemacs-base ()
    (use-package treemacs
        :commands (treemacs-select-window
                   treemacs-select-scope-type
                   treemacs--window-number-ten
                   treemacs-current-visibility)
        :init
            (sirius/set-key
                "ts" 'treemacs-select-window
                "tt" 'treemacs
                "tb" 'treemacs-bookmark
                "tf" 'treemacs-find-file
                "tg" 'treemacs-find-tag
                "tm" 'treemacs-delete-other-windows
            )
           
                    ;;   (treemacs-follow-mode t)
                    ;;   (treemacs-filewatch-mode t)
                    ;;   (treemacs-fringe-indicator-mode t)
                    ;;   (pcase (cons (not (null (executable-find "git")))
                    ;;             ;;   (not (null treemacs-python-executable)))
                    ;;    (`(t . t)
                    ;;     (treemacs-git-mode 'deferred))
                    ;;    (`(t . _)
                    ;;   (treemacs-git-mode 'simple)))
                    ;;   )
            
        :config
            (treemacs-mode)
    )
)

(defun sirius/init-treemacs-evil ()
    (use-package treemacs-evil
        :after treemacs evil
    )
)

(defun sirius/init-treemacs-projectile ()
    (use-package treemacs-projectile
        :after treemacs projectile    
    )
)

(defun sirius/init-treemacs-icons-dired ()
    (use-package treemacs-icons-dired
        :after treemacs dired
        :config
            (treemacs-icons-dired-mode) 
    )
)

(defun sirius/init-treemacs-magit ()
    (use-package treemacs-magit
        :after treemacs magit 
    )
)

(defun sirius/init-treemacs-persp ()
    (use-package treemacs-persp ;;treemacs-persective if you use perspective.el vs. persp-mode
      :after treemacs persp-mode ;;or perspective vs. persp-mode
      :ensure t
      :config (treemacs-set-scope-type 'Perspectives))
)

;;TODO: all-the-icons


(provide 'sirius-treemacs)