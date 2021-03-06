(defun sirius/init-dired ()
  (if (not sirius-dumped)
      (progn
        (sirius/init-dired-base)
        ;; (sirius/init-dired+)
        (sirius/init-diff-hl)
        (sirius/init-all-the-icons-dired)
        (sirius/init-dired-git-info)
        (sirius/init-dired-quick-sort)
        (sirius/init-diredfl)
        )
      )
  )

(defun sirius/init-dired-base ()
  (use-package dired
    ;; :defer t
    :ensure nil
    :config
    :bind
    (
     :map dired-mode-map
     ("j" . 'sirius/move-down)
     ("k" . 'sirius/move-up)
     ("-" . 'sirius/up-directory)
     ("0" . 'dired-back-to-start-of-files)
    ;;  ("gg" . 'sirius/back-to-top)
     ("G" . 'sirius/jump-to-bottom)

     ("I" . 'sirius/dotfiles-toggle)
     ("=" . 'sirius/dired-diff)

    ;;  ("RET" . '(
              ;;  if vinegar-reuse-dired-buffer
              ;;  'dired-find-alternate-file
              ;;  'dired-find-file
              ;;  ))
     
    ;;  ("~" . '(lambda ()(interactive) (find-alternate-file "~/")))

     ("J" . 'dired-goto-file)
     ("H" . 'diredp-dired-recent-dirs)
     ("T" . 'dired-tree-down)
     ("K" . 'dired-do-kill-lines)
     ("r" . 'revert-buffer)


     ("C-j" . 'dired-next-subdir)
     ("C-k" . 'dired-prev-subdir)
     ("C-f" . 'dired-find-file)
     ("C-r" . 'dired-do-redisplay)
     )
    )
  )

(defun sirius/init-dired+ ()
  (use-package dired+
    :defer t
    :init
    (progn
      (setq diredp-hide-details-initially-flag t)
      (setq diredp-hide-details-propagate-flag t)
      ;; use single buffer for all dired navigation
      ;; disable font themeing from dired+
      (setq font-lock-maximum-decoration (quote ((dired-mode . 1) (t . t))))
      (toggle-diredp-find-file-reuse-dir 1)
      )
    )
  )

(defun sirius/init-diff-hl ()
  (use-package diff-hl
    :defer t
    :hook (dired-mode . diff-hl-dired-mode)
    )
  )

(defun sirius/init-dired-quick-sort ()
  (use-package dired-quick-sort)
  )

(defun sirius/init-dired-git-info ()
  (use-package dired-git-info
    :bind (
           :map dired-mode-map
           ("C-g" . dired-git-info-mode)
           )
    )
  )

(defun sirius/init-diredfl ()
  (use-package diredfl
    :init (diredfl-global-mode)
    )
  )

(defun sirius/init-all-the-icons-dired ()
    (use-package all-the-icons-dired
      :hook (dired-mode . all-the-icons-dired-mode)
      :config
      (with-no-warnings
        (advice-add #'dired-do-create-files :around #'all-the-icons-dired--refresh-advice)
        (advice-add #'dired-create-directory :around #'all-the-icons-dired--refresh-advice)
        (advice-add #'wdired-abort-changes :around #'all-the-icons-dired--refresh-advice))

      (with-no-warnings
        (defun my-all-the-icons-dired--refresh ()
          "Display the icons of files in a dired buffer."
          (all-the-icons-dired--remove-all-overlays)
          ;; NOTE: don't display icons it too many items
          (if (<= (count-lines (point-min) (point-max)) 1000)
              (save-excursion
                (goto-char (point-min))
                (while (not (eobp))
                  (when (dired-move-to-filename nil)
                    (let ((file (file-local-name (dired-get-filename 'relative 'noerror))))
                      (when file
                        (let ((icon (if (file-directory-p file)
                                        (all-the-icons-icon-for-dir file
                                                                    :face 'all-the-icons-dired-dir-face
                                                                    :height 0.9
                                                                    :v-adjust all-the-icons-dired-v-adjust)
                                      (all-the-icons-icon-for-file file :height 0.9 :v-adjust all-the-icons-dired-v-adjust))))
                          (if (member file '("." ".."))
                              (all-the-icons-dired--add-overlay (point) "  \t")
                            (all-the-icons-dired--add-overlay (point) (concat icon "\t")))))))
                  (forward-line 1)))
            (message "Not display icons because of too many items.")))
        (advice-add #'all-the-icons-dired--refresh :override #'my-all-the-icons-dired--refresh))
      )
  )

;;--------------------Functions-----------------------
(defun sirius/dotfiles-toggle ()
  "Show/hide dot-files"
  (interactive)
  (when (equal major-mode 'dired-mode)
    (if (or (not (boundp 'dired-dotfiles-show-p)) dired-dotfiles-show-p) ; if currently showing
        (progn
          (set (make-local-variable 'dired-dotfiles-show-p) nil)
          (message "h")
          (dired-mark-files-regexp "^\\\.")
          (dired-do-kill-lines))
      (progn (revert-buffer) ; otherwise just revert to re-show
             (set (make-local-variable 'dired-dotfiles-show-p) t)))))

(defun sirius/back-to-top ()
  "Move to first file"
  (interactive)
  (beginning-of-buffer)
  (dired-next-line 1))

(defun sirius/jump-to-bottom ()
  "Move to last file"
  (interactive)
  (end-of-buffer)
  (dired-next-line -1))

(defun sirius/move-up ()
  "Move to previous file"
  (interactive)
  (dired-previous-line 1)
  (if (bobp)
      (dired-next-line 1)))

(defun sirius/move-down ()
  "Move to next file"
  (interactive)
  (dired-next-line 1)
  (if (eobp)
      (dired-next-line -1)))

(defun sirius/up-directory (&optional other-window)
  "Run Dired on parent directory of current directory."
  (interactive "P")
  (let* ((dir (dired-current-directory))
         (orig (current-buffer))
         (up (file-name-directory (directory-file-name dir))))
    (or (dired-goto-file (directory-file-name dir))
        ;; Only try dired-goto-subdir if buffer has more than one dir.
        (and (cdr dired-subdir-alist)
             (dired-goto-subdir up))
        (progn
          (kill-buffer orig)
          (dired up)
          (dired-goto-file dir)))))

(defun sirius/dired-diff ()
  "Ediff marked files in dired or selected files in separate window"
  (interactive)
  (let* ((marked-files (dired-get-marked-files nil nil))
        (other-win (get-window-with-predicate
                    (lambda (window)
                      (with-current-buffer (window-buffer window)
                        (and (not (eq window (selected-window)))
                             (eq major-mode 'dired-mode))))))
        (other-marked-files (and other-win
                                 (with-current-buffer (window-buffer other-win)
                                   (dired-get-marked-files nil)))))
    (cond ((= (length marked-files) 2)
           (ediff-files (nth 0 marked-files)
                        (nth 1 marked-files)))
          ((= (length marked-files) 3)
           (ediff-files3 (nth 0 marked-files)
                         (nth 1 marked-files)
                         (nth 2 marked-files)
                         ))
          ((and (= (length marked-files) 1)
                (= (length other-marked-files) 1))
           (ediff-files (nth 0 marked-files)
                        (nth 0 other-marked-files)))
          ((= (length marked-files) 1)
           (dired-diff))
          (t (error "mark exactly 2 files, at least 1 locally")))))


(defun sirius/dired-setup ()
  "Setup custom dired settings for sirius"
  (setq dired-omit-verbose nil)
  (make-local-variable 'dired-hide-symlink-targets)
  (setq dired-hide-details-hide-symlink-targets nil)

  ;; hide details by default
  (if sirius-dired-hide-details (dired-hide-details-mode t))
  ;; omit the .. in dired
  (dired-omit-mode t)

  ;; allow selection with mouse
  (make-local-variable 'mouse-1-click-follows-link)
  (setq mouse-1-click-follows-link nil)

  (local-set-key (kbd  "<mouse-1>") 'sirius/dired-mouse-click)
  (local-set-key (kbd  "<mouse-3>") 'sirius/up-directory)
  (local-set-key (kbd  "<down-mouse-3>") nil)
  )

(defun sirius/dired-mouse-click (event)
  "In Dired, visit the file or directory name you click on."
  (interactive "e")
  (let (window pos file)
    (save-excursion
      (setq window (posn-window (event-end event))
            pos (posn-point (event-end event)))
      (if (not (windowp window))
          (error "No file chosen"))
      (set-buffer (window-buffer window))
      (goto-char pos)
      (setq file (dired-get-file-for-visit)))
    (find-alternate-file file)))

(defun sirius/dired-mouse-click-3 (event)
  "In Dired, show context menu or go up a directory."
  (interactive "e")
  (let (window pos file)
    (save-excursion
      (setq window (posn-window (event-end event))
            pos (posn-point (event-end event)))
      (if (not (windowp window))
          (error "No file chosen"))
      (set-buffer (window-buffer window))
      (goto-char pos)
      (condition-case-unless-debug ex
          (progn
            (setq file (dired-get-file-for-visit))
            (dired-find-file-other-window))
        ('error
         (sirius/up-directory)
         ))
    )))
;; 

(defvar sirius-reuse-dired-buffer nil
  "If non-nil, reuses one dired buffer for navigation.")

(defvar sirius--dired-hide-details t
  "If non-nil, enable dired hide details mode.")






(provide 'sirius-dired)
