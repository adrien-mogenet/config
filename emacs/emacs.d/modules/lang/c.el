;; DOXYGEN
;; Enable Doxygen syntax highlighting for C and C++
;; (require 'doxymacs)

(add-hook
 'font-lock-mode-hook
 '(lambda ()
    (if (or
         (eq major-mode 'c-mode)
         (or
          (eq major-mode 'c++-mode)
          (eq major-mode 'javascript-mode)))
        (doxymacs-font-lock))))

;; C HOOKS
;; add header guard
(defun insert-header-guard ()
  (interactive)
  (save-excursion
    (when (buffer-file-name)
      (let*
          (
           (name (file-name-nondirectory buffer-file-name))
           (macro (replace-regexp-in-string "\\." "_" (upcase name)))
           (macro (replace-regexp-in-string "-" "_" macro))
           (macro (concat macro "_"))
           )
        (goto-char (point-min))
        (insert "#ifndef " macro "\n")
        (insert "# define " macro "\n\n")
        (goto-char (point-max))
        (insert "\n#endif /* !" macro " */\n")
        )
      )
    )
  )

;; AUTO INSERT C/C++ HEADER GUARD
(add-hook 'find-file-hooks
          (lambda ()
            (when (and (memq major-mode '(c-mode c++-mode)) (equal (point-min) (point-max)) (string-match ".*\\.hh?" (buffer-file-name)))
              (insert-header-guard)
              (goto-line 3)
              (insert "\n"))))

;; C / C++ MODE
(require 'cc-mode)
(add-to-list 'c-style-alist
             '("checkstyle"
               (c-basic-offset . 2)
               (c-comment-only-line-offset . 0)
               (c-hanging-braces-alist     . ((substatement-open before after)))
               (c-offsets-alist . ((topmost-intro        . 0)
                                   (substatement         . +)
                                   (substatement-open    . 0)
                                   (case-label           . +)
                                   (access-label         . -)
                                   (inclass              . ++)
                                   (inline-open          . 0)))))
(setq c-default-style "checkstyle")

(defun c-insert-braces (&optional r)
  (interactive "P")
  (c-insert-block r))

(defun c-insert-ns (name r)
  (interactive "sName: \nP")
  (c-insert-block r (concat "namespace " name "\n")))

(defun c-insert-switch (value r)
  (interactive "sValue: \nP")
  (c-insert-block r (concat "switch (" value ")\n")))

(defun c-insert-if (c r)
  (interactive "sCondition: \nP")
  (c-insert-block r (concat "if (" c ")\n")))

(defun c-insert-class (name)
  (interactive "sName: ")
  (c-insert-block () (concat "class " name "\n") ";")
  (insert "public:")
  (c-indent-line)
  (insert "\n")
  (c-indent-line))
