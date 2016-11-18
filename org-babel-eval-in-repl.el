;;; org-babel-eval-in-repl.el --- Eval org code blocks in a REPL.
;;
;; Author: Takeshi Teshima <diadochos.developer@gmail.com>
;; URL: https://github.com/diadochos/org-babel-eval-in-repl

;; Version:           20161119.0112
;; Keywords: literate programming, reproducible research

;;
;; This file is not part of GNU Emacs.
;;
;; The MIT License (MIT)
;; Copyright (c) 2016 Takeshi Teshima
;; Permission is hereby granted, free of charge, to any person obtaining a copy
;; of this software and associated documentation files (the "Software"), to deal
;; in the Software without restriction, including without limitation the rights
;; to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;; copies of the Software, and to permit persons to whom the Software is
;; furnished to do so, subject to the following conditions:
;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.
;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;; OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;; THE SOFTWARE.

;;; Commentary:

;;; Code:
(require 'ob)

;; @ Get data
(defun ober:get-block-content ()
  "@todo implement. Get source block content.")

(defun ober:get-type ()
  "Get language string from `org-babel-src-block-info'.
Returns nil if the cursor is outside a src block."
  (nth 0 (org-babel-get-src-block-info)))
;; (org-babel-get-src-block-info) => '(language body arguments switches name start coderef)

;; @ Decide action
(defvar ober:org-babel-type-list
  '(("ruby" . (eval-in-repl-ruby eir-eval-in-ruby))
    ("cider" . (eval-in-repl-cider eir-eval-in-cider))
    ("geiser" . (eval-in-repl-geiser eir-eval-in-geiser))
    ("hy" . (eval-in-repl-hy eir-eval-in-hy))
    ("ielm" . (eval-in-repl-ielm eir-eval-in-ielm))
    ("javascript" . (eval-in-repl-javascript eir-eval-in-javascript))
    ("ocaml" . (eval-in-repl-ocaml eir-eval-in-ocaml))
    ("prolog" . (eval-in-repl-prolog eir-eval-in-prolog))
    ("python" . (eval-in-repl-python eir-eval-in-python))
    ("racket" . (eval-in-repl-racket eir-eval-in-racket))
    ("ruby" . (eval-in-repl-ruby eir-eval-in-ruby))
    ("scheme" . (eval-in-repl-scheme eir-eval-in-scheme))
    ("shell" . (eval-in-repl-shell eir-eval-in-shell))
    ("slime" . (eval-in-repl-slime eir-eval-in-slime))
    ("sml" . (eval-in-repl-sml eir-eval-in-sml)))
  "Association list of config.
Format: '((\"language-name\" . (feature-to-require execution-function-to-run))))

(defun ober:get-exec-config (type)
  "Get exec procedure by looking up config by type."
  (cdr (assoc type ober:org-babel-type-list)))

;; @ Interface
;;;###autoload
(defun ober:eval-in-repl ()
  "Execute source code in a REPL. (The range to execute is determined by `eval-in-repl'.)"
  (interactive)
  (let ((config (ober:get-exec-config (ober:get-type))))
    (require (nth 0 config))
    (funcall (nth 1 config))))

;;;###autoload
(defun ober:eval-block-in-repl ()
  "@todo to be added"
  (interactive))

(provide 'org-babel-eval-in-repl)
;;; org-babel-eval-in-repl.el ends here