;;; git.el --- Git integration -*- lexical-binding: t; -*-

;;; Commentary:
;; Magit configuration

;;; Code:

;; Magit
(use-package magit
  :bind ("C-x g" . magit-status)
  :config
  (setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)

  (defun magit-jump-to-file ()
    "Jump to a changed file in magit status buffer by name."
    (interactive)
    (let* ((items (magit-list-files "--modified" "--others" "--exclude-standard"))
           (staged (magit-staged-files))
           (all (delete-dups (append staged items)))
           (file (completing-read "Jump to file: " all nil t)))
      (goto-char (point-min))
      (catch 'found
        (while (not (eobp))
          (let ((section (magit-current-section)))
            (when (and section
                       (magit-section-match 'file section)
                       (equal (oref section value) file))
              (throw 'found (point))))
          (magit-section-forward)))))

  (defun my/auto-push-after-commit ()
    (let ((branch (magit-get-current-branch)))
      (when (or (magit-get-push-branch branch)
                (magit-get-upstream-branch branch))
        (magit-run-git-async "push"))))

  (add-hook 'git-commit-post-finish-hook #'my/auto-push-after-commit)

  :bind (:map magit-status-mode-map
              ("/" . magit-jump-to-file)))

(provide 'git)
;;; git.el ends here
