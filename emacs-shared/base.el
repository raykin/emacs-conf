;;; base.el --- Base Emacs configuration shared across projects -*- lexical-binding: t; -*-

;;; Commentary:
;; Core Emacs settings, performance tweaks, and basic behavior

;;; Code:

;; Performance: Increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Debug mode - enable manually with M-x toggle-debug-on-error when needed
(setq debug-on-error nil)

;; Disable UI elements early
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

;; Disable startup screen
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)

;; UI Settings - font size based on screen resolution
(let ((font-height (if (> (display-pixel-width) 2000) 130 190)))
  (set-face-attribute 'default nil :height font-height))
(setq-default line-spacing 0.05)
(global-display-line-numbers-mode)

;; Basic editing settings
(setq-default indent-tabs-mode nil)   ;; never insert tabs
(setq-default tab-width 2)            ;; treat tab as 2 spaces if it ever appears
(setq-default standard-indent 2)      ;; default indentation step
(setq-default c-basic-offset 2)       ;; C-style languages (JS, TS, Java, etc.)
(setq-default js-indent-level 2)      ;; JavaScript
(setq-default css-indent-offset 2)    ;; CSS/SCSS

;; Enable recursive minibuffers
(setq enable-recursive-minibuffers t)

;; Auto-revert mode
(global-auto-revert-mode 1)
(add-hook 'dired-mode-hook 'auto-revert-mode)

;; Useful defaults
(save-place-mode 1)
(savehist-mode 1)

;; Electric pair mode
(electric-pair-mode 1)
(setq electric-pair-pairs
      '((?\' . ?\')   ;; single quotes
        (?\" . ?\")   ;; double quotes
        (?\( . ?\))   ;; parentheses
        (?\[ . ?\])   ;; square brackets
        (?\{ . ?\}))) ;; curly braces
(show-paren-mode 1)

;; Disable electric pair in minibuffer
(defun raykin/inhibit-electric-pair-in-minibuffer (char)
  (minibufferp))
(setq electric-pair-inhibit-predicate #'raykin/inhibit-electric-pair-in-minibuffer)

;; Delete trailing whitespace on save
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Window management
(setq split-width-threshold 0)   ;; force vertical split
(add-hook 'window-setup-hook 'toggle-frame-maximized t)

;; Performance: Reset GC threshold after startup
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)))) ;; 16MB

;; Backup and lock files
;; Create backup directory if it doesn't exist
(let ((backup-dir (expand-file-name "~/.emacs.d/backups")))
  (unless (file-directory-p backup-dir)
    (make-directory backup-dir t))
  ;; Store all backup files in this directory
  (setq backup-directory-alist `(("." . ,backup-dir)))
  ;; Handle symlinks correctly
  (setq backup-by-copying t))

;; Also move auto-save files to the same directory
(setq auto-save-file-name-transforms
      `((".*" "~/.emacs.d/backups/" t)))

;; Disable lock files (the .#filename files)
(setq create-lockfiles nil)

;; Tree-sitter setup
;; Only configure if treesit-extra-load-path is not already set
;; This allows individual configs (like ~/.emacs.d/init.el) to override
(unless (bound-and-true-p treesit-extra-load-path)
  ;; Share tree-sitter grammars across project-specific Emacs configs
  (setq treesit-extra-load-path
        (list (expand-file-name "tree-sitter" straight-base-dir)))

  ;; Tree-sitter auto mode - install grammars eagerly
  (use-package treesit-auto
    :demand t
    :config
    ;; Install grammars to shared directory
    (setq treesit-auto-install 'prompt)
    ;; Ensure grammars are installed to the shared location
    (let ((shared-grammar-dir (expand-file-name "tree-sitter" straight-base-dir)))
      (unless (file-directory-p shared-grammar-dir)
        (make-directory shared-grammar-dir t))
      ;; Override the installation directory
      (setq treesit-extra-load-path (list shared-grammar-dir)))
    (global-treesit-auto-mode)))

(provide 'base)
;;; base.el ends here
