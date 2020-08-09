(defun sirius/init-edit ()
    (if (not sirius-dumped)
        (progn 
            (sirius/init-smartparens)
            (sirius/init-delsel)
            (sirius/init-undo-tree)
        ) 
    )
    (sirius/init-edit-cover)
)

(defun sirius/init-hungry-delete ()
    (use-package hungry-delete
        :defer t    
    )
)

(defun sirius/init-expand-region ()
    (use-package expand-region
        :defer t    
    )
)

(defun sirius/init-smartparens ()
    (use-package smartparens
      :defer t
      :diminish (smartparens-mode . " Ⓟ")
      :init
        (setq sp-base-key-bindings `sp)
        (setq sp-echo-match-when-invisible nil)
        (setq sp-ignore-mode-list nil)
      :hook
        (prog-mode . turn-on-smartparens-strict-mode)
        (minibuffer-setup . turn-on-show-smartparens-mode)
      :config
        (smartparens-global-mode)
        (show-smartparens-global-mode)
    )
)

(defun sirius/init-delsel ()
    (use-package delsel
        :hook (prog-mode . delete-selection-mode)    
    )
)

(defun sirius/init-undo-tree ()
    (use-package undo-tree 
        :diminish (undo-tree-mode . " Ⓤ")
        :config
          (setq undo-tree-visualizer-timestamps t)
          (global-undo-tree-mode)
    )
)

(defun sirius/init-edit-cover ()
    ;;粘贴时,覆盖原文本
    (setq delete-selection-mode t)
)

(provide 'sirius-edit)