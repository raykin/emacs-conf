;;; search.el --- Search tools configuration -*- lexical-binding: t; -*-

;;; Commentary:
;; AG and wgrep-ag setup

;;; Code:

;; AG - search tool
(use-package ag
  :bind ("C-x C-a" . ag-project)
  :config
  (setq ag-reuse-window t)
  (setq ag-reuse-buffers t)
  (add-to-list 'ag-arguments "--ignore-dir=images")
  (advice-add 'ag/search :after
              (lambda (&rest _)
                "Switch focus to the actual *ag search* buffer after running ag/search."
                (let ((ag-buffer (get-buffer "*ag search*")))
                  (when ag-buffer
                    (pop-to-buffer ag-buffer))))))

;; wgrep-ag - editable ag buffers
(use-package wgrep-ag)

;; Display buffer settings for search results
(add-to-list 'display-buffer-alist
             '("\\*ag search\\*" (display-buffer-same-window)))

(provide 'search)
;;; search.el ends here
