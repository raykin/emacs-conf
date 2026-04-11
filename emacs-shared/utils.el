;;; utils.el --- Utility packages -*- lexical-binding: t; -*-

;;; Commentary:
;; Misc utility packages used across projects

;;; Code:

;; Treemacs
(use-package treemacs)

(use-package dockerfile-mode)

(use-package markdown-mode
  :hook (markdown-mode . (lambda ()
                           (add-hook 'before-save-hook #'markdown-table-align nil t))))


(defun raykin/yank-primary ()
  "Insert the X11 PRIMARY selection at point."
  (interactive)
  (let ((primary (x-get-selection 'PRIMARY)))
    (when primary
      (insert primary))))

(global-set-key (kbd "C-c y") #'raykin/yank-primary)

(provide 'utils)
;;; utils.el ends here
