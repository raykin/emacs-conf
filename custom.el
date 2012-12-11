;; Add smart-tab
(require 'smart-tab)
(global-smart-tab-mode 1)
;; it make yas hotkey disworked. so we remap yas hotkey
;; see more on http://blog.binchen.org/?p=357
(global-set-key (kbd "C-;") 'yas/expand)

;; session mode
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(setq desktop-globals-to-save '(desktop-missing-file-warning))

;; Add custom yasnippet
(yas/define-snippets 'ruby-mode
                     '(("fs" ", :focus => true " ", focus => true" nil "control structure" nil nil nil)))

;; Markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))

;; list of global mode
(global-linum-mode 1)

;; list of global key
(global-set-key   [f7]   'rename-buffer)

;; list of global hook
;; how to remove this hook on markdown-mode
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook 'turn-off-auto-fill)
