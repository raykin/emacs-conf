;; coffee script
(require 'coffee-mode)
(setq coffee-tab-width 2)
(add-hook 'coffee-mode-hook
          (lambda ()
            (set (make-local-variable 'tab-width) 2)
            (set (make-local-variable 'indent-tabs-mode) t)))

(add-hook 'coffee-mode-hook 'projectile-mode)
