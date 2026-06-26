;;; init.el --- Angular/Ionic-specific Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Angular/Ionic project configuration that loads shared configs

;;; Code:

;; Set user-emacs-directory to this file's directory
;; Works whether you run: emacs -q -l init.el (from emacs-angular/)
;;                    or: emacs -q -l emacs-angular/init.el (from editor/)
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory (file-truename user-init-file)))

;; Custom file - keep auto-generated code out of init.el
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

;; Load shared configurations
(add-to-list 'load-path (expand-file-name "../emacs-shared" user-emacs-directory))
(require 'package-manager)  ;; Load first - defines straight-base-dir
(require 'base)
(require 'proxy)
(require 'completion)
(require 'themes)
(require 'git)
(require 'search)
(require 'utils)
(require 'prose)
(require 'windows)

;; ============================================================================
;; Angular/TypeScript-specific configuration
;; ============================================================================

;; LSP setup
(use-package lsp-mode
  :hook ((typescript-ts-mode . lsp-deferred)
         (scss-mode . lsp-deferred)
         (sass-mode . lsp-deferred)
         (css-mode . lsp-deferred)
         (web-mode . (lambda ()
                       (when (string-match-p "\\.html\\'" (buffer-file-name))
                         (lsp-deferred)))))
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
(use-package typescript-ts-mode
  :mode (("\\.ts\\'" . typescript-ts-mode)
         ("\\.tsx\\'" . tsx-ts-mode)))
  ;; LSP hook is in lsp-mode config above, no need to duplicate

(use-package web-mode
  :mode ("\\.html\\'")
  :custom
  (web-mode-markup-indent-offset 2)
  (web-mode-code-indent-offset 2)
  (web-mode-css-indent-offset 2))

;; SCSS/SASS modes for Angular styles
;; Define flymake variables to prevent scss-mode errors (without loading flymake)
(defvar flymake-allowed-file-name-masks nil)
(defvar flymake-err-line-patterns nil)

;; Explicitly install scss-mode - will error loudly if it fails
(straight-use-package 'scss-mode)

(use-package scss-mode
  :mode "\\.scss\\'"
  :custom
  (scss-compile-at-save nil))

(use-package sass-mode
  :mode "\\.sass\\'")

;; Note: flymake and flycheck removed - LSP handles diagnostics

(use-package pug-mode
  :mode "\\.pug\\'")

(add-hook 'pug-mode-hook
          (lambda ()
            (setq-local lsp-mode nil)))

;; Angular language server - project-aware configuration
(with-eval-after-load 'lsp-mode
  (defun my-angular-ls-command ()
    "Dynamically find Angular language server in current project."
    (let* ((project-root (or (and (fboundp 'project-root)
                                  (when-let ((proj (project-current)))
                                    (project-root proj)))
                             (locate-dominating-file default-directory "package.json")
                             (expand-file-name "~/code/kasa/")))
           (node-modules (expand-file-name "node_modules" project-root))
           (angular-server (expand-file-name "@angular/language-server/index.js" node-modules)))
      (when (file-exists-p angular-server)
        (list "node"
              angular-server
              "--ngProbeLocations" node-modules
              "--tsProbeLocations" node-modules
              "--stdio"))))

  ;; Set the command - will be evaluated when LSP starts
  (setq lsp-clients-angular-language-server-command 'my-angular-ls-command))

;; Load Claude integration (after all other configs)
(require 'keybindings)

;; Open two files at startup
(find-file "~/studio/emacs-conf/emacs-angular/init.el")
;;(find-file "~/code/kasa/package.json")

;;; init.el ends here
