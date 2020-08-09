(defun sirius/init-package ()
    (if (not sirius-dumped)
        (progn
            (sirius/init-use-package)
            (sirius/init-diminish)
            (sirius/init-bind-key)
            (sirius/init-bind-map)   
        ) 
    )
)

(defun sirius/init-use-package ()
    ;;set sirius elpa path
    (require 'package)
    (setq package-user-dir 
        (concat sirius-elpa-dir emacs-version)
    )
    (setq package-archives '(("gnu"   . "https://elpa.emacs-china.org/gnu/")
                            ("melpa" . "https://elpa.emacs-china.org/melpa/")))
    (package-initialize)

    (unless (fboundp 'use-package)
    (package-refresh-contents)
    (package-install 'use-package))
    (use-package use-package
        :config    
            (setq use-package-always-defer t
                  use-package-always-ensure t
                  use-package-expand-minimally t) 
    )
)

(defun sirius/init-diminish ()
    (use-package diminish)
)

(defun sirius/init-bind-key ()
    (use-package bind-key)
)

(defun sirius/init-bind-map()
    (use-package bind-map)
    (require 'bind-map)
    (bind-map sirius-default-map
        :prefix-cmd sirius-cmds 
        :evil-keys (sirius-leader-key) 
        :override-minor-modes t
        :override-mode-name sirius-leader-override-mode
    )
)

(provide 'sirius-packages)
