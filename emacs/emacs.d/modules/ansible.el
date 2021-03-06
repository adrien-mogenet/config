;;; ansible.el --- Ansible minor mode
;; -*- Mode: Emacs-Lisp -*-

;; Copyright (C) 2014 by 101000code/101000LAB

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program; if not, write to the Free Software
;; Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA

;; Version: 0.0.3
;; Author: k1LoW (Kenichirou Oyama), <k1lowxb [at] gmail [dot] com> <k1low [at] 101000lab [dot] org>
;; URL: http://101000lab.org
;; Package-Requires: ((s "1.9.0") (f "0.16.2"))

;;; Install
;; Put this file into load-path'ed directory, and byte compile it if
;; desired.  And put the following expression into your ~/.emacs.
;;
;; (require 'ansible)
;;
;; If you use default key map, Put the following expression into your ~/.emacs.
;;
;; (ansible::set-default-keymap)

;;; Commentary:

;;; Commands:
;;
;; Below are complete command list:
;;
;;  `ansible'
;;    Ansible minor mode.
;;
;;; Customizable Options:
;;
;; Below are customizable option list:
;;
;;  `ansible::dir-search-limit'
;;    Search limit
;;    default = 5

;;; Code:

;;require
;(require 's)
;(require 'f)
(eval-when-compile (require 'cl))
(require 'easy-mmode)

(defgroup ansible nil
  "Ansible minor mode"
  :group 'languages
  :prefix "ansible::")

(defcustom ansible::dir-search-limit 5
  "Search limit"
  :type 'integer
  :group 'ansible)

(defcustom ansible::vault-password-file "~/.vault_pass.txt"
  "Filename containing ansible-vault password"
  :type 'file
  :group 'ansible)

;;;###autoload
(defvar ansible::key-map
  (make-sparse-keymap)
  "Keymap for Ansible.")

(defvar ansible::root-path nil
  "Ansible spec directory path.")

(defvar ansible::hook nil
  "Hook.")

;;;###autoload
(define-minor-mode ansible
  "Ansible minor mode."
  :lighter " Ansible"
  :group 'ansible
  (if ansible
      (progn
        (setq minor-mode-map-alist
              (cons (cons 'ansible ansible::key-map)
                    minor-mode-map-alist))
        (ansible::dict-initialize)
        (run-hooks 'ansible::hook))
    nil))

(defun ansible::update-root-path ()
  "Update ansible::root-path"
  (let ((spec-path (ansible::find-root-path)))
    (unless (not spec-path)
      (setq ansible::root-path spec-path))
    (when ansible::root-path t)))

(defun ansible::find-root-path ()
  "Find ansible directory."
  (let ((current-dir (f-expand default-directory)))
    (loop with count = 0
          until (f-exists? (f-join current-dir "roles"))
          ;; Return nil if outside the value of
          if (= count ansible::dir-search-limit)
          do (return nil)
          ;; Or search upper directories.
          else
          do (incf count)
          (unless (f-root? current-dir)
            (setq current-dir (f-dirname current-dir)))
          finally return current-dir)))

(defun ansible::list-playbooks ()
  (if (ansible::update-root-path)
      (mapcar
       (lambda (file) (f-relative file ansible::root-path))
       (f-files ansible::root-path (lambda (file) (s-matches? ".yml" (f-long file))) t))
    nil))

(defun ansible::vault-buffer (mode)
  (let* ((input (buffer-substring-no-properties (point-min) (point-max)))
         (output (ansible::vault mode input)))
    (delete-region (point-min) (point-max))
    (insert output)))

(defun ansible::get-string-from-file (file-path)
  "Return FILE-PATH's file content."
  (with-temp-buffer
    (insert-file-contents file-path)
    (buffer-string)))

(defun ansible::vault (mode str)
  (let ((temp-file (make-temp-file "ansible-vault-ansible")))
    (write-region str nil temp-file 'append)
    (let* ((command (format "ansible-vault %s --vault-password-file=%s %s" mode ansible::vault-password-file temp-file))
           (status (shell-command command))
           (output (ansible::get-string-from-file temp-file)))
      (if (/= status 0)
          (error "Error in ansible-vault running %s!" command)
        (delete-file temp-file)
        output))))

(defun ansible::decrypt-buffer ()
  (interactive)
  (ansible::vault-buffer "decrypt"))

(defun ansible::encrypt-buffer ()
  (interactive)
  (ansible::vault-buffer "encrypt"))

(defconst ansible::dir (file-name-directory (or load-file-name
						buffer-file-name)))

(defun ansible::auto-decrypt-encrypt ()
  "Decrypt current buffer if it is a vault encrypted file.
Also, automatically encrypts the file before saving the buffer."
  (let ((vault-file? (string-match-p "\$ANSIBLE_VAULT;[0-9]+\.[0-9]+"
                                     (buffer-substring-no-properties (point-min)
                                                                     (point-max)))))
    (when vault-file?
      (condition-case ex
          (progn
            (ansible::decrypt-buffer)
            (add-hook 'before-save-hook 'ansible::encrypt-buffer nil t)
            (add-hook 'after-save-hook  'ansible::decrypt-buffer nil t))
        ('error
         (message "Could not decrypt file. Make sure `ansible::vault-password-file' is correctly set"))))))

;;;###autoload
(defun ansible::snippets-initialize ()
  (let ((snip-dir (expand-file-name "snippets" ansible::dir)))
    (add-to-list 'yas-snippet-dirs snip-dir t)
    (yas-load-directory snip-dir)))

;;;###autoload
(eval-after-load 'yasnippet
  '(ansible::snippets-initialize))

;;;###autoload
(defun ansible::dict-initialize ()
  (let ((dict-dir (expand-file-name "dict" ansible::dir)))
    (when (and (f-directory? dict-dir) (boundp 'ac-user-dictionary-files))
      (add-to-list 'ac-user-dictionary-files (f-join dict-dir "ansible") t))))

(provide 'ansible)

;;; end
;;; ansible.el ends here
