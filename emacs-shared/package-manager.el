;;; package-manager.el --- Package manager configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; straight.el and use-package setup

;;; Code:

;; Use shared straight.el directory for all configs
;; Use the location of THIS FILE (package-manager.el) as the base directory
;; This works regardless of where Emacs is started from
(setq straight-base-dir
      (file-name-directory (or load-file-name (buffer-file-name))))

;; Bootstrap straight.el
(defvar bootstrap-version)
(let ((bootstrap-file
       (expand-file-name "straight/repos/straight.el/bootstrap.el" straight-base-dir))
      (bootstrap-version 6))
  (unless (file-exists-p bootstrap-file)
    (with-current-buffer
        (url-retrieve-synchronously
         "https://raw.githubusercontent.com/radian-software/straight.el/develop/install.el"
         'silent 'inhibit-cookies)
      (goto-char (point-max))
      (eval-print-last-sexp)))
  (load bootstrap-file nil 'nomessage))

;; Install use-package
(straight-use-package 'use-package)

;; Configure use-package to use straight.el by default
(use-package straight
  :custom
  (straight-use-package-by-default t))

;; exec-path-from-shell - import PATH from shell
(use-package exec-path-from-shell
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize)))

;; mac specific settings
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char)) ;; sets fn-delete to be right-delete

(provide 'package-manager)
;;; package-manager.el ends here
