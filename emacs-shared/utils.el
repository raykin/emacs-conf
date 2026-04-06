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

(defun raykin/claude-send-context (prompt)
  "Send current file:line and PROMPT to Claude tmux pane, then submit."
  (interactive "sPrompt: ")
  (let* ((project-root (or (when (project-current)
                             (project-root (project-current)))
                           default-directory))
         (session (file-name-nondirectory (directory-file-name project-root)))
         (ref (format "@%s:%d" (buffer-file-name) (line-number-at-pos)))
         (text (if (string-empty-p prompt)
                   ref
                 (format "%s %s" ref prompt)))
         (target (format "%s:claude" session)))
    (shell-command (format "tmux send-keys -t %s -l %s && tmux send-keys -t %s Enter"
                           target
                           (shell-quote-argument text)
                           target))))

(provide 'utils)
;;; utils.el ends here
