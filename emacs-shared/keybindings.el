;;; keybindings.el --- Global keybindings -*- lexical-binding: t; -*-

;;; Commentary:
;; Shared global keybindings

;;; Code:

;; Custom keybindings
(global-set-key (kbd "<f6>") 'treemacs)
(global-set-key (kbd "M-/") 'comment-line)

;; Better reload - unload custom features first
(defun reload-emacs-config ()
  "Reload Emacs configuration after unloading custom features."
  (interactive)
  ;; Only unload safe-to-reload features
  (dolist (feature '(keybindings utils search git themes completion proxy base))
    (unload-feature feature t))
  (load-file user-init-file)
  (message "Config reloaded"))

(global-set-key (kbd "<f10>") 'reload-emacs-config)
(global-set-key (kbd "C-;") 'raykin/claude-send-context)

(provide 'keybindings)
;;; keybindings.el ends here
