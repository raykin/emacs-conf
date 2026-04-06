;;; completion.el --- Completion and minibuffer configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Vertico, Orderless, Marginalia, Consult, Corfu, Which-key setup

;;; Code:

;; Completion & minibuffer
(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :custom (completion-styles '(orderless basic)))

(use-package marginalia
  :init (marginalia-mode))

(use-package which-key
  :init (which-key-mode)
  :custom
  (which-key-idle-delay 0.5))

;; Recent files
(use-package recentf
  :init (recentf-mode 1)
  :custom
  (recentf-max-saved-items 100)
  :bind ("C-x C-r" . recentf-open-files))

(use-package consult
  :bind (("C-x b" . consult-buffer)
         ("C-c q f" . consult-find))
  :config
  (when (executable-find "fdfind")
    (setq consult-find-command
          "fdfind --type f --full-path . %s")))

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)
  (corfu-auto-delay 0.1)
  (corfu-auto-prefix 2)
  (corfu-cycle t)
  (corfu-preselect 'prompt)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)
        ("RET" . corfu-insert)))

(provide 'completion)
;;; completion.el ends here
