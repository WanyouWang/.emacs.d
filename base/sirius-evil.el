;;evil
(defun sirius/init-evil() 
    (sirius/init-evil-base)
    ;; (sirius/init-evil-escape)
    (sirius/init-evil-goggles)
    ;; (sirius/init-evil-commentary)
    (sirius/init-evil-nerd-commenter)
)

(defun sirius/init-evil-base ()
    "Evil package"
    (use-package evil
        :defer .1 
        :config 
            (evil-mode) 
    )
)

(defun sirius/init-evil-escape ()
    (use-package evil-escape
        :defer .1
        :diminish 'evil-escape-mode    
        :config
            (evil-escape-mode) 
            (setq-default evil-escape-delay 0.3)
            (setq-default evil-escape-key-sequence "jk")
            (setq evil-escape-excluded-major-modes '(dired-mode))
        :bind 
        (
            :map evil-normal-state-map 
            ("<escape>" . keyboard-quit)
            :map evil-visual-state-map
            ("<escape>" . keyboard-quit)
            :map minibuffer-local-map
            ("<escape>" . abort-recursive-edit)
            :map minibuffer-local-ns-map
            ("<escape>" . abort-recursive-edit)
            :map minibuffer-local-completion-map
            ("<escape>" . abort-recursive-edit)
            :map minibuffer-local-must-match-map
            ("<escape>" . abort-recursive-edit)
            :map minibuffer-local-isearch-map
            ("<escape>" . abort-recursive-edit)
        )
    )
)

(defun sirius/init-evil-goggles ()
    (use-package evil-goggles
        :defer .1    
        :diminish (evil-goggles-mode . "")
        :config
            (evil-goggles-mode) 
            (evil-goggles-use-diff-faces)
            (setq evil-goggles-pulse t)
            (setq evil-goggles-duration 0.100)
    )
)

;; (defun sirius/init-evil-commentary ()
;;     (use-package evil-commentary
;;       :hook (prog-mode . evil-commentary-mode)
;;       :config
;;         (sirius/set-key 
;;             "cl" 'evil-commentary 
;;         )
;;     )
;; )

(defun sirius/init-evil-nerd-commenter ()
  (use-package evil-nerd-commenter
    :commands evilnc-comment-operator
    :init
    (progn
      ;; double all the commenting functions so that the inverse operations
      ;; can be called without setting a flag
      (defun sirius/comment-or-uncomment-lines-inverse (&optional arg)
        (interactive "p")
        (let ((evilnc-invert-comment-line-by-line t))
          (evilnc-comment-or-uncomment-lines arg)))

      (defun sirius/comment-or-uncomment-lines (&optional arg)
        (interactive "p")
        (let ((evilnc-invert-comment-line-by-line nil))
          (evilnc-comment-or-uncomment-lines arg)))

      (sirius/set-key
        "cl" 'sirius/comment-or-uncomment-lines
        "cL" 'sirius/comment-or-uncomment-lines-inverse
      )
    )
  )
)



(provide 'sirius-evil)