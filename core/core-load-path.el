(defun add-to-load-path (dir)
    (add-to-list 'load-path dir)
)


;;-------Directroies
(defconst sirius-core-dir (
    expand-file-name (concat user-emacs-directory "core/"))
    "Sirius Core Directory." 
    )

(defconst sirius-utils-dir (
    expand-file-name (concat user-emacs-directory "utils/"))
    "Sirius Utils Directory." 
    )

(defconst sirius-base-dir (
    expand-file-name (concat user-emacs-directory "base/"))
    "Sirius Base Directory." 
    )

(defconst sirius-lang-dir (
    expand-file-name (concat user-emacs-directory "lang/"))
    "Sirius Languages Directory." 
    )

(defconst sirius-elpa-dir (
    expand-file-name (concat user-emacs-directory "elpa/"))
    "Sirius Epla Directory." 
    )

(defconst sirius-elpa-version-dir (
    expand-file-name (concat sirius-elpa-dir emacs-version "/"))
)

(defconst sirius-cache-dir (
    expand-file-name (concat user-emacs-directory ".cache/"))
    "Sirius Cache Directory." 
    )

(mapc 'add-to-load-path `(
    ,sirius-core-dir,sirius-base-dir,sirius-utils-dir
    ,sirius-elpa-dir,sirius-lang-dir,sirius-cache-dir
    ,sirius-elpa-version-dir
))

(provide 'core-load-path)



