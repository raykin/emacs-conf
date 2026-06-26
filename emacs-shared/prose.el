;;; prose.el --- English spelling and grammar checking for prose -*- lexical-binding: t; -*-

;;; Commentary:
;; flyspell (live typo check via aspell) + langtool (grammar via LanguageTool).
;; Tuned for non-native writers: catches typos, articles, prepositions,
;; verb tense, and subject-verb agreement.

;;; Code:

;; --- Spelling: flyspell + aspell ---
(defconst raykin/prose-dir
  (file-name-directory (or load-file-name buffer-file-name))
  "Directory holding prose.el and the shared aspell word list.")

(setq ispell-program-name "aspell"
      ispell-dictionary "en_US"
      ispell-extra-args '("--sug-mode=ultra" "--lang=en_US")
      ;; Shared, version-controlled whitelist for tech words (OnPush, etc.).
      ispell-personal-dictionary (expand-file-name "aspell-words.txt" raykin/prose-dir))

(use-package flyspell
  :straight nil
  :hook ((text-mode . flyspell-mode)
         (markdown-mode . flyspell-mode)
         (prog-mode . flyspell-prog-mode))
  :config
  ;; C-; is taken (claude-send); use C-c s for corrections instead.
  (define-key flyspell-mode-map (kbd "C-;") nil)
  (setq flyspell-issue-message-flag nil))

;; Popup a suggestion list (via vertico) for the misspelled word at point.
(use-package flyspell-correct
  :after flyspell
  :bind (:map flyspell-mode-map
              ("C-c s" . flyspell-correct-at-point)
              ("C-c S" . flyspell-correct-wrapper)))

;; --- Grammar/style: LanguageTool ---
;; Auto-detect the LanguageTool jar from common install locations.
(use-package langtool
  :commands (langtool-check langtool-check-done langtool-correct-buffer)
  :init
  (setq langtool-language-tool-jar
        (seq-find #'file-exists-p
                  '("/opt/LanguageTool/languagetool-commandline.jar"
                    "/usr/share/languagetool/languagetool-commandline.jar"
                    "/opt/homebrew/opt/languagetool/libexec/languagetool-commandline.jar"
                    "/usr/local/opt/languagetool/libexec/languagetool-commandline.jar"
                    "~/.local/share/LanguageTool/languagetool-commandline.jar")))
  :config
  (setq langtool-default-language "en-US"
        langtool-mother-tongue nil))

;; --- Live grammar: flycheck-languagetool ---
;; Re-checks grammar shortly after you stop typing, underlining issues inline
;; like flyspell does for spelling.
(use-package flycheck
  :hook ((text-mode . flycheck-mode)
         (markdown-mode . flycheck-mode))
  :config
  ;; Debounce: only grammar-check after you pause typing for 1.5s.
  (setq flycheck-idle-change-delay 1.5))

(use-package flycheck-languagetool
  :hook ((text-mode . flycheck-languagetool-setup)
         (markdown-mode . flycheck-languagetool-setup))
  :init
  (setq flycheck-languagetool-server-jar
        (seq-find #'file-exists-p
                  '("/opt/LanguageTool/languagetool-server.jar"
                    "/usr/share/languagetool/languagetool-server.jar"
                    "/opt/homebrew/opt/languagetool/libexec/languagetool-server.jar"
                    "/usr/local/opt/languagetool/libexec/languagetool-server.jar"
                    "~/.local/share/LanguageTool/languagetool-server.jar")))
  (setq flycheck-languagetool-language "en-US"
        ;; Let flyspell own spelling; LanguageTool does grammar/style only.
        flycheck-languagetool-check-spelling nil))

(provide 'prose)
;;; prose.el ends here
