;; Load ELPA package
(require 'package)

(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(
		      load-relative
		      multiple-cursors
                      rainbow-mode ;; give color on css file. need background color to be white
                      projectile
                      vcard
                      jade-mode
                      csv-mode
                      robe ;; Jump to ruby method definition
                      rbenv
                      exec-path-from-shell
                      hlinum
		      iy-go-to-char
		      key-chord
                      minitest
                      json-mode
                      sws-mode
		      smart-tab
		      coffee-mode
                      railscasts-theme
		      autopair
		      sass-mode
		      yaml-mode
		      slim-mode
		      mode-compile
		      session
		      markdown-mode
		      textmate
		      php-mode
                      better-defaults
                      paredit
                      idle-highlight-mode
                      ido-ubiquitous
                      find-file-in-project
                      magit
                      smex
                      ido-yes-or-no
                      )
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load elpa package

(exec-path-from-shell-initialize)

(require 'load-relative)
(load-relative "./custom.el")

;; group of useful RoR plugins
(load-relative "./ror-kit.el")

;; group of useful JS plugins
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

(require 'multiple-cursors)
(global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
(global-set-key (kbd "C->") 'mc/mark-next-like-this)
(global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
(global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)

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
