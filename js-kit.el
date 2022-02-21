(defvar js-packages '(
                      jade-mode
                      json-mode
                      coffee-mode
                      rainbow-mode ;; give color on css file. need background color to be white
                      sass-mode
                      js2-mode
											typescript-mode
											tide
											;; company ;; enhance tide
                      )
  )

(dolist (p js-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load js packages

(setq typescript-indent-level 2)


;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
	)

(add-hook 'typescript-mode-hook #'setup-tide-mode)
;; change json indention to 4 space.
(add-hook 'json-mode-hook
          (lambda ()
            (make-local-variable 'js-indent-level)
            (setq js-indent-level 2)))

(setq js-indent-level 2)

(eval-after-load 'js2-mode
  '(progn
     (define-key js2-mode-map (kbd "C-l") " => ")))

(eval-after-load 'typescript-mode
  '(progn
     (define-key typescript-mode-map (kbd "C-l") " => ")))
