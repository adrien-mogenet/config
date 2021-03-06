(when (display-graphic-p)               ; if graphic
;  (scroll-bar-mode -1)                  ; no scroll bar
  (mouse-wheel-mode t)                  ; enable mouse wheel
  (tool-bar-mode -1)                    ; no tool bar
  )

(setq inhibit-startup-message t)        ; don't show the GNU splash screen
(setq frame-title-format "%b")          ; titlebar shows buffer's name
(global-font-lock-mode t)               ; syntax highlighting
(setq font-lock-maximum-decoration t)   ; max decoration for all modes
(setq transient-mark-mode 't)           ; highlight selection
(setq line-number-mode 't)              ; line number
(setq column-number-mode 't)            ; column number
(menu-bar-mode nil)                     ; no menu bar
;(scroll-bar-mode -1)
(setq scroll-step 1)                    ; smooth scrolling

;; DISPLAY COLORS

;; (set-face-attribute 'hl-line nil
;;                     :background "#1d2743"
;;                     :foreground nil
;;                     :inherit t)

;; Custom color for region selection
(set-face-attribute 'region nil
                    :background "#666"
                    :foreground "#fff")

(progn
  (set-background-color "black")
  (set-foreground-color "white")
  (set-cursor-color "Orangered")
  (custom-set-faces
   ;; custom-set-faces was added by Custom.
   ;; If you edit it by hand, you could mess it up, so be careful.
   ;; Your init file should contain only one such instance.
   ;; If there is more than one, they won't work right.
   ))
(set-face-foreground 'font-lock-string-face "white")
(set-face-foreground 'font-lock-comment-face "orange")
(global-hl-line-mode 1)
(set-face-background 'hl-line "gray15")

;; DISPLAY FONT
(setq default-font-size 135)
(defun set-font-size (&optional size)
  "Set the font size to SIZE (default: default-font-size)."
  (interactive "nSize: ")
  (unless size
    (setq size default-font-size))
  (set-face-attribute 'default nil :height size))
(defun reset-font-size ()
  (interactive)
  (set-font-size))
(defun find-next (c l)
    (if (< c (car l))
        (car l)
      (if (cdr l)
          (find-next c (cdr l))
        (car l))))
(defun inc-font-size ()
  (interactive)
  (let ((sizes '(60 75 90 105 120 135 170 280))
        (current (face-attribute 'default :height)))
    (let ((new (find-next current sizes)))
      (set-font-size new)
      (message (int-to-string new)))))
(set-font-size)
