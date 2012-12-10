;; my start working dir. change it to your favorite
(cd "~/studio/ticdev")

;; Add smart-tab
(require 'smart-tab)
(global-smart-tab-mode 1)
;; it make yas hotkey disworked. so we remap yas hotkey
;; see more on http://blog.binchen.org/?p=357
(global-set-key (kbd "C-;") 'yas/expand)

