(require 'core-ui)
(defun sirius/init-helm ()
    (if (not sirius-dumped)
      (progn 
        (sirius/init-helm-base)
        (sirius/init-helm-swoop)
      )
    )
)

(defun sirius/init-helm-base ()
   (use-package helm
     :defer .1
     :diminish (helm-mode . " Ⓗ")
    ;;  :hook (helm-minibuffer-set-up . sirius//helm-hide-minibuffer-maybe)
     :init
       (setq helm-describe-function-function 'helpful-callable)
       (setq helm-inherit-input-method nil)
       (setq helm-idle-delay 0.0
             helm-input-idle-delay 0.01
             helm-ff-skip-boring-files t
             helm-quick-update t
             helm-display-header-line nil
             helm-echo-input-in-header-line t
       )
       (setq helm-move-to-line-cycle-in-source nil)
       (setq helm-ff-file-name-history-use-recentf t)
     :config
       (helm-mode)
       (sirius/set-key 
         "SPC" 'sirius/helm-M-x-fuzzy-matching
         "ff"  'sirius/helm-find-files
        )
        (setq helm-ff-file-name-history-use-recentf t)
      :bind (
        :map helm-map
          ("C-j" . 'helm-next-line)
          ("C-k" . 'helm-previous-line)
          ("<escape>" . 'keyboard-escape-quit)
      )
   )
)

(defun sirius/init-helm-swoop ()
    (use-package helm-swoop
      :commands helm-swoop
      :custom-face
        (helm-swoop-line-number-face ((t :inherit line-number)))
      :init
        (setq helm-swoop-split-with-multiple-windows t
              helm-swoop-split-direction 'split-window-vertically
              helm-swoop-split-window-function 'helm-default-display-buffer
              helm-swoop-use-line-number-face t
              helm-swoop-move-to-line-cycle t
              helm-swoop-use-fuzzy-match t
              helm-swoop-pre-input-function (lambda () "")
              helm-swoop-speed-or-color t
        )
        (sirius/set-key
          "ss" 'helm-swoop 
          "sS" 'helm-multi-swoop
        )


      :bind (
        :map helm-swoop-map
          ("C-j" . 'helm-next-line)
          ("C-k" . 'helm-previous-line)
      )
    )
)

(defun sirius/helm-find-files (arg)
  "Custom sirius implementation for calling helm-find-files-1.
Removes the automatic guessing of the initial value based on thing at point. "
  (interactive "P")
  ;; fixes #10882 and #11270
  (require 'helm-files)
  (let* ((hist (and arg helm-ff-history (helm-find-files-history)))
         (default-input hist)
         (input (cond ((and (eq major-mode 'dired-mode) default-input)
                       (file-name-directory default-input))
                      ((and (not (string= default-input ""))
                            default-input))
                      (t (expand-file-name (helm-current-directory))))))
    (set-text-properties 0 (length input) nil input)
    (helm-find-files-1 input)))

(defun sirius/helm-M-x-fuzzy-matching ()
  "Helm M-x with fuzzy matching enabled"
  (interactive)
  (let ((completion-styles completion-styles))
    (add-to-list 'completion-styles `,(if (version< emacs-version "27") 'helm-flex 'flex) t)
    (command-execute 'helm-M-x)))


(defun sirius//helm-hide-minibuffer-maybe ()
  "Hide minibuffer in Helm session if we use the header line as input field."
  (when (with-helm-buffer helm-echo-input-in-header-line)
    (let ((ov (make-overlay (point-min) (point-max) nil nil t)))
      (overlay-put ov 'window (selected-window))
      (overlay-put ov 'face
                   (let ((bg-color (face-background 'default nil)))
                     `(:background ,bg-color :foreground ,bg-color)))
      (setq-local cursor-type nil))))

(add-hook 'helm-minibuffer-set-up-hook 'helm-hide-minibuffer-maybe)




(provide 'sirius-helm)