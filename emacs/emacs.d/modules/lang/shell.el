;; SHELL
(defun insert-shell-shebang ()
  (interactive)
  (when (buffer-file-name)
    (goto-char (point-min))
    (insert "#!/bin/sh\n\n")))
