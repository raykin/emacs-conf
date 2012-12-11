;; install necessary packages
(defvar ror-packages '(autopair sass-mode yaml-mode )
  "A list of packages to ensure are installed at launch.")

(dolist (p ror-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Rhtml Mode
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
(add-hook 'rhtml-mode-hook 'rinari-minor-mode)
(add-hook 'rhtml-mode-hook 'turn-off-auto-fill)

;; Electric Mode
(require 'ruby-electric)
(add-hook 'ruby-mode-hook 'ruby-electric-mode)

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
