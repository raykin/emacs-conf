# Emacs Config

## Structure

- `emacs-shared/` — shared modules loaded by all configs
- `emacs-daily/` — daily-use config (md, txt, json, yml); symlinked from `~/.emacs.d/init.el`
- `emacs-rails/` — Rails development config
- `emacs-angular/` — Angular development config
- `emacs-react/` — React development config

Each `init.el` adds `../emacs-shared` to `load-path` and loads modules from there.

## Package Manager

- Uses **straight.el** + use-package (`straight-use-package-by-default t`)
- `straight-base-dir` is set to the `emacs-shared/` directory so packages are shared across all configs
- Emacs 30 installed via snap

## Shared Modules (`emacs-shared/`)

| File | Purpose |
|---|---|
| `package-manager.el` | straight.el bootstrap, exec-path-from-shell, macOS key bindings |
| `base.el` | Core settings, electric-pair, tree-sitter |
| `completion.el` | vertico + orderless + marginalia + consult + corfu |
| `themes.el` | doom-themes |
| `git.el` | Magit config; `/` → fuzzy file search in status buffer; auto-push after commit if upstream exists |
| `search.el` | Search config |
| `utils.el` | Misc utilities; markdown auto table-align on save; `raykin/claude-send-context` |
| `windows.el` | Window management |
| `keybindings.el` | Global keybindings |
| `proxy.el` | SOCKS proxy via `$SOCKS_PORT` env var |

## Key Decisions

- `straight-base-dir` points to `emacs-shared/` so all configs share one package installation
- `transient/` and `straight/` are gitignored — machine-local state
- `proxy.el` reads port from `$SOCKS_PORT` env var — set this in your shell before starting Emacs
- Function namespace prefix `raykin/` is an Emacs convention, not sensitive
- grip-mode was tried and removed — not useful; prefer in-buffer markdown rendering

## Editing Notes

- Changes to `emacs-shared/` affect all three configs (rails/angular/react) — test impact before committing
- `raykin-custom.el` in `emacs-rails/` is the Emacs custom-set-variables file — safe to commit
