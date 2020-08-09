(defvar sirius-default-map (make-sparse-keymap) 
  "Base keymap for all sirius leader key commands.")

(defvar sirius/prefix-titles nil 
  "alist for mapping command prefixes to long names.")

;;for which key
(defun sirius/declare-prefix (prefix name &optional long-name)
    (let* (
        (command name)
        (full-prefix (concat sirius-leader-key " " prefix))
        )
        (unless long-name
          (setq long-name name)  
        )
        (which-key-declare-prefixes full-prefix (cons name long-name)) 
    )
)

(defun sirius/declare-prefix-for-mode  (mode prefix name &optional long-name)
    (let (
        (command (intern (concat (symbol-name mode) name)))
        (full-prefix (concat sirius-leader-key " " prefix))
        (is-major-mode prefix (string-prefix-p "m" prefix))
        (major-mode-prefix (concat sirius-major-mode-leader-key " " (substring prefix 1)))
        ) 
        (unless long-name
            (setq long-name name) 
        ) 
        (let (
            (prefix-name (cons name long-name))
            )
            (which-key-declare-prefixes-for-mode mode full-prefix prefix-name)
            (when (and is-major-mode-prefix config-major-mode-leader-key)
                (which-key-declare-prefixes-for-mode mode major-mode-prefix prefix-name))
        ) 
    )
)
;;sirius evil-leader
(defun sirius/set-key (key def &rest bindings)
    (while key (define-key sirius-default-map (kbd key) def)
        (setq key (pop bindings) def (pop bindings))
    )
)

(defun sirius//init-leader-mode-map (mode map &optional minor)
    (let* (
        (prefix (intern (format "%s-prefix" map)))
        (leader1 ",")
        (leader2 "SPC m")
        (leaders (delq nil (list leader1 leader2)))
    ) 
        (or (boundp prefix)
            (progn (eval `(bind-map ,map 
                    :prefix-cmd ,prefix, 
                    (if minor :minor-modes :major-modes) 
                    (,mode) 
                    :evil-keys ,leaders
                    :evil-states (normal motion visual evilified) 
                    ) 
                )
                (boundp prefix)
            )    
        ) 
    )
)

(defun sirius/set-key-for-major-mode (mode key def &rest bindings)
    (let* ((map (intern (format "sirius-%s-map" mode))))
        (when (sirius//init-leader-mode-map mode map)
            (while key (define-key (symbol-value map) (kbd key) def)
                (setq key (pop bindings) def (pop bindings)) 
            )    
        ) 
    )
)

(put 'sirius/declare-prefix 'lisp-indent-function 'defun)
(put 'sirius/declare-prefix-for-mode 'lisp-indent-function 'defun)
(put 'sirius/set-leader-key 'lisp-indent-function 'defun)
(put 'sirius/set-leader-key-for-major-mode 'lisp-indent-function 'defun)

(defalias 'evil-leader/set-key 'sirius/set-key)
(defalias 'evil-leader/set-key-for-major-mode 'sirius/set-key-for-major-mode)

(provide 'core-keybinding)

