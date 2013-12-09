;; Enh-ruby-mode was autoinstalled by el-get, it conflicts with ruby-mode(1.1) in elpa-packages
;; (add-hook 'enh-ruby-mode-hook 'rinari-minor-mode)
;;(add-hook 'ruby-mode-hook 'rinari-minor-mode)

;; custom Ruby Mode
(add-hook 'ruby-mode-hook 'turn-off-auto-fill)
(add-to-list 'auto-mode-alist '("\\.json.ruby\\'" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rabl\\'" . ruby-mode))
(add-hook 'ruby-mode-hook 'robe-mode)
(add-hook 'ruby-mode-hook 'projectile-mode)
(add-hook 'ruby-mode-hook 'projectile-rails-on)

;; load rbenv mode
(load-relative "./vendor/rbenv.el/rbenv")
(add-hook 'ruby-mode-hook 'global-rbenv-mode)
;; this will remove the colors
(setq rbenv-modeline-function 'rbenv--modeline-plain)

;; custom projectile-rails mode
(custom-set-variables
 '(projectile-rails-keymap-prefix (kbd "M-r")))

;; Rhtml mode
(require 'rhtml-mode)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.rjs\\'" . rhtml-mode))
(add-hook 'rhtml-mode-hook 'projectile-rails-on)
(add-hook 'rhtml-mode-hook 'turn-off-auto-fill)

;; Slim mode
(add-hook 'slim-mode-hook 'projectile-rails-on)

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

;; coffee script
(require 'coffee-mode)
(setq coffee-tab-width 2)
(add-hook 'coffee-mode-hook 'projectile-rails-on)

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
(add-hook 'ruby-mode-hook 'hs-minor-mode)

;;
