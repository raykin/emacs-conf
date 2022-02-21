;; Load ELPA package
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar utils-packages '(
                         ag
                         ;; aggressive-indent ;; not good enough, it's often confused me
                         load-relative
												 ;; this lib may be make indention wrong
                         smart-tab
                         phi-autopair
                         paredit;; required by phi-autopair
                         ;; multiple-cursors ;; emacs 24.4 already include rectangle. looks duplicate with multiple-cursors
                         exec-path-from-shell ;; does it useful? dont know, 2016.2
                         hlinum
                         iy-go-to-char
                         key-chord
                         sws-mode
                         railscasts-theme
                         mode-compile
                         ws-butler
                         better-defaults
                         idle-highlight-mode
                         ido-ubiquitous
                         ido-yes-or-no
                         smex
                         magit
                         projectile
                         find-file-in-project
                         quickrun
												 emojify
												 color-theme-sanityinc-tomorrow
                         )
  "A list of packages to ensure are installed at launch.")

(dolist (p utils-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load elpa package

(defvar text-packages '(
                        yaml-mode
                        markdown-mode
                        csv-mode
                        )
  )

(dolist (p text-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load text packages

(exec-path-from-shell-initialize)

(require 'load-relative)
(load-relative "./custom.el")

;; group of useful RoR plugins
(load-relative "./ror-kit.el")
(load-relative "./js-kit.el")
(load-relative "./coffee-kit.el")
(load-relative "./experiment.el")

;; my start working dir. change it to your favorite
;; put it at the end of file cause it can change emacs variables, ex: default-directory
(cd "~/studio")

;; cause inf-ruby-keys not exist
(remove-hook 'ruby-mode-hook 'inf-ruby-keys)

;; try fix bug of https://bugs.launchpad.net/ubuntu/+source/emacs24/+bug/1175422, not worked on my computer
(setq vc-handled-backends ())

;; So no auto-fill in HTML mode and other Text mode
(remove-hook 'text-mode-hook 'turn-on-auto-fill)

(set-cursor-color "orange")

(setq dotfiles-dir (file-name-directory (or load-file-name (buffer-file-name))))

(defun select-current-line ()
  "Select the current line"
  (interactive)
  (end-of-line) ; move to end of line
  (set-mark (line-beginning-position)))
(global-set-key (kbd "C-l") 'select-current-line)

(global-linum-mode)

(require 'hlinum)
(hlinum-activate)

;; see http://stackoverflow.com/questions/7243155/cant-seem-to-get-rid-of-ctrl-x-ctrl-z-key-binding-in-emacs-for-minimizing-windo
(global-set-key "\C-x\C-z" nil)

(load-relative "./theme.el")

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.es6" . js2-mode))

(require 'sass-mode)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-auto-revert-mode 1)

(ido-yes-or-no-mode t)
;; I don't understand what it is
;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(custom-enabled-themes (quote (sanityinc-tomorrow-eighties)))
;;  '(custom-safe-themes
;; 	 (quote
;; 		("5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "98cc377af705c0f2133bb6d340bf0becd08944a588804ee655809da5d8140de6" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "3b0a350918ee819dca209cec62d867678d7dac74f6195f5e3799aa206358a983" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default)))
;;  '(package-selected-packages
;; 	 (quote
;; 		(company tide elixir-mode scss-mode enh-ruby-mode ws-butler rspec-mode rubocop lua-mode emojify material-theme color-theme-sanityinc-tomorrow dracula-theme nginx-mode web-mode rjsx-mode projectile-rails yaml-mode sws-mode swiper smex smart-tab slim-mode sass-mode ruby-end robe rbenv rainbow-mode railscasts-theme quickrun projectile phi-autopair multiple-cursors mode-compile minitest markdown-mode magit load-relative key-chord json-mode jade-mode iy-go-to-char ido-yes-or-no ido-ubiquitous idle-highlight-mode hlinum find-file-in-project exec-path-from-shell csv-mode coffee-mode better-defaults aggressive-indent ag))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))

;;(getenv "PATH")
;;(getenv "STUDIO")

(require 'quickrun)
(global-set-key (kbd "<f8>") 'quickrun)

;; seems not useful
(setq-default tab-width 2)

;; set file size to human readable on Dir mode
(setq dired-listing-switches "-alh")

(setq inhibit-startup-screen t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . rjsx-mode))
(add-to-list 'auto-mode-alist '("\\.es6" . js2-mode))

(setq js2-strict-missing-semi-warning nil)

(tool-bar-mode -1)

;; store all backup and autosave files in the tmp dir
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

(setq ring-bell-function (lambda () (message "*woop*")))
;; (add-hook 'after-init-hook #'global-emojify-mode)

(add-hook 'ruby-mode-hook #'rubocop-mode)

(projectile-mode +1)
(define-key projectile-mode-map (kbd "s-p") 'projectile-command-map)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; enable the usage of file ignore pattern
(setq projectile-indexing-method 'native)
(setq projectile-enable-caching t)

(setq ido-enable-flex-matching t)
(setq ido-everywhere t)
(ido-mode 1)

;; see https://www.masteringemacs.org/article/introduction-to-ido-mode
(setq ido-use-filename-at-point 'guess)
(setq ido-ignore-extensions t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
	 '(yaml-mode ws-butler vue-mode tide textmate sws-mode swiper smex smart-tab slim-mode scss-mode sass-mode ruby-end rubocop rspec-mode rjsx-mode rbenv rainbow-mode railscasts-theme quickrun projectile-rails phi-autopair nginx-mode multiple-cursors mode-compile minitest material-theme markdown-mode magit lua-mode load-relative key-chord json-mode jade-mode iy-go-to-char ido-yes-or-no ido-ubiquitous idle-highlight-mode hlinum find-file-in-project exec-path-from-shell enh-ruby-mode emojify elixir-mode dracula-theme csv-mode color-theme-sanityinc-tomorrow coffee-mode better-defaults aggressive-indent ag)))
