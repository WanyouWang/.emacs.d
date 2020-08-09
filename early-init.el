(setq package-enable-at-startup nil)

;;gc
(defvar best-gc-cons-threshold
  4000000
  "Best default gc threshold value.  Should NOT be too big!")
(setq gc-cons-threshold most-positive-fixnum)

(unless (and (display-graphic-p) (eq system-type 'darwin))
  (push '(menu-bar-lines . 0) default-frame-alist))
(push '(tool-bar-lines . 0) default-frame-alist)
(push '(vertical-scroll-bars) default-frame-alist)
(push '(fullscreen . fullscreen) default-frame-alist) 