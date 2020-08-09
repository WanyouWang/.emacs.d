(defun verilog/init-verilog ()
    (verilog/init-verilog-mode)
)

(defun verilog/init-verilog-mode ()
    (use-package verilog-mode
        :diminish (verilog-mode . " Ⓥ")
        :hook (verilog-mode . linum-relative-toggle)
        :commands verilog-mode
        :config
        (setq  verilog-indent-level             3
               verilog-indent-level-module      3
               verilog-indent-level-declaration 3
               verilog-indent-level-behavioral  3
               verilog-indent-level-directive   1
               verilog-case-indent              2
               verilog-auto-newline             nil
               verilog-auto-indent-on-newline   t
               verilog-tab-always-indent        t
               verilog-auto-endcomments         t
               verilog-minimum-comment-distance 40
               verilog-indent-begin-after-if    t
               verilog-auto-lineup              'declarations
               verilog-linter                   "xvlog"
               )
    )
)


(provide 'sirius-verilog)