;;dump
(defvar sirius-dumped nil
    "non-nil when a dump file is loaded (because dump.el sets this variable).")

(defmacro sirius-if-dump (then &rest else)
    "Evaluate IF if running with a dump file, else evaluate ELSE."
    (declare (indent 1))
    `(if sirius-dumped
    ,then
    ,@else)
 )

(defun sirius/dump-init ()
    (sirius-if-dump
        (progn
        (setq load-path sirius-dumped-load-path)
        (global-font-lock-mode)
        (transient-mark-mode)
        (add-hook 'after-init-hook
        (lambda ()
        (save-excursion
        (switch-to-buffer "*scratch*")
        (lisp-interaction-mode)))))
        ;; add load-path’s and load autoload files
        ;; (enable-theme 'solarized-dark)
    )
)











(provide 'core-dump)