;;; claude-integration.el --- Claude Code integration -*- lexical-binding: t; -*-

;;; Commentary:
;; Claude Code integration using claude-code.el package

;;; Code:

;; Install dependencies
(use-package inheritenv)

;; Install vterm for better terminal rendering
(use-package vterm
  :demand t
  :config
  ;; Fix cursor handling for spinners after multiline input
  (setq vterm-max-scrollback 10000)
  (setq vterm-buffer-name-string "vterm %s")
  ;; Enable mouse scrolling in vterm
  (setq vterm-copy-mode-remove-fake-newlines t)
  ;; Bind keys for easier scrolling
  (define-key vterm-mode-map (kbd "C-c C-t") 'vterm-copy-mode)
  (define-key vterm-copy-mode-map (kbd "C-c C-t") 'vterm-copy-mode))

;; Install claude-code from GitHub
(straight-use-package
 '(claude-code :type git :host github :repo "stevemolitor/claude-code.el"))

(require 'claude-code)

;; Use vterm as terminal backend (handles spinners better than eat)
(setq claude-code-terminal-backend 'vterm)

;; Disable multiline buffer filter - it can corrupt vterm cursor state
(setq claude-code-vterm-buffer-multiline-output nil)

;; Prevent claude buffer from jumping around and enable scrolling
(add-hook 'claude-code-mode-hook
          (lambda ()
            (when (string-match-p "\\*claude-code" (buffer-name))
              (setq-local scroll-conservatively 10000)
              (setq-local scroll-margin 0)
              ;; Enable mouse wheel scrolling in vterm
              (when (eq claude-code-terminal-backend 'vterm)
                (local-set-key (kbd "<mouse-4>") 'scroll-down-line)
                (local-set-key (kbd "<mouse-5>") 'scroll-up-line)))))

;; Override display function to open on the right
(setq claude-code-display-window-fn
      (lambda (buffer)
        (display-buffer buffer '((display-buffer-in-direction)
                                 (direction . right)
                                 (window-width . 0.66)))))

;; Custom Claude Code executable path - using proxy wrapper
(setq claude-code-program (expand-file-name "~/.local/bin/claude-proxy"))

;; Enable claude-code-mode globally
(claude-code-mode)

;; Keybindings
(global-set-key (kbd "<f8>") 'claude-code)
(global-set-key (kbd "C-c c") claude-code-command-map)

(provide 'claude-integration)
;;; claude-integration.el ends here
