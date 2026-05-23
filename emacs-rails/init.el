;;; init.el --- Rails-specific Emacs configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Rails project configuration that loads shared configs

;;; Code:

;; Set user-emacs-directory to this file's directory
;; Works whether you run: emacs -q -l init.el (from emacs-rails/)
;;                    or: emacs -q -l emacs-rails/init.el (from editor/)
(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory (file-truename user-init-file)))

;; Custom file - keep auto-generated code out of init.el
(setq custom-file (expand-file-name "raykin-custom.el" user-emacs-directory))
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
(require 'windows)

;; ============================================================================
;; Rails-specific configuration
;; ============================================================================

;; Projectile
(use-package projectile
  :config
  (projectile-mode t)
  (setq projectile-completion-system 'default)
  (setq projectile-enable-caching t)
  (setq projectile-auto-discover nil)
  (setq projectile-git-command "git ls-files -zco --exclude-standard")
  :bind-keymap
  ("C-c p" . projectile-command-map))

;; Projectile Rails
(use-package projectile-rails
  :config
  (projectile-rails-global-mode)
  (add-hook 'ruby-ts-mode-hook 'projectile-rails-on)
  :bind-keymap
  ("C-c r" . projectile-rails-command-map))

;; LSP Mode
(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((ruby-ts-mode . lsp-deferred)
         (lsp-mode . lsp-enable-which-key-integration))
  :init
  (setq lsp-keymap-prefix "C-c l")
  :config
  (setq lsp-enable-file-watchers nil)
  (setq lsp-headerline-breadcrumb-enable nil)
  (setq lsp-modeline-code-actions-enable nil)
  (setq lsp-modeline-diagnostics-enable nil)
  (setq lsp-diagnostics-provider :auto)
  (setq lsp-completion-provider :capf)
  (setq lsp-completion-enable t)
  (setq lsp-enable-snippet nil)
  (setq lsp-ruby-lsp-use-bundler t)
  (setq lsp-warn-no-matched-clients nil)
  (setq lsp-enable-symbol-highlighting nil)
  (setq lsp-enable-on-type-formatting nil)
  (setq lsp-enable-indentation nil)  ;; Use ruby-ts-mode (tree-sitter) for indentation
  (setq lsp-lens-enable nil)
  (setq lsp-signature-auto-activate nil)
  (setq lsp-idle-delay 1.0)
  (setq lsp-enable-suggest-server-download nil)
  (setq lsp-disabled-clients '(rubocop-ls typeprof-ls steep-ls sorbet-ls semgrep-ls ruby-syntax-tree-ls)))

;; LSP UI - UI improvements for lsp-mode
(use-package lsp-ui
  :commands lsp-ui-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  (setq lsp-ui-doc-enable nil)
  (setq lsp-ui-doc-delay 2.0)
  (setq lsp-ui-sideline-enable nil)
  (setq lsp-ui-sideline-show-hover nil))

;; YAML mode
(use-package yaml-mode)

;; Slim mode
(use-package slim-mode)

;; SASS mode
(use-package sass-mode)

;; Coffee mode
(use-package coffee-mode
  :config
  (setq coffee-tab-width 2))

;; Ruby Tree-sitter Mode - faster parsing with tree-sitter
(use-package ruby-ts-mode
  :ensure nil  ;; Built-in in Emacs 29+
  :mode (("\\.rb\\'" . ruby-ts-mode)
         ("\\.json\\.ruby\\'" . ruby-ts-mode)
         ("\\.rabl\\'" . ruby-ts-mode)
         ("\\.rake\\'" . ruby-ts-mode)
         ("\\.thor\\'" . ruby-ts-mode)
         ("\\.gemspec\\'" . ruby-ts-mode)
         ("\\.ru\\'" . ruby-ts-mode)
         ("Rakefile\\'" . ruby-ts-mode)
         ("Thorfile\\'" . ruby-ts-mode)
         ("Gemfile\\'" . ruby-ts-mode)
         ("Capfile\\'" . ruby-ts-mode)
         ("Vagrantfile\\'" . ruby-ts-mode))
  :interpreter "ruby")

;; Ignore Rubinius bytecode
(add-to-list 'completion-ignored-extensions ".rbc")
(add-to-list 'completion-ignored-extensions ".rbo")

;; CSS indentation
(setq-default css-indent-offset 2)

;; Code folding
(add-hook 'json-ts-mode-hook 'hs-minor-mode)
(add-hook 'ruby-ts-mode-hook 'hs-minor-mode)

;; Load Claude integration (after all other configs)
(require 'keybindings)

;; Open Rails init.el at startup
(find-file "~/studio/emacs-conf/emacs-rails/init.el")

;;; init.el ends here
