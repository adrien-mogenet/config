
;; ----------------------------------------------------------------------------
;; BINDINGS
;; ----------------------------------------------------------------------------

;; Define functions to resize windows

(defun win-resize-top-or-bot ()
  "Figure out if the current window is on top, bottom or in the
middle"
  (let* ((win-edges (window-edges))
         (this-window-y-min (nth 1 win-edges))
         (this-window-y-max (nth 3 win-edges))
         (fr-height (frame-height)))
    (cond
     ((eq 0 this-window-y-min) "top")
     ((eq (- fr-height 1) this-window-y-max) "bot")
     (t "mid"))))

(defun win-resize-left-or-right ()
  "Figure out if the current window is to the left, right or in the
middle"
  (let* ((win-edges (window-edges))
         (this-window-x-min (nth 0 win-edges))
         (this-window-x-max (nth 2 win-edges))
         (fr-width (frame-width)))
    (cond
     ((eq 0 this-window-x-min) "left")
     ((eq (+ fr-width 4) this-window-x-max) "right")
     (t "mid"))))

(defun win-resize-enlarge-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window -1))
   (t (message "nil"))))

(defun win-resize-minimize-horiz ()
  (interactive)
  (cond
   ((equal "top" (win-resize-top-or-bot)) (enlarge-window 1))
   ((equal "bot" (win-resize-top-or-bot)) (enlarge-window -1))
   ((equal "mid" (win-resize-top-or-bot)) (enlarge-window 1))
   (t (message "nil"))))

(defun win-resize-enlarge-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right))
    (enlarge-window-horizontally -1))
   ((equal "right" (win-resize-left-or-right))
    (enlarge-window-horizontally 1))
   ((equal "mid" (win-resize-left-or-right))
    (enlarge-window-horizontally -1))))

(defun win-resize-minimize-vert ()
  (interactive)
  (cond
   ((equal "left" (win-resize-left-or-right))
    (enlarge-window-horizontally 1))
   ((equal "right" (win-resize-left-or-right))
    (enlarge-window-horizontally -1))
   ((equal "mid" (win-resize-left-or-right))
    (enlarge-window-horizontally 1))))


;; Functions to move lines up and down

(defun move-line-up ()
  (interactive)
  (transpose-lines 1)
  (forward-line -2))

(defun move-line-down ()
  (interactive)
  (forward-line 1)
  (transpose-lines 1)
    (forward-line -1))


;; BINDINGS :: isearch
(global-set-key [(control f)] 'isearch-forward-regexp)  ; search regexp
(global-set-key [(control r)] 'query-replace-regexp)    ; replace regexp
(define-key isearch-mode-map [(control n)] 'isearch-repeat-forward) ; next occurence
(define-key isearch-mode-map [(control p)] 'isearch-repeat-backward); previous occurence
(define-key isearch-mode-map [(control z)] 'isearch-cancel)         ; quit and go back to start point
(define-key isearch-mode-map [(control f)] 'isearch-exit)           ; abort
(define-key isearch-mode-map [(control r)] 'isearch-query-replace)  ; switch to replace mode
(define-key isearch-mode-map [S-insert] 'isearch-yank-kill)         ; paste
(define-key isearch-mode-map [(control e)] 'isearch-toggle-regexp)  ; toggle regexp
(define-key isearch-mode-map [(control l)] 'isearch-yank-line)      ; yank line from buffer
(define-key isearch-mode-map [(control w)] 'isearch-yank-word)      ; yank word from buffer
(define-key isearch-mode-map [(control c)] 'isearch-yank-char)      ; yank char from buffer

;; BINDINGS :: misc
(global-set-key [(control z)] 'undo)           ; undo
(global-set-key [C-home] 'beginning-of-buffer) ; go to the beginning of buffer
(global-set-key [C-end] 'end-of-buffer)        ; go to the end of buffer
(global-set-key [(meta g)] 'goto-line)         ; goto line #
(define-key input-decode-map "\e\eOA" [(meta up)])
(define-key input-decode-map "\e\eOB" [(meta down)])
(global-set-key [(meta up)] 'move-line-up)
(global-set-key [(meta down)] 'move-line-down)

;; BINDINGS :: resizing windows
(global-set-key (kbd "C-x C-<up>") 'win-resize-enlarge-horiz)
(global-set-key (kbd "C-x C-<down>") 'win-resize-minimize-horiz)
(global-set-key (kbd "C-x C-<left>") 'win-resize-enlarge-vert)
(global-set-key (kbd "C-x C-<right>") 'win-resize-minimize-vert)

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
