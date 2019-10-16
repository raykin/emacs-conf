(defvar js-packages '(
                      jade-mode
                      json-mode
                      coffee-mode
                      rainbow-mode ;; give color on css file. need background color to be white
                      sass-mode
                      js2-mode
											typescript-mode
											;; tide
											;; company ;; enhance tide
                      )
  )

(dolist (p js-packages)
  (when (not (package-installed-p p))
    (package-install p)))
;; END load js packages

(setq typescript-indent-level 2)


;; change json indention to 4 space.
;; (add-hook 'json-mode-hook
;;           (lambda ()
;;             (make-local-variable 'js-indent-level)
;;             (setq js-indent-level 4)))

(setq js-indent-level 2)
