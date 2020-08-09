
(defun sirius/init-window ()
    (sirius/init-window-keybindings)
)

(defun sirius/init-window-keybindings ()
    (sirius/set-key
        "w/" 'split-window-right    
        "w-" 'split-window-below
        "wd" 'delete-window
        "wh" 'evil-window-left
        "wj" 'evil-window-down
        "wk" 'evil-window-up 
        "wl" 'evil-window-right 
        "wm" 'sirius/toggle-maximize-buffer
    )
)

(defun sirius/toggle-maximize-buffer ()
  "Maximize buffer"
  (interactive)
  (save-excursion
    (if (and (= 1 (length (window-list)))
             (assoc ?_ register-alist))
        (jump-to-register ?_)
      (progn
        (window-configuration-to-register ?_)
        (delete-other-windows)
      )
    )
  )
)

(provide 'sirius-window)