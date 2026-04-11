Emacs Config
============

```bash
git clone git@github.com:raykin/emacs-conf.git ~/studio/emacs-conf
```

- `emacs-shared/` — shared modules
- `emacs-daily/` — daily use (md, txt, json, yml); symlinked from `~/.emacs.d/init.el`
- `emacs-rails/`, `emacs-angular/`, `emacs-react/` — per-stack configs

Daily use (default): `emacs . &`

Per-stack: `emacs -q -l ~/studio/emacs-conf/emacs-rails/init.el`

Requires Emacs 30+. Set `SOCKS_PORT` env var if using proxy.
