(defun sirius/init-dashboard ()
    (if (not sirius-dumped)
        (progn
            (sirius/init-dashboard-base)
        ) 
    )
)

(defvar sirius-logo-light (expand-file-name "light-logo.png" user-emacs-directory))
(defvar sirius-logo-dark  (expand-file-name "dark-logo.png" user-emacs-directory))
(defvar sirius-buffer-name "*sirius*")
(defvar sirius-logo-title-name "[ S I R I U S ]")


(defun sirius/init-dashboard-base ()
    (setq inhibit-splash-screen t)
    (use-package dashboard
        :diminish (page-break-lines-mode . "")
        :hook
        (after-init . dashboard-setup-startup-hook) 
        :custom-face 
            (dashboard-heading ((t (:inherit (font-lock-string-face bold)))))
            (dashboard-footer ((t (:inherit (font-lock-string-face bold)))))
            (dashboard-navigator ((t (:inherit (font-lock-string-face bold)))))
        :init
        (setq display-time-load-average 0)
        (setq 
              dashboard-banner-logo-title sirius-logo-title-name
              dashboard-set-footer t
              dashboard-center-content t
              dashboard-set-init-info t
              dashboard-show-shortcuts t
              dashboard-set-heading-icons t
              dashboard-set-file-icons t
              dashboard-set-navigator t

              dashboard-footer-messages '("Powered by Wanyou Wang")
              dashboard-items '((recents  . 10)
                                (bookmarks . 5)
                                (projects . 5))

              dashboard-init-info "always."
              dashboard-heading-icons '(
                                    (recents   . "file-text")
                                    (bookmarks . "bookmark")
                                    (agenda    . "calendar")
                                    (projects  . "briefcase")
                                    (registers . "database"))
        )

        :config
        ;; (if (string-match "light" (pop custom-enabled-themes))
            ;; (setq dashboard-startup-banner sirius-logo-light)
            (setq dashboard-startup-banner sirius-logo-dark)
        ;; )

        (setq dashboard-footer-icon (all-the-icons-octicon "dashboard"
                                                   :height 1.1
                                                   :v-adjust -0.05
                                                   :face 'all-the-icons-blue
                                                   )
                                                   
        )

        (setq dashboard-navigator-buttons
      `(;; line1
        ((,(all-the-icons-octicon "mark-github" :height 1.1 :v-adjust 0.0 :face 'all-the-icons-blue)
         "Homepage"
         "Browse homepage"
         (lambda (&rest _) (browse-url "homepage")))

        (,(all-the-icons-material "autorenew" :height 1.1 :v-adjust -0.2 :face 'all-the-icons-blue)
         "Restart"
         "Restart Sirius"
         (lambda (&rest _) (browse-url "sirius")))
        )
         ;; line 2
         ))



    )
)
















(provide 'core-dashboard)
