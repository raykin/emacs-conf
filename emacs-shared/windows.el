;;; windows.el --- Window management configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Window display rules to prevent unwanted splits

;;; Code:

;; Prevent window splits - keep Claude window intact
(add-to-list 'display-buffer-alist
             '("\\*Help\\*" (display-buffer-same-window)))

(add-to-list 'display-buffer-alist
             '("\\*compilation\\*" (display-buffer-same-window)))

(add-to-list 'display-buffer-alist
             '("\\*xref\\*" (display-buffer-same-window)))  ;; LSP find references

(add-to-list 'display-buffer-alist
             '("\\*lsp-help\\*" (display-buffer-same-window)))

(provide 'windows)
;;; windows.el ends here
