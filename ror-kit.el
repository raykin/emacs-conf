;; Enh-ruby-mode was autoinstalled by el-get, it conflicts with ruby-mode(1.1) in elpa-packages
;; (add-hook 'enh-ruby-mode-hook 'rinari-minor-mode)
;;(add-hook 'ruby-mode-hook 'rinari-minor-mode)

;; custom Ruby Mode
(add-hook 'ruby-mode-hook 'turn-off-auto-fill)
(add-to-list 'auto-mode-alist '("\\.json.ruby\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'rinari-minor-mode)

;; load rbenv mode
(load-relative "./vendor/rbenv.el/rbenv")
(global-rbenv-mode)

;; Rhtml mode
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
(add-hook 'rhtml-mode-hook 'rinari-minor-mode)
(add-hook 'rhtml-mode-hook 'turn-off-auto-fill)

;; Slim mode
(add-hook 'slim-mode-hook 'rinari-minor-mode)

;; autopair
(require 'autopair)
(autopair-global-mode) ;; to enable in all buffers

;; Sass
(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.scss\\'" . sass-mode))

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; js
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js-mode))

;; C-l inserts a hash mark
(eval-after-load 'ruby-mode
  '(progn
     (define-key ruby-mode-map (kbd "C-l") " => ")))
(eval-after-load 'rhtml-mode
  '(progn
     (define-key rhtml-mode-map (kbd "C-l") " => ")))
