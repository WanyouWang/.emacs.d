
(defun org/init-org ()
  (if (not sirius-dumped)
      (progn
        (sirius/init-org-base)
        ;; (sirius/init-org-super-star)
        (sirius/init-toc-org)
        (sirius/init-org-bullets)
        (sirius/init-org-fancy-priorities)
        (sirius/init-org-src)
        (sirius/init-org-pomodoro)
        )
    )
  )

(defun sirius/init-org-base ()
  (use-package org
    :diminish (org-mode . " Ⓞ ")
    :hook (org-mode . linum-relative-toggle)
    :commands (
               org-clock-out
               org-occur-in-agenda-files
               org-agenda-files
               )
    :init
    (setq org-startup-with-inline-images t
          org-src-fontify-natively t
          ;; this is consistent with the value of
          ;; `helm-org-headings-max-depth'.
          org-imenu-depth 8)
    :config

    ;; :bind (
    ;;        :map org-mode-map
    ;;        ("RET" . 'org-open-at-point)
    ;;        )
    )
  )

(defun sirius/init-org-super-star ()
  (use-package org-super-star
    :defer t
    :hook (org-mode . org-superstar-mode)
    )
  )

(defun sirius/init-toc-org ()
  (use-package toc-org
    :defer t
    :hook (org-mode . toc-org-enable)
    :init
    (setq toc-org-max-depth 10)
    )
  )

(defun sirius/init-org-bullets ()
  (use-package org-bullets
    :if (char-displayable-p ?⚫)
    :hook (org-mode . org-bullets-mode)
    :init (setq org-bullets-bullet-list '("⚫" "⚫" "⚫" "⚫"))
    )
  )

(defun sirius/init-org-fancy-priorities ()
  (use-package org-fancy-priorities
    :diminish
    :hook (org-mode . org-fancy-priorities-mode)
    :init (setq org-fancy-priorities-list
                (if (char-displayable-p ?⯀)
                    '("⯀" "⯀" "⯀" "⯀")
                  '("HIGH" "MEDIUM" "LOW" "OPTIONAL")
                  )
                )
    )
  )

(defun sirius/init-org-src ()
  (setq org-confirm-babel-evaluate nil
        org-src-fontify-natively t
        org-src-tab-acts-natively t)

  (defvar load-language-list '((emacs-lisp . t)
                               (perl . t)
                               (python . t)
                               (ruby . t)
                               (js . t)
                               (css . t)
                               (sass . t)
                               (C . t)
                               (java . t)
                               (plantuml . t)
                               )
    )
  )

(defun sirius/init-org-pomodoro ()
  ;; Pomodoro
  (use-package org-pomodoro
    :custom-face
    (org-pomodoro-mode-line ((t (:inherit warning))))
    (org-pomodoro-mode-line-overtime ((t (:inherit error))))
    (org-pomodoro-mode-line-break ((t (:inherit success))))
    :bind (:map org-agenda-mode-map
                ("P" . org-pomodoro)
                )
    )
  )

(provide 'sirius-org)
