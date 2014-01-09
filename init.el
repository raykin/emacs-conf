;; setup el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync '(load-relative
                smart-tab
                coffee-mode
                rhtml-mode
                color-theme-railscasts
                autopair
                sass-mode
                yaml-mode
                slim-mode
                mode-compile
                session
                markdown-mode
                textmate
                robe-mode ;; Jump to ruby method definition
                php-mode
                imenu+
                wanderlust
                smartparens
                iy-go-to-char
                key-chord))
;; END setup el-get

;; TODO: has an error that Package assoc is obsolete, but didnt know which package

;; Load ELPA package
(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
  '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

(setq exec-path
      (append exec-path
              '("/home/leijing/.rbenv/shims")
              ))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit
                      starter-kit-lisp
                      starter-kit-bindings
                      starter-kit-js
                      rainbow-mode ;; give color on css file. need background color to be white
                      yasnippet
                      projectile-rails
                      vcard
                      )
  "A list of packages to ensure are installed at launch.")


(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load elpa package

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
(cd "~/studio/deltux")

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
(key-chord-define-global "fj" 'iy-go-to-char)
(key-chord-define-global "ds" 'iy-go-to-char-backward)
