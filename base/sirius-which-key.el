(require 'core-config)

(defun sirius/init-which-key ()
    (if (not sirius-dumped)
        (progn
            (sirius/init-which-key-base)
        ) 
    )
)

(defun sirius/init-which-key-base ()
    (use-package which-key
        :defer .1    
        :diminish (which-key-mode . " Ⓚ")
        :config
            (which-key-mode) 
            (setq which-key-idle-delay sirius-which-key-delay
                  which-key-idle-secondary-delay 0.01
                  which-key-add-column-padding 1
                  which-key-allow-multiple-replacements t
                  which-key-echo-keystrokes 0.02
                  which-key-max-display-columns nil
                  which-key-min-display-lines 6
                  which-key-prevent-C-h-from-cycling t
                  which-key-sort-order 'which-key-prefix-then-key-order
                  which-key-sort-uppercase-first nil
                  which-key-special-keys nil
                  which-key-use-C-h-for-paging t
                  which-key-separator " ➤ " 
                  which-key-prefix-prefix " ☉ " 
                ;;   which-key-allow-evil-operators 
            )
            (let ((new-descriptions '(("sirius//*\\(.+\\)" . "\\1"))))
                (dolist (nd new-descriptions)
                (push (cons (cons nil (concat "\\`" (car nd) "\\'"))
               (cons nil (cdr nd))) which-key-replacement-alist)))
            (sirius/init-which-key--default-prefixes)
    )
)

(defun sirius/init-which-key--default-prefixes ()
  (setq prefixes '(
           ("SPC" "Command Menu")
           ("TAB" "Last Buffer")
           ("s" "Search")
           ("f" "File")
		   ("b" "Buffer")
           ("w" "Window")
		   ("q" "Quit")
           ("c" "Comment")
           ))
  (mapc (lambda (x)
	  (apply #'sirius/declare-prefix x)) prefixes)
)















(provide 'sirius-which-key)