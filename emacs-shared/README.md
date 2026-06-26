# Emacs Shared Configuration

This directory contains shared Emacs configuration files used across different project-specific Emacs setups.

## Structure

```
emacs-shared/
├── base.el            # Core Emacs settings, UI, performance
├── package-manager.el # straight.el and use-package setup
├── proxy.el           # SOCKS proxy configuration
├── completion.el      # Vertico, Orderless, Consult, Corfu
├── themes.el          # Doom themes
├── git.el             # Magit configuration
├── search.el          # AG and wgrep-ag
├── utils.el           # Utility packages (treemacs, markdown)
├── prose.el           # English spelling + grammar checking
├── aspell-words.txt   # Shared personal spelling dictionary (tech words)
├── windows.el         # Window management
└── keybindings.el     # Global keybindings
```

## Usage

Project-specific configs load these shared files:

```elisp
(add-to-list 'load-path (expand-file-name "../emacs-shared" user-emacs-directory))

(require 'package-manager)
(require 'base)
(require 'proxy)
(require 'completion)
(require 'themes)
(require 'git)
(require 'search)
(require 'utils)
(require 'prose)
(require 'windows)
(require 'keybindings)
```

## Prose Checking (`prose.el`)

English spelling and grammar checking for writing reports/docs. Hooks `text-mode`
and `markdown-mode`.

| Tool | What | How |
|---|---|---|
| flyspell | Live spelling underline | Automatic as you type |
| flyspell-correct | Suggestion popup at point | `C-c s` (pick a fix, or `[Save word]` to whitelist) |
| flycheck-languagetool | Live grammar (1.5s debounce) | Automatic after you pause |
| langtool | On-demand grammar snapshot | `M-x langtool-check`, `langtool-correct-buffer`, `langtool-check-done` |

Spelling exceptions (tech words like `OnPush`, `config`, `repo`) live in the
committed `aspell-words.txt`. Add words via `C-c s` → `[Save word]`, then
`M-x ispell-kill-ispell` to reload.

### System dependencies (per machine)

Emacs packages auto-install via straight.el on first launch. Spell/grammar engines
are system binaries you install once:

- **Linux:** `aspell`; LanguageTool unzipped to `/opt/LanguageTool/`
- **macOS:** `brew install aspell languagetool` (brew pulls in Java)

`prose.el` auto-detects the LanguageTool jar across Linux and Homebrew paths.

## Project-Specific Configs

- **emacs-daily/**: Daily-use config for text files (md, txt, json, yml); symlinked from `~/.emacs.d/init.el`
- **emacs-rails/**: Ruby/Rails-specific packages (projectile-rails, ruby-ts-mode, LSP)
- **emacs-angular/**: TypeScript/Angular-specific packages (typescript-ts-mode, web-mode, LSP)
- **emacs-react/**: React/TypeScript-specific packages
