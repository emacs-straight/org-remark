;;; org-remark-icon.el --- Enable Org-roam to use icons -*- lexical-binding: t; -*-

;; Copyright (C) 2021-2023 Free Software Foundation, Inc.

;; Author: Noboru Ota <me@nobiot.com>
;; URL: https://github.com/nobiot/org-remark
;; Created: 29 July 2023
;; Last modified: 29 July 2023
;; Package-Requires: ((emacs "27.1") (org "9.4"))
;; Keywords: org-mode, annotation, note-taking, marginal-notes, wp

;; This file is not part of GNU Emacs.

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or (at
;; your option) any later version.

;; This program is distributed in the hope that it will be useful, but
;; WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
;; General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;;; Code:
(require 'cl-macs)

(defgroup org-remark-icon nil
  "Highlight and annotate any text files with using Org mode."
  :group 'org-remark
  :prefix "org-remark-icon"
  :link '(url-link :tag "GitHub" "https://github.com/nobiot/org-remark"))

(defcustom org-remark-icon-notes "(*)"
  "String to be displayed when notes exist for a given highlight.

You can set a function to this user option. In this case, the
function must take one argument, which is FACE. FACE can be a
named face (a symbol), or an anonymous face (plist of face
attributes). The function can ignore them and set its own face
and/or text-property to the string. This means you can return a
string with a display property to show an SVG icon instead of the
underlying string.

Nil means no icon is to be displayed."
  :safe #'stringp
  :type '(choice
          (string "(*)")
          (function)))

(defcustom org-remark-icon-position-adjusted "(d)"
  "String to be displayed when a highlight position adjusted.

You can set a function to this user option. In this case, the
function must take one argument, which is FACE. FACE can be a
named face (a symbol), or an anonymous face (plist of face
attributes). The function can ignore them and set its own face
and/or text-property to the string. This means you can return a
string with a display property to show an SVG icon instead of the
underlying string.

Nil means no icon is to be displayed."
  :safe #'stringp
  :type '(choice
          (string "(d)")
          (function)))

;;;###autoload
(define-minor-mode org-remark-icon-mode
  "Enable Org-remark to display icons.
The icons currently available are defined in `org-remark-icons'."
  :global nil
  :group 'org-remark
  (if org-remark-icon-mode
      ;; Enable
      (progn
        (add-hook 'org-remark-highlights-toggle-hide-functions #'org-remark-icon-toggle-hide)
        (add-hook 'org-remark-highlights-toggle-show-functions #'org-remark-icon-toggle-show)
        ;; Add-icons should be the last function because other functions may do
        ;; something relevant for an icon -- e.g. adjust-positon."
        (add-hook 'org-remark-highlights-after-load-functions
                  #'org-remark-highlights-add-icons 80))
    ;; Disable
    (remove-hook 'org-remark-highlights-toggle-hide-functions #'org-remark-icon-toggle-hide)
    (remove-hook 'org-remark-highlights-toggle-show-functions #'org-remark-icon-toggle-show)
    (remove-hook 'org-remark-highlights-after-load-functions
                 #'org-remark-highlights-add-icons 80)))

(defvar org-remark-icons
  (list
   (list 'notes
         (lambda (ov)
           (overlay-get ov '*org-remark-note-body))
         nil)
   (list 'position-adjusted
         (lambda (ov)
           (overlay-get ov '*org-remark-position-adjusted))
         'org-remark-highlighter-warning))
  "List of icons enabled.
It is an alist. Each element is a list of this form:
 (ICON-NAME PREDICATE DEFAULT-FACE)

ICON-NAME must be a symbol such as \\='notes\\=' and
\\='position-adjusted\\='. They are used as a suffix to be added to
\\='org-remark-icon-\\=' to form a customizing variable such as
`org-remark-icon-notes' and `org-remark-icon-position-adjusted'.

PREDICATE must be a function that accepts one argument OV, which
is the highlight overlay. If PREDICATE returns non-nil, the icon
for ICON-NAME will be added to the highlight.

DEFAULT FACE must be a named face. It is optinal and can be nil.")

(defun org-remark-icon-toggle-hide (highlight)
  (overlay-put highlight '*org-remark-icons (overlay-get highlight 'after-string))
  (overlay-put highlight 'after-string nil))

(defun org-remark-icon-toggle-show (highlight)
  (overlay-put highlight 'after-string (overlay-get highlight '*org-remark-icons))
  (overlay-put highlight '*org-remark-icons nil))

(defun org-remark-highlights-add-icons (overlays _notes-buf)
  "Add icons to OVERLAYS.
Each overlay is a highlight."
  (dolist (ov overlays)
    (cl-flet ((add-icon-maybe (icon)
                (cl-destructuring-bind
                    (icon-name pred default-face) icon
                  (when (funcall pred ov)
                    (org-remark-icon-propertize icon-name ov default-face)))))
      (let ((icon-string
             (mapconcat #'add-icon-maybe org-remark-icons)))
        (when icon-string (overlay-put ov 'after-string icon-string))))))

(defun org-remark-icon-propertize (icon-name highlight default-face)
  "Return a propertized string.
ICON can be either a function or string. FACE is either named
face or anonymous. FACE is passed to ICON when it is a function.
In this case, there is no expectation that the function should
use it. It can disregard the FACE."
  (let ((icon (symbol-value (intern (concat "org-remark-icon-"
                                            (symbol-name icon-name)))))
        (highlight-face (overlay-get highlight 'face))
        (default-face default-face))
    (if (functionp icon)
        (funcall icon icon-name highlight-face)
      (propertize icon 'face (if default-face default-face highlight-face)))))

(provide 'org-remark-icon)
;;; org-remark-icon.el ends here
