(defun sirius/init-file ()
    (if (not sirius-dumped)
        (progn 
            (sirius/init-eldoc)
            (sirius/init-recentf)
            (sirius/init-savehist)   
        ) 
    )
    (sirius/init-custom)
    (sirius/init-home-dir)
    (sirius/init-auto-revert)
    (sirius/find-init-file)
)

(defun sirius/init-custom ()
    (setq custom-file "~/.emacs.d/custom.el")
    (unless (file-exists-p custom-file) (write-region "" nil custom-file))
    (load custom-file)
)

(defun sirius/init-home-dir ()
    (setq default-directory sirius-home-dir)
)

(defun sirius/init-auto-revert ()
    (global-auto-revert-mode t);;load the file be changed by the outer automaticly
)

(defun sirius//find-init-file ()
  (interactive)
  (find-file (expand-file-name "init.el" user-emacs-directory))
  )

(defun sirius/find-init-file ()
    (sirius/set-key
        "fed" 'sirius//find-init-file    
    )
)

(defun sirius/init-recentf ()
    (use-package recentf
      :defer .1
      :init
        (recentf-mode)
        (recentf-track-opened-file)
        (setq recentf-save-file (concat sirius-cache-dir "recentf")
            recentf-max-saved-items 1000
            recentf-auto-cleanup 'never
            recentf-auto-save-timer (run-with-idle-timer 600 t
                                                         'recentf-save-list))

      :config
            (add-to-list 'recentf-exclude
                   (recentf-expand-file-name sirius-cache-dir))
            (add-to-list 'recentf-exclude (recentf-expand-file-name package-user-dir))
    )
)

(defun sirius/init-eldoc ()
    (use-package eldoc
        :diminish (eldoc-mode . "")
        :hook 
            (eval-expression-minibuffer-setup . eldoc-mode)
        :config 
            (eldoc-add-command #'evil-insert)
            (eldoc-add-command #'evil-insert-line)
            (eldoc-add-command #'evil-append)
            (eldoc-add-command #'evil-append-line)
            (eldoc-add-command #'evil-force-normal-state)
    )
)

(defun sirius/init-savehist ()
    (use-package savehist
        :init
            (savehist-mode)
            (setq savehist-file (concat sirius-cache-dir "savehist")
                    enable-recursive-minibuffers t ; Allow commands in minibuffers
                    history-length 1000
                    savehist-additional-variables '(mark-ring
                                                    global-mark-ring
                                                    search-ring
                                                    regexp-search-ring
                                                    extended-command-history)
                    savehist-autosave-interval 60)
    )
)



(provide 'sirius-file)