(require 'core-config)
(require 'core-keybinding)
(require 'core-ui)
(require 'core-dashboard)

(require 'sirius-packages)
(require 'sirius-evil)
(require 'sirius-which-key)
(require 'sirius-buffer)
(require 'sirius-window)
(require 'sirius-helm)
(require 'sirius-navigation)
(require 'sirius-visual)
(require 'sirius-edit)
(require 'sirius-file)
(require 'sirius-completion)
(require 'sirius-project)
(require 'sirius-treemacs)
(require 'sirius-dired)

(require 'sirius-verilog)
(require 'sirius-lisp)
(require 'sirius-org)

;;init sirius
(defun sirius/init() 
    ;;packages
    (sirius/init-package)
    ;;dashboard
    (sirius/init-dashboard)
    ;;ui
    (sirius/init-ui)
    ;;evil
    (sirius/init-evil)
    ;;which key
    (sirius/init-which-key)
    ;;buffer
    (sirius/init-buffer)
    ;;window
    (sirius/init-window)
    ;;visual
    (sirius/init-visual)
    ;;helm
    (sirius/init-helm)
    ;;navigation
    (sirius/init-navigation)
    ;;edit
    (sirius/init-edit)
    ;;file
    (sirius/init-file)
    ;;auto complete
    (sirius/init-completion)
    ;;project
    (sirius/init-project)
    ;;treemacs
    (sirius/init-treemacs)
    ;;dired
    (sirius/init-dired)
)

(defun sirius/init-lang ()
    (verilog/init-verilog)
    (lisp/init-lisp)
    (org/init-org)
)





(provide 'core-sirius)
