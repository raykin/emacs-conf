;; setup el-get
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (let (el-get-master-branch)
      (goto-char (point-max))
      (eval-print-last-sexp))))

(el-get 'sync '(load-relative smart-tab coffee-mode rhtml-mode color-theme-tomorrow color-theme-railscasts autopair sass-mode yaml-mode))
;; END setup el-get

;; Load ELPA package
(require 'package)

(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)

(when (not package-archive-contents)
  (package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages '(starter-kit starter-kit-lisp starter-kit-bindings starter-kit-js starter-kit-ruby mode-compile session markdown-mode yasnippet-bundle textmate rinari)
  "A list of packages to ensure are installed at launch.")

(dolist (p my-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load elpa package

(require 'load-relative)
(load-relative "./custom.el")

;; group of useful RoR plugins
(load-relative "./ror-kit.el")
(load-relative "./custom_rinari.el")

;; my start working dir. change it to your favorite
;; put it at the end of file cause it can change emacs variables, ex: default-directory
(cd "~/studio/ticdev")

;; remove autofill which was defined in emacs-starter-kit
(remove-hook 'prog-mode-hook 'esk-local-comment-auto-fill)
;; cause inf-ruby-keys not exist
(remove-hook 'ruby-mode-hook 'inf-ruby-keys)
