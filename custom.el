(require 'smart-tab)
(global-smart-tab-mode 1)

(require 'sws-mode)
(require 'jade-mode)
(add-to-list 'auto-mode-alist '("\\.styl$" . sws-mode))
(add-to-list 'auto-mode-alist '("\\.jade$" . jade-mode))
(add-to-list 'auto-mode-alist '("\\.pug$" . jade-mode))

;; Markdown
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown" . markdown-mode))

;; comment-or-uncomment-region-or-line does not exist
;; (global-set-key (kbd "M-/") 'comment-or-uncomment-region-or-line)
(global-set-key (kbd "s-v") 'scroll-other-window)
(global-set-key (kbd "s-v") 'scroll-other-window-down)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x C-p") 'find-file-at-point)
;; list of global mode
;;(global-linum-mode 1)

;; list of global key
(global-set-key   [f7]   'rename-buffer)
(global-set-key   [f6]   'goto-line)

;; list of global hook
;; how to remove this hook on markdown-mode
;; (add-hook 'before-save-hook 'delete-trailing-whitespace)
(require 'ws-butler)
(add-hook 'prog-mode-hook 'ws-butler-mode)
(add-hook 'prog-mode-hook 'turn-off-auto-fill)
;; does not work at all
;; (add-hook 'prog-mode-hook 'hs-minor-mode)

;; Auto Split to Horizontal
;; not sure if it useful.
;; (setq split-height-threshold 0)
;; (setq split-width-threshold nil)

;; Auto Split to Vertically
(setq split-height-threshold nil)
(setq split-width-threshold 80)

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

;; Hide Show mode
(defun toggle-selective-display (column)
      (interactive "P")
      (set-selective-display
       (or column
           (unless selective-display
             (1+ (current-column))))))

(defun toggle-hiding (column)
      (interactive "P")
      (if hs-minor-mode
          (if (condition-case nil
                  (hs-toggle-hiding)
                (error t))
              (hs-show-all))
        (toggle-selective-display column)))

(global-set-key (kbd "C-,") 'toggle-hiding) ;; seems not worked in hs-minor-mode?
(global-set-key (kbd "C-.") 'toggle-selective-display) ;; the fold codes work, but not work great. cause it fold all codes once you trigger it
;; hs-minor-mode behave stranged
;; (add-hook 'ruby-mode-hook 'hs-minor-mode)


;; try add git status on bottom bar. not worked
;; (defadvice vc-git-mode-line-string (after plus-minus (file) compile activate)
;;   (setq ad-return-value
;;     (concat ad-return-value
;;             (let ((plus-minus (vc-git--run-command-string
;;                                file "diff" "--numstat" "--")))
;;               (and plus-minus
;;                    (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" plus-minus)
;;                    (format " +%s-%s" (match-string 1 plus-minus) (match-string 2 plus-minus)))))))

;; mac specific settings
(when (eq system-type 'darwin)
  (setq mac-option-modifier 'meta)
  (setq mac-command-modifier 'meta)
  (global-set-key [kp-delete] 'delete-char) ;; sets fn-delete to be right-delete
    )

(require 'phi-autopair)
(phi-autopair-global-mode)

(add-hook 'jade-mode-hook 'projectile-mode)

(global-set-key (kbd "M-/") 'comment-or-uncomment-region)
