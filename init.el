;;load-file
(setq warning-minimum-level :emergency)

(load-file (concat (file-name-directory user-emacs-directory)
	"core/core-load-path.el"))

;;requirement
(require 'core-sirius)
(require 'core-dump)

(sirius/dump-init)
;;init
(sirius/init)
(sirius/init-lang)





