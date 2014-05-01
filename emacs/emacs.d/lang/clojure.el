
;; Clojure options
(setq nrepl-buffer-name-separator "-")
;; Enable eldoc in Clojure buffers:
(add-hook 'cider-mode-hook 'cider-turn-on-eldoc-mode)
;; Hide REPL
; (setq nrepl-hide-special-buffers t)
;; Stop the error buffer from popping up while working in buffers
;; other than the REPL:
(setq cider-popup-stacktraces nil)
;; To auto-select the error buffer when it's displayed:
(setq cider-auto-select-error-buffer t)
;; Make C-c C-z switch to the CIDER REPL buffer in the current window:
(setq cider-repl-display-in-current-window t)
;; Limit the number of items of each collection the printer will print to 100:
(setq cider-repl-print-length 100) ; the default is nil, no limit
;; Prevent C-c C-k from prompting to save the file corresponding to
;; the buffer being loaded, if it's modified:
(setq cider-prompt-save-file-on-load nil)
;; Change the result prefix for REPL evaluation (by default there's no
;; prefix):
; (set cider-repl-result-prefix ";; => ")
;; Enabling CamelCase support for editing commands(like forward-word,
;; backward-word, etc) in the REPL is quite useful since we often have
;; to deal with Java class and methodl names. the built-in emacs minor
;; mode subword-mode  provides such functionality:
(add-hook 'cider-repl-mode-hook 'subword-mode)
(add-hook 'cider-repl-mode-hook 'paredit-mode)
(add-hook 'cider-repl-mode-hook 'rainbow-delimiters-mode)
