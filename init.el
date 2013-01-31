(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings starter-kit-js starter-kit-ruby mode-compile session markdown-mode color-theme color-theme-gruber-darker yasnippet-bundle textmate)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))

;; Add loading path
(add-to-list 'load-path default-directory)
(add-to-list 'load-path (concat default-directory "plugin"))
(add-to-list 'load-path (concat default-directory "plugin/rhtml/"))

;; custom config, most are global lib and configuration
(load "custom.el")

(add-to-list 'load-path (concat default-directory "plugin/Enhanced-Ruby-Mode"))
(require 'ruby-mode)

;; group of useful RoR plugins
(load "ror-kit.el")


;; my start working dir. change it to your favorite
;; put it at the end of file cause it can change emacs variables, ex: default-directory
(cd "~/studio/ticdev")

;; remove autofill which was defined in emacs-starter-kit
(remove-hook 'prog-mode-hook 'esk-local-comment-auto-fill)
