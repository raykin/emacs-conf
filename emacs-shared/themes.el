;;; themes.el --- Theme configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; Doom themes setup

;;; Code:

;; Explicitly install doom-themes and wait for it to complete
(straight-use-package 'doom-themes)

;; Add doom-themes to load-path explicitly
(add-to-list 'custom-theme-load-path
             (expand-file-name "straight/build/doom-themes" straight-base-dir))

;; Configure doom themes
(setq doom-themes-enable-bold t
      doom-themes-enable-italic t)
(load-theme 'doom-one t)

;; Load doom-themes features after theme is loaded
(require 'doom-themes)
(doom-themes-visual-bell-config)
(doom-themes-org-config)

(provide 'themes)
;;; themes.el ends here
