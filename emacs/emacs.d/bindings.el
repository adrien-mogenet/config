
;; ----------------------------------------------------------------------------
;; BINDINGS
;; ----------------------------------------------------------------------------

;; BINDINGS :: isearch
(global-set-key [(control f)] 'isearch-forward-regexp)  ; search regexp
(global-set-key [(control r)] 'query-replace-regexp)    ; replace regexp
(define-key
 isearch-mode-map
 [(control n)]
 'isearch-repeat-forward)                              ; next occurence
(define-key
 isearch-mode-map
 [(control p)]
 'isearch-repeat-backward)                             ; previous occurence
(define-key
 isearch-mode-map
 [(control z)]
 'isearch-cancel)                                      ; quit and go back to start point
(define-key
 isearch-mode-map
 [(control f)]
 'isearch-exit)                                        ; abort
(define-key
 isearch-mode-map
 [(control r)]
 'isearch-query-replace)                               ; switch to replace mode
(define-key
 isearch-mode-map
 [S-insert]
 'isearch-yank-kill)                                   ; paste
(define-key
 isearch-mode-map
 [(control e)]
 'isearch-toggle-regexp)                               ; toggle regexp
(define-key
 isearch-mode-map
 [(control l)]
 'isearch-yank-line)                                   ; yank line from buffer
(define-key
 isearch-mode-map
 [(control w)]
 'isearch-yank-word)                                   ; yank word from buffer
(define-key
 isearch-mode-map
 [(control c)]
 'isearch-yank-char)                                   ; yank char from buffer

;; BINDINGS :: misc
(global-set-key [(control z)] 'undo)                    ; undo
(global-set-key [C-home] 'beginning-of-buffer)          ; go to the beginning of buffer
(global-set-key [C-end] 'end-of-buffer)                 ; go to the end of buffer
(global-set-key [(meta g)] 'goto-line)                  ; goto line #
(global-set-key [(control tab)] 'other-window)          ; Ctrl-Tab = Next buffer
(global-set-key [C-S-iso-lefttab]
                '(lambda () (interactive)
                   (other-window -1)))                  ; Ctrl-Shift-Tab = Previous buffer
(global-set-key [f12] 'replace-string)

;; BINDINGS :: for use within terminal
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>") 'windmove-up)
(global-set-key (kbd "C-c <left>") 'windmove-left)
(global-set-key (kbd "C-c <down>") 'windmove-down)
(global-set-key (kbd "M-DEL") 'backward-kill-word)

;; BINDINGS :: compile
(global-set-key [f8] 'previous-error)
(global-set-key [f9] 'next-error)
(global-set-key [f10] 'recompile)
(global-set-key [f11] 'compile)

;; BINDINGS :: font size
(global-set-key [(control +)] 'inc-font-size)
(global-set-key [(control =)] 'reset-font-size)

;; BINDINGS :: ido
(global-set-key [(control b)] 'ido-switch-buffer)

;; BINDINGS :: indent
(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))
(global-set-key (kbd "M-\\") 'iwb)

;; BINDINGS :: company
(global-set-key [(control o)] 'company-complete)
