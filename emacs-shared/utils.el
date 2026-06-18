;;; utils.el --- Utility packages -*- lexical-binding: t; -*-

;;; Commentary:
;; Misc utility packages used across projects

;;; Code:

;; Treemacs
(use-package treemacs)

(use-package dockerfile-mode)

(defun raykin/markdown-align-all-tables ()
  "Align all markdown tables in the buffer without affecting non-table lines."
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward "|" nil t)
      (when (markdown-table-at-point-p)
        (markdown-table-align)
        (goto-char (markdown-table-end))))))

(use-package markdown-mode
  :hook ((markdown-mode . (lambda ()
                            (add-hook 'before-save-hook #'raykin/markdown-align-all-tables nil t)))
         (markdown-mode . (lambda () (corfu-mode -1)))))

(add-hook 'text-mode-hook (lambda () (corfu-mode -1)))


(defun raykin/yank-primary ()
  "Insert the X11 PRIMARY selection at point."
  (interactive)
  (let ((primary (x-get-selection 'PRIMARY)))
    (when primary
      (insert primary))))

(global-set-key (kbd "C-c y") #'raykin/yank-primary)

(defvar raykin/claude-session-map
  '(("forex-trader-web" . "forex"))
  "Alist mapping project-root folder names to Claude tmux session names.")

(defvar raykin/claude-last-prompts (make-hash-table :test 'equal)
  "Hash mapping a file:line ref to the last prompt typed there.")

(defun raykin/claude-send-context (prompt)
  "Send current file:line and PROMPT to Claude tmux pane, then submit.
Remembers the last PROMPT per file:line so re-invoking at the same
position pre-fills it; the prompt is kept if the tmux send fails."
  (interactive
   (let ((ref (format "@%s:%d" (buffer-file-name) (line-number-at-pos))))
     (list (read-string "Prompt: " (gethash ref raykin/claude-last-prompts)))))
  (let* ((project-root (or (when (project-current)
                             (project-root (project-current)))
                           default-directory))
         (folder (file-name-nondirectory (directory-file-name project-root)))
         (session (or (cdr (assoc folder raykin/claude-session-map)) folder))
         (ref (format "@%s:%d" (buffer-file-name) (line-number-at-pos)))
         (text (if (string-empty-p prompt)
                   ref
                 (format "%s %s" ref prompt)))
         (target (format "%s:claude" session))
         (status (shell-command
                  (format "tmux send-keys -t %s -l %s && tmux send-keys -t %s Enter"
                          (shell-quote-argument target)
                          (shell-quote-argument text)
                          (shell-quote-argument target)))))
    (if (zerop status)
        (remhash ref raykin/claude-last-prompts)
      (puthash ref prompt raykin/claude-last-prompts)
      (message "Claude send failed (target %s); prompt remembered for retry" target))))

(provide 'utils)
;;; utils.el ends here
