;;; search.el --- Search tools configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; ripgrep (rg.el) and wgrep setup

;;; Code:

;; rg - search tool
(use-package rg
  :bind ("C-x C-a" . rg-project)
  :config
  (setq rg-command-line-flags '("--glob=!images"))
  (advice-add 'rg-run :after
              (lambda (&rest _)
                "Switch focus to the *rg* buffer after running a search."
                (let ((rg-buffer (get-buffer "*rg*")))
                  (when rg-buffer
                    (pop-to-buffer rg-buffer))))))

;; wgrep - editable rg buffers
(use-package wgrep)

;; builtin project.el on C-c p (rails overrides this with projectile,
;; since it loads its projectile block after (require 'search))
(use-package project
  :straight nil
  :bind-keymap
  ("C-c p" . project-prefix-map))

;; Display buffer settings for search results
(add-to-list 'display-buffer-alist
             '("\\*rg\\*" (display-buffer-same-window)))

(provide 'search)
;;; search.el ends here
