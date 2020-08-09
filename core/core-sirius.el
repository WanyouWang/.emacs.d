(require 'core-config)
(require 'core-keybinding)
(require 'core-ui)

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

(require 'sirius-verilog)


;;init sirius
(defun sirius/init() 
    ;;packages
    (sirius/init-package)
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
)

(defun sirius/init-lang ()
    (verilog/init-verilog)


)





(provide 'core-sirius)