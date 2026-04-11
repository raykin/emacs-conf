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
(require 'windows)
(require 'keybindings)
```

## Project-Specific Configs

- **emacs-daily/**: Daily-use config for text files (md, txt, json, yml); symlinked from `~/.emacs.d/init.el`
- **emacs-rails/**: Ruby/Rails-specific packages (projectile-rails, ruby-ts-mode, LSP)
- **emacs-angular/**: TypeScript/Angular-specific packages (typescript-ts-mode, web-mode, LSP)
- **emacs-react/**: React/TypeScript-specific packages
