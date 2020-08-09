(defun sirius/init-buffer()
    (sirius/init-buffer-keybindings)
)

(defun sirius/init-buffer-keybindings()
    (sirius/set-key
        "bb"  'helm-mini
        "bd"  'sirius/kill-this-buffer
        "TAB" 'sirius/alternate-buffer
        "qq"  'sirius/prompt-kill-emacs
        "fs"  'save-buffer
    )
)

(defun sirius/kill-this-buffer (&optional arg) 
    (interactive "P") 
    (if (window-minibuffer-p) (abort-recursive-edit) 
        (if (equal '(4) arg) 
	        (kill-buffer-and-window) 
            (kill-buffer)
        )
    )
)

(defun sirius/alternate-buffer (&optional window) 
    (interactive) 
    (let ((current-buffer (window-buffer window)))
    ;; if no window is found in the windows history, `switch-to-buffer' will
    ;; default to calling `other-buffer'.
        (switch-to-buffer 
            (cl-find-if (lambda (buffer) 
                (not (eq buffer current-buffer))) 
                (mapcar #'car (window-prev-buffers window))
            )
        )
    )
)

(defun sirius/prompt-kill-emacs ()
  "Prompt to save changed buffers and exit sirius"
  (interactive)
  (setq spacemacs-really-kill-emacs t)
  (save-some-buffers nil t)
  (kill-emacs))

(provide 'sirius-buffer)