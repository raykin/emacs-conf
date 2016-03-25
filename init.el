;; Load ELPA package
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; todo: remove duplicated autopair

;; Add in your own as you wish:
(defvar utils-packages '(
                         ag
                         ;; aggressive-indent ;; not good enough, it's often confused me
                         load-relative
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
                         textmate
                         better-defaults
                         idle-highlight-mode
                         ido-ubiquitous
                         ido-yes-or-no
                         smex
                         magit
                         projectile
                         find-file-in-project
                         quickrun
                         )
  "A list of packages to ensure are installed at launch.")

(dolist (p utils-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load elpa package


(defvar ruby-packages '(
                        robe ;; Jump to ruby method definition
                        rbenv
                        slim-mode
                        dash  ;; required by minitest
                        minitest
                        ruby-end
                        )
  )

(dolist (p ruby-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load ruby packages

(defvar js-packages '(
                      jade-mode
                      json-mode
                      coffee-mode
                      rainbow-mode ;; give color on css file. need background color to be white
                      sass-mode
                      )
  )

(dolist (p js-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load js packages

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

(load-relative "./coffee-kit.el")

;; group of useful TEXT plugins
;; tern not worked
;; (load-relative "./vendor/tern/emacs/tern.el")
;; (require 'tern-mode)
;; (autoload 'tern-mode "tern.el" nil t)
;; (add-hook 'js-mode-hook (lambda () (tern-mode t)))

;; my start working dir. change it to your favorite
;; put it at the end of file cause it can change emacs variables, ex: default-directory
(cd "~/studio")

;; remove autofill which was defined in emacs-starter-kit
(remove-hook 'prog-mode-hook 'esk-local-comment-auto-fill)
;; remove hl-line-mode hook which was defined in emacs-starter-kit
(remove-hook 'prog-mode-hook 'esk-turn-on-hl-line-mode)
;; cause inf-ruby-keys not exist
(remove-hook 'ruby-mode-hook 'inf-ruby-keys)

;; try fix bug of https://bugs.launchpad.net/ubuntu/+source/emacs24/+bug/1175422, not worked on my computer
(setq vc-handled-backends ())

;; So no auto-fill in HTML mode and other Text mode
(remove-hook 'text-mode-hook 'turn-on-auto-fill)

(set-cursor-color "orange")

(setq dotfiles-dir (file-name-directory (or load-file-name (buffer-file-name))))

(defun recompile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  ;; TODO: remove elpa-to-submit once everything's submitted.
  (byte-recompile-directory dotfiles-dir 0))

(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jk" 'undo)

(require 'iy-go-to-char)
(key-chord-define-global "jj" 'iy-go-to-char)
(key-chord-define-global "vv" 'iy-go-to-char-backward)

;; (require 'multiple-cursors)
;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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

;; (require 'helm-config)

(require 'sass-mode)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(global-auto-revert-mode 1)

(ido-yes-or-no-mode t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("3b0a350918ee819dca209cec62d867678d7dac74f6195f5e3799aa206358a983" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" default))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:foreground "#030303" :background "#bdbdbd" :box nil))))
 '(mode-line-inactive ((t (:foreground "#f9f9f9" :background "#666666" :box nil)))))


(getenv "PATH")
(getenv "STUDIO")

(require 'quickrun)
(global-set-key (kbd "<f8>") 'quickrun)

;; even in ruby mode, it seems not good enough
;; (global-aggressive-indent-mode 1)
;; (add-to-list 'aggressive-indent-excluded-modes 'html-mode)
;; (add-to-list 'aggressive-indent-excluded-modes 'jade-mode)

;; seems not useful
(setq-default tab-width 2)
