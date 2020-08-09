(defun sirius/init-navigation()
    (if (not sirius-dumped)
        (progn
            (sirius/init-smooth-scorlling)
        ) 
    )

)


(defun sirius/init-smooth-scorlling ()
    (use-package smooth-scrolling
        :defer .1    
        :config
            (smooth-scrolling-mode)    
    )
)


(provide 'sirius-navigation)