;;; init.el --- React-specific Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; React project configuration that loads shared configs

;;; Code:

;; Set user-emacs-directory to this file's directory
;; Works whether you run: emacs -q -l init.el (from emacs-react/)
;;                    or: emacs -q -l emacs-react/init.el (from editor/)
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory (file-truename user-init-file)))

;; Custom file - keep auto-generated code out of init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Load shared configurations
(add-to-list 'load-path (expand-file-name "../emacs-shared" user-emacs-directory))
(require 'package-manager)
(require 'base)
(require 'proxy)
(require 'completion)
(require 'themes)
(require 'git)
(require 'search)
(require 'utils)
(require 'windows)

;; ============================================================================
;; React/TypeScript-specific configuration
;; ============================================================================

;; LSP setup
(use-package lsp-mode
  :hook ((typescript-ts-mode . lsp-deferred)
         (tsx-ts-mode . lsp-deferred)
         (js-ts-mode . lsp-deferred)
         (css-mode . lsp-deferred)
         (json-ts-mode . lsp-deferred))
  :commands lsp lsp-deferred
  :custom
  (lsp-keymap-prefix "C-c l")
  (lsp-enable-file-watchers t)
  (lsp-modeline-diagnostics-enable t)
  (lsp-completion-provider :capf))

(use-package lsp-ui
  :commands lsp-ui-mode
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-sideline-enable nil))

;; Language modes
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-ts-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . tsx-ts-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js-ts-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . js-ts-mode))

;; CSS/SCSS
(defvar flymake-allowed-file-name-masks nil)
(defvar flymake-err-line-patterns nil)

(straight-use-package 'scss-mode)

(use-package scss-mode
  :mode "\\.scss\\'"
  :custom
  (scss-compile-at-save nil))

(add-to-list 'auto-mode-alist '("\\.css\\'" . css-mode))

;; Load Claude integration (after all other configs)
(require 'keybindings)

;; Open init.el at startup
(find-file "~/studio/emacs-conf/emacs-react/init.el")

;;; init.el ends here
