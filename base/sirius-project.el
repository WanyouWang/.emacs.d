(defun sirius/init-project ()
    (if (not sirius-dumped)
        (progn
            (sirius/init-project-base)
        ) 
    )
)

(defun sirius/init-project-base ()
 (use-package projectile
    :diminish (projectile-mode . "")
    :commands (projectile-ack
               projectile-ag
               projectile-compile-project
               projectile-dired
               projectile-find-dir
               projectile-find-file
               projectile-find-tag
               projectile-test-project
               projectile-grep
               projectile-invalidate-cache
               projectile-kill-buffers
               projectile-multi-occur
               projectile-project-p
               projectile-project-root
               projectile-recentf
               projectile-regenerate-tags
               projectile-replace
               projectile-replace-regexp
               projectile-run-async-shell-command-in-root
               projectile-run-shell-command-in-root
               projectile-switch-project
               projectile-switch-to-buffer
               projectile-vc)
    :init
      (setq  projectile-indexing-method 'alien
               projectile-generic-command "find . -type f")
      (setq projectile-sort-order 'recentf
            projectile-cache-file (concat sirius-cache-dir
                                          "projectile.cache")
            projectile-known-projects-file (concat sirius-cache-dir
                                                   "projectile-bookmarks.eld")
        )
    ;;   (sirius/set-key
    ;;     "pf" 'projectile-find-file 
    ;;     "pp" 'projectile-switch-project 
    ;;     "pr" 'projectile-recentf
    ;;     "pd" 'projectile-kill-buffers
    ;;     "pb" 'projectile-switch-to-buffer
    ;;   )
      :config
        (projectile-mode)
 )
)


(provide 'sirius-project)