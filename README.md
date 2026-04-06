Emacs Config
============

```bash
git clone git@github.com:raykin/emacs-conf.git ~/studio/emacs-conf
```

- `emacs-shared/` — shared modules
- `emacs-rails/`, `emacs-angular/`, `emacs-react/` — per-stack configs

Launch: `emacs -q -l ~/studio/emacs-conf/emacs-rails/init.el`

Requires Emacs 30+. Set `SOCKS_PORT` env var if using proxy.
