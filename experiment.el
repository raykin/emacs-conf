
;; (require 'multiple-cursors)
;; (global-set-key (kbd "C-S-c C-S-c") 'mc/edit-lines)
;; (global-set-key (kbd "C->") 'mc/mark-next-like-this)
;; (global-set-key (kbd "C-<") 'mc/mark-previous-like-this)
;; (global-set-key (kbd "C-c C-<") 'mc/mark-all-like-this)


(require 'key-chord)
(key-chord-mode 1)
(key-chord-define-global "jk" 'undo)

(require 'iy-go-to-char)
(key-chord-define-global "jj" 'iy-go-to-char)
(key-chord-define-global "vv" 'iy-go-to-char-backward)

(defun recompile-init ()
  "Byte-compile all your dotfiles again."
  (interactive)
  ;; TODO: remove elpa-to-submit once everything's submitted.
  (byte-recompile-directory dotfiles-dir 0))

