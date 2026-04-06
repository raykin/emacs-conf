# Emacs Shared Configuration

This directory contains shared Emacs configuration files used across different project-specific Emacs setups.

## Structure

```
emacs-shared/
├── base.el           # Core Emacs settings, UI, performance
├── package-manager.el # straight.el and use-package setup
├── proxy.el          # SOCKS proxy configuration
├── completion.el     # Vertico, Orderless, Consult, Corfu
├── themes.el         # Doom themes
├── git.el            # Magit configuration
├── search.el         # AG and wgrep-ag
├── claude-integration.el     # Claude Code integration
├── keybindings.el    # Global keybindings
└── utils.el          # Utility packages (treemacs, yasnippet)
```

## Usage

Project-specific configs load these shared files:

```elisp
;; Add shared directory to load path
(add-to-list 'load-path (expand-file-name "../emacs-shared" user-emacs-directory))

;; Load shared configs
(require 'base)
(require 'package-manager)
(require 'proxy)
(require 'completion)
(require 'themes)
(require 'git)
(require 'search)
(require 'utils)
(require 'claude-integration)
(require 'keybindings)
```

## Project-Specific Configs

- **emacs-rails/**: Ruby/Rails-specific packages (projectile-rails, ruby-ts-mode, LSP with Ruby)
- **emacs-ionic-angular/**: TypeScript/Angular-specific packages (typescript-ts-mode, web-mode, Angular LSP)

This structure keeps common configurations DRY while maintaining performance by loading only necessary packages per project.
