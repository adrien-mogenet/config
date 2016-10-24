;;; tickscript-mode.el --- Major mode for TICKscript scripts -*- lexical-binding: t; -*-

;; Copyright (C) 2016  Andrea Leopardi <andrea@leopardi.me>

;; Author: Andrea Leopardi <andrea@leopardi.me>
;; Maintainer: Andrea Leopardi <andrea@leopardi.me>
;; URL: https://github.com/whatyouhide/tickscript-mode
;; Keywords: languages
;; Version: 0.1
;; Package-Requires: ((emacs "24.3") (pkg-info "0.1"))

;; This file is not part of GNU Emacs.

;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;; This file incorporates work covered by the following copyright and
;; permission notice:

;;   Licensed under the Apache License, Version 2.0 (the "License"); you may not
;;   use this file except in compliance with the License.  You may obtain a copy
;;   of the License at
;;
;;       http://www.apache.org/licenses/LICENSE-2.0
;;
;;   Unless required by applicable law or agreed to in writing, software
;;   distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
;;   WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
;;   License for the specific language governing permissions and limitations
;;   under the License.

;;; Commentary:

;; GNU Emacs major mode for editing TICKscript
;; (https://docs.influxdata.com/kapacitor/v0.11/tick/) scripts.

;; Only provides syntax highlighting (for now).

;;; Code:

;; Helper functions

(defun tickscript--wordify-regexp (regexp)
  (concat "\\<\\(" regexp "\\)\\>"))

;; Syntax table

(defconst tickscript-mode-syntax-table
  (let ((table (make-syntax-table)))
    ;; ' is a string delimiter
    (modify-syntax-entry ?' "\"" table)
    ;; " is a string delimiter too
    (modify-syntax-entry ?\" "\"" table)
    ;; / is punctuation, but // is a comment starter
    (modify-syntax-entry ?/ ". 12" table)
    ;; \n is a comment ender
    (modify-syntax-entry ?\n ">" table)
    table))

;; Elements

(setq-local tickscript-constants '("TRUE" "FALSE" "stream" "batch"))

(setq-local tickscript-duration-units '("u" "µ" "ms" "s" "m" "h" "d" "w"))

(setq-local tickscript-keywords '("var"))

(setq-local tickscript-operators '("+" "-" "*" "/" "=" "==" "!=" ">" "<" ">=" "<=" "AND" "OR"))

(setq-local tickscript-builtin-functions
      '("alert" "bottom" "cluster" "count" "cron" "database" "deadman"
        "derivative" "distinct" "eval" "every" "fill" "first" "from"
        "groupBy" "httpOut" "influxDBOut" "join" "last" "mapReduce" "max"
        "mean" "measurement" "median" "min" "offset" "percentile" "period"
        "retentionPolicy" "sample" "shift" "spread" "stats" "stddev" "sum"
        "top" "truncate" "union" "where" "window"))

;; Regexps

(setq-local tickscript-constants-regexp
      (regexp-opt tickscript-constants 'words))

(setq-local tickscript-numbers-regexp
      (tickscript--wordify-regexp "[[:digit:]]+"))

(setq-local tickscript-time-unit-regexp
      (tickscript--wordify-regexp (concat "[[:digit:]]+"
                                          (regexp-opt tickscript-duration-units))))

(setq-local tickscript-keywords-regexp
      (regexp-opt tickscript-keywords 'words))

(setq-local tickscript-operators-regexp
      (regexp-opt tickscript-operators))

(setq-local tickscript-parens-regexp "(\\|)")

(setq-local tickscript-builtin-functions-regexp
      (regexp-opt tickscript-builtin-functions 'words))

(setq-local tickscript-functions-regexp "\\.\\(\\w+\\)(")

(setq-local tickscript-lambda-regexp "(\\(lambda:\\)[[:space:]]")

(setq-local tickscript-dot-regexp "\\.")

(setq tickscript-font-lock-keywords
      `(
        (,tickscript-lambda-regexp 1 font-lock-preprocessor-face)
        (,tickscript-constants-regexp 0 font-lock-constant-face)
        (,tickscript-time-unit-regexp 0 font-lock-constant-face)
        (,tickscript-numbers-regexp 0 font-lock-preprocessor-face)
        (,tickscript-keywords-regexp 0 font-lock-keyword-face)
        (,tickscript-operators-regexp 0 font-lock-constant-face)
        (,tickscript-builtin-functions-regexp 0 font-lock-builtin-face)
        (,tickscript-functions-regexp  1 font-lock-function-name-face)
        (,tickscript-parens-regexp 0 font-lock-comment-delimiter-face)
        (,tickscript-dot-regexp 0 font-lock-string-face)
        ))

;;;###autoload
(define-derived-mode tickscript-mode prog-mode "TICKscript"
  "Major mode for editing TICKscript code."
  :syntax-table tickscript-mode-syntax-table
  (set (make-local-variable 'font-lock-defaults)
       '((tickscript-font-lock-keywords) nil nil))
  (set (make-local-variable 'comment-start) "// ")
  (set (make-local-variable 'comment-end) "")
  (set (make-local-variable 'commend-start-skip) "//+ *"))

;;;###autoload
(progn
  (add-to-list 'auto-mode-alist '("\\.tick\\'" . tickscript-mode)))

(provide 'tickscript-mode)

;;; tickscript-mode.el ends here
