;; Enh-ruby-mode was autoinstalled by el-get, it conflicts with ruby-mode(1.1) in elpa-packages

;; custom Ruby Mode
(add-hook 'ruby-mode-hook 'turn-off-auto-fill)
(add-to-list 'auto-mode-alist '("\\.json.ruby\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'projectile-mode)
(projectile-rails-global-mode)
;; (setq projectile-enable-caching t)
;;(add-hook 'ruby-mode-hook 'projectile-rails-on)

;; Rake files are ruby, too, as are gemspecs, rackup files, etc.
(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.thor$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Thorfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))

;; We never want to edit Rubinius bytecode or MacRuby binaries
(add-to-list 'completion-ignored-extensions ".rbc")
(add-to-list 'completion-ignored-extensions ".rbo")

;; load rbenv mode
(require 'rbenv)
(global-rbenv-mode)

;;
(defun seeing-is-believing ()
  "Replace the current region (or the whole buffer, if none) with the output
of seeing_is_believing."
  (interactive)
  (let ((beg (if (region-active-p) (region-beginning) (point-min)))
        (end (if (region-active-p) (region-end) (point-max))))
    (shell-command-on-region beg end "seeing_is_believing" nil 'replace)))
(global-set-key (kbd "C-c C-c") 'seeing-is-believing)

;; custom projectile-rails mode
;; (custom-set-variables
;;  '(projectile-rails-keymap-prefix (kbd "M-r")))
;; (global-set-key (kbd "M-g") 'projectile-grep) ;; why failed?
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))

;; Slim mode
(add-hook 'slim-mode-hook 'projectile-mode)

;; autopair
;;(require 'autopair)
;;(autopair-global-mode) ;; to enable in all buffers

;; Sass
(require 'sass-mode)

;; Scss
(autoload 'scss-mode "scss-mode")
(add-to-list 'auto-mode-alist '("\\.scss\\'" . scss-mode))

;; YAML
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map "\C-m" 'newline-and-indent)))

;; js
(add-to-list 'auto-mode-alist '("\\.js.erb$" . js-mode))

;; Deprecated
;; C-l inserts a hash mark
;; (eval-after-load 'ruby-mode
;;   '(progn
;;      (define-key ruby-mode-map (kbd "C-l") " => ")))
;; (eval-after-load 'rhtml-mode
;;   '(progn
;;      (define-key rhtml-mode-map (kbd "C-l") " => ")))

;; minitest
(require 'minitest)
(add-hook 'ruby-mode-hook 'minitest-mode)

;; rspec
(require 'rspec-mode)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)

(require 'ruby-end)
