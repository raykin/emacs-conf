;; coffee script
(require 'coffee-mode)

;; (add-hook 'coffee-mode-hook
;;           (lambda ()
;;             (set (make-local-variable 'tab-width) 4)
;;             (set (make-local-variable 'indent-tabs-mode) t)))

(add-hook 'coffee-mode-hook 'projectile-mode)
(setq coffee-tab-width 2)
