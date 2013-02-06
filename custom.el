;; Add smart-tab
(require 'smart-tab)
(global-smart-tab-mode 1)
;; smart-tab make yas hotkey disworked. so we remap yas hotkey
;; see more on http://blog.binchen.org/?p=357
(global-set-key (kbd "M-p") 'yas/expand)

;; session mode
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(setq desktop-globals-to-save '(desktop-missing-file-warning))

;; Add custom yasnippet
(yas/define-snippets 'ruby-mode
                     '(("fs" ", :focus => true " ", focus => true" nil "control structure" nil nil nil)
                       ("d" "def ${name}\n  $0\nend\n " "def ... end " nil "control structure" nil nil nil)
                       ("do" "do\n$0\nend\n " "do ... end " nil "control structure" nil nil nil)
                       ("dop" "do \|${e}\| \n \nend\n " "do ... end " nil "control structure" nil nil nil)
                       ("inj" "inject\(${e}\) do \|memo, e\| \n memo \nend " "do ... end " nil "control structure" nil nil nil)
                       ))

;; Markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))

;; Textmate mode
(textmate-mode t)
(global-set-key (kbd "M-/") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "M-t") 'textmate-goto-file)
(global-set-key (kbd "M-T") 'textmate-goto-symbol)

;; list of global mode
(global-linum-mode 1)

;; list of global key
(global-set-key   [f7]   'rename-buffer)

;; list of global hook
;; how to remove this hook on markdown-mode
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook 'turn-off-auto-fill)

(require 'color-theme-gruber-darker)
(color-theme-gruber-darker)

;; Setting Emacs Split to Horizontal
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; coffee script
(require 'coffee-mode)
(setq coffee-tab-width 2)

;; GUI
(set-face-attribute 'default nil :height 170)
