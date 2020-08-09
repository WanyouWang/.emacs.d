(defun sirius/init-ui()
    (sirius/init-ui-base)
    (sirius//init-fonts)
    ;; (sirius//init-highlight)
    (if (not sirius-dumped)
      (progn
        (sirius//init-theme)
        (sirius//init-linum)
        (sirius//init-spaceline)
        (sirius//init-all-the-icons)
        (sirius//init-spaceline-all-the-icons)
      )
    )
    (sirius//init-time)
    (sirius//init-transparent)
)

(defun sirius/init-ui-base ()
  (setq column-number-mode nil)
  (blink-cursor-mode 0)
  (fset 'yes-or-no-p 'y-or-n-p)
  (setq x-underline-at-descent-line t)
;;   (setq inhibit-startup-message t)
  ;; (tool-bar-mode -1)
  ;; (menu-bar-mode -1)
  ;; (toggle-scroll-bar -1)
  ;; (toggle-frame-fullscreen)
)

(defun sirius//init-linum ()
    ;; (use-package winum
    ;;     :defer 1 
    ;;     :config    
    ;;         (winum-mode)
    ;;         (setq winum-auto-setup-mode-line nil)
    ;; )

    (use-package linum-relative
        :hook 
          (prog-mode . linum-relative-toggle)
        :diminish 'linum-relative-mode    
        :init (setq linum-relative-current-symbol "")
        :config 
           (setq linum-relative-format "%4d  ")
           (setq linum-relative-backend 'display-line-numbers-mode)
    )
)

;; (defun sirius//init-highlight ()
;;   (global-hl-line-mode t)
;;   (use-package highlight-parentheses
;;     :diminish 'highlight-parentheses-mode
;;     :hook (prog-mode . highlight-parentheses-mode)
;;   )
;; )

(defun sirius//init-theme ()
    (use-package solarized-theme
        :demand (not sirius-dumped)
        :config    
            (load-theme 'solarized-dark t) 
    )
  ;;  (use-package spacemacs-theme
  ;;       :init    
  ;;           (load-theme 'spacemacs-light t) 
  ;;   )
)

(defun sirius//init-spaceline ()
    (use-package spaceline
        :demand t
        :init 
        (setq-default
            powerline-height 36
            powerline-default-separator 'wave
        )
        :config
            (spaceline-helm-mode)
            (spaceline-spacemacs-theme)
            (setq spaceline-highlight-face-func 'spaceline-highlight-face-evil-state)
;; (setq spaceline-separator-dir-left '(left . left))
;; (setq spaceline-separator-dir-right '(right . right))

  (spaceline-compile
    ; left side
    '(((persp-name
        workspace-number
        window-number)
       :fallback evil-state
       :face highlight-face
       :priority 100)
      (anzu :priority 95)
      auto-compile
      ((buffer-modified buffer-id remote-host)
       :priority 98)
      (major-mode :priority 79)
      (process :when active)
      ((flycheck-error flycheck-warning flycheck-info)
       :when active
       :priority 89)
      (minor-modes :when active
                   :priority 9)
      ;; (mu4e-alert-segment :when active)
      ;; (erc-track :when active)
      (version-control :when active
                       :priority 78)
      ;; (org-pomodoro :when active)
      ;; (org-clock :when active)
      ;; nyan-cat
      )
   ; right side
   '(which-function
     ;; (python-pyvenv :fallback python-pyenv)
     ;; (purpose :priority 94)
     ;; (battery :when active)
     (selection-info :priority 95)
     input-method
     ((buffer-encoding-abbrev
       point-position
       line-column)
      :separator " | "
      :priority 96)
     (global :when active)
     (buffer-position :priority 99)
     (hud :priority 99)
     (:separator " ")
     )
     )

    )
)

(defun sirius//init-all-the-icons ()
    (use-package all-the-icons
    
    
    
    )
)

(defun sirius//init-spaceline-all-the-icons ()
  (use-package spaceline-all-the-icons
    :defer .1
    :init
    (progn
      (setq
       spaceline-all-the-icons-separator-type'wave
       spaceline-all-the-icons-separator-scale 1.6))
    :config
    ;; (spaceline-all-the-icons-theme)
  )
)

(defun sirius//init-fonts ()
  (set-face-attribute 'default nil
                    :family sirius-default-font
                    :height sirius-default-font-size
                    :weight 'normal
                    :width 'normal
                    )
)


(defun sirius//init-time ()
  (use-package time
    :init
      (setq display-time-format "%H:%M")
    :hook (after-init . display-time-mode)
  )
)

(defun sirius//init-transparent ()
  ;;调整透明度函数
  (setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))   
  (defun loop-alpha ()  
    (interactive)  
    (let ((h (car alpha-list)))                  
      ((lambda (a ab)  
         (set-frame-parameter (selected-frame) 'alpha (list a ab))  
         (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))  
         ) (car h) (car (cdr h)))  
      (setq alpha-list (cdr (append alpha-list (list h))))  
      )  
  )  
  (global-set-key (kbd "<f2>") 'loop-alpha)
)

(provide 'core-ui)