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
            (setq smooth-scroll-margin 2)    
    )
)

;;TODO: mouse smooth



(provide 'sirius-navigation)