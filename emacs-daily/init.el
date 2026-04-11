;;; init.el --- Daily-use Emacs configuration -*- lexical-binding: t; -*-

(setq user-init-file (or load-file-name (buffer-file-name)))
(setq user-emacs-directory (file-name-directory (file-truename user-init-file)))

(setq custom-file (expand-file-name "raykin-custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

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
(require 'keybindings)

;; ============================================================================
;; Text file modes
;; ============================================================================

(use-package markdown-mode)
(use-package yaml-mode)

(defun raykin/json-settings ()
  (require 'hideshow)
  (setq-local js-indent-level 2
              tab-width 2
              indent-tabs-mode nil)
  (hs-minor-mode 1)
  (local-set-key (kbd "TAB") 'indent-according-to-mode))

(add-hook 'js-json-mode-hook #'raykin/json-settings)
(add-hook 'json-mode-hook 'hs-minor-mode)

(defun raykin/hideshow-keys ()
  (local-set-key (kbd "<right>") 'hs-hide-level)
  (local-set-key (kbd "<left>") 'hs-show-block))

(add-hook 'hs-minor-mode-hook #'raykin/hideshow-keys)

(add-to-list 'auto-mode-alist '("\\.jsonc\\'" . json-ts-mode))

;;; init.el ends here
