(defun sirius/init-visual ()
    (sirius/init-hl-line)
    (if (not sirius-dumped)
        (progn 
            (sirius/init-hl-todo)
            ;; (sirius/init-rainbow)
            (sirius/init-rainbow-delimiters)
            (sirius/init-hl-parentheses)
            ;; (sirius/init-hl-indent)
            (sirius/init-whitespace)   
        ) 
    )
)

(defun sirius/init-hl-line ()
    (global-hl-line-mode)
)

(defun sirius/init-hl-todo ()
    (use-package hl-todo
        :defer .1    
        :config
            (global-hl-todo-mode) 
    )
)

(defun sirius/init-whitespace ()
    (use-package whitespace)
)


(defun sirius/init-rainbow ()
    (use-package rainbow-mode
        :hook (prog-mode . rainbow-mode)
    )
)


(defun sirius/init-rainbow-delimiters ()
    (use-package rainbow-delimiters
        :hook (prog-mode . rainbow-delimiters-mode)
    )
)

(defun sirius/init-hl-parentheses ()
    (use-package highlight-parentheses
        :diminish (highlight-parentheses-mode . "")
        :hook (prog-mode . highlight-parentheses-mode)    
        :config 
            (setq hl-paren-delay 0.2) 
            (setq hl-paren-colors '("Springgreen3"
                              "IndianRed1"
                              "IndianRed3"
                              "IndianRed4"))
            (set-face-attribute 'hl-paren-face nil :weight 'ultra-bold)
    )
)

(defun sirius/init-hl-numbers ()
    (use-package highlight-numbers
        :hook (prog-mode . highlight-numbers-mode) 
    )
)

(defun sirius/init-hl-indent ()
    (use-package highlight-indentation
        :hook (prog-mode . highlight-indentation-mode)
    )
)




(provide 'sirius-visual)