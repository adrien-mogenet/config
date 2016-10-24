(require 'package)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-eshell
                      clojure-mode
                      rainbow-mode
                      clojure-test-mode
                      cider))

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(auto-save-file-name-transforms (quote ((".*" "~/.emacs.d/autosaves/\\1" t))))
 '(backup-directory-alist (quote ((".*" . "~/.emacs.d/backups/"))))
 '(column-number-mode t)
 '(ecb-options-version "2.32")
 '(mac-font-panel-mode nil)
 '(mac-input-method-mode nil)
 '(menu-bar-mode nil)
 '(ns-antialias-text nil)
 '(transient-mark-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-comment-face ((t (:foreground "MediumAquamarine"))))
 '(font-lock-doc-face ((t (:inherit font-lock-string-face :foreground "keyboardFocusIndicatorColor"))))
 '(font-lock-doc-string-face ((t (:foreground "green2"))))
 '(font-lock-function-name-face ((t (:bold t :foreground "Orchid"))))
 '(font-lock-string-face ((t (:foreground "gridColor"))))
 '(isearch ((t (:background "Yellow" :foreground "brown4"))))
 '(lazy-highlight ((t (:background "Brown"))))
 '(linum ((t (:inherit (shadow default) :background "#212121" :foreground "#444"))))
 )
