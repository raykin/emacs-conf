;; install smart-tab from el-get
(require 'smart-tab)
(global-smart-tab-mode 1)

;; smart-tab make yas hotkey disworked. so we remap yas hotkey
;; see more on http://blog.binchen.org/?p=357
(require 'yasnippet)
(yas-global-mode 1)
(global-set-key (kbd "M-p") 'yas/expand)

;; jade mode
(load-relative "vendor/jade-mode/sws-mode.el")
(load-relative "vendor/jade-mode/jade-mode.el")
(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))

;; session mode
(require 'session)
(add-hook 'after-init-hook 'session-initialize)
(setq desktop-globals-to-save '(desktop-missing-file-warning))



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
;;(global-linum-mode 1)

;; list of global key
(global-set-key   [f7]   'rename-buffer)

;; list of global hook
;; how to remove this hook on markdown-mode
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'prog-mode-hook 'turn-off-auto-fill)

;;(color-theme-railscasts)
;;(load-theme 'soft-morning t)
;;(load-theme 'zenburn t)
(load-theme 'wombat)

;; Setting Emacs Split to Horizontal
(setq split-height-threshold 0)
(setq split-width-threshold nil)

;; GUI
(set-face-attribute 'default nil :height 170)

;; Add Transparency script
(set-frame-parameter (selected-frame) 'alpha '(100 100))
;;(add-to-list 'default-frame-alist '(alpha 85 50))

(eval-when-compile (require 'cl))
(defun toggle-transparency ()
  (interactive)
  (if (/=
       (cadr (frame-parameter nil 'alpha))
       100)
      (set-frame-parameter nil 'alpha '(100 100))
    (set-frame-parameter nil 'alpha '(85 50))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

;; emacs-powerline mode
(load-relative "./vendor/emacs-powerline/powerline.el")
(custom-set-faces
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

;; try Add Git Status in mode-line but failed
;; (defadvice vc-git-mode-line-string (after plus-minus (file) compile activate)
;;   (setq ad-return-value
;;     (concat ad-return-value
;;             (let ((plus-minus (vc-git--run-command-string
;;                                file "diff" "--numstat" "--")))
;;               (and plus-minus
;;                    (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" plus-minus)
;;                    (format " +%s-%s" (match-string 1 plus-minus) (match-string 2 plus-minus)))))))
