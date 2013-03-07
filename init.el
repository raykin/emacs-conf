;; setup el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync)
;; END setup el-get

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

;; group of useful RoR plugins
(load "ror-kit.el")
(load "custom_rinari.el")

;; my start working dir. change it to your favorite
;; put it at the end of file cause it can change emacs variables, ex: default-directory
(cd "~/studio/ticdev")

;; remove autofill which was defined in emacs-starter-kit
(remove-hook 'prog-mode-hook 'esk-local-comment-auto-fill)
