### Deprecated

### Emacs Version
24

### Install
```shell
    git clone git@github.com:raykin/emacs-conf.git .emacs.d
```

### Project Rule
I've copy and create some emacs configuration repos.But all are not good enough and maintatinable.

And finally I decide following several rules to create a new one.

* Less configuration is much more better.
* Stable is most important.
* So master branch must be less and stable.
* Every new feature which depend on other resources must be build on a
  new branch first.
* Feature log is really needed.

### Usage
It's better to test it before use it as default configuration.

So clone the repo into emacs-conf and cd it and run
```shell
emacs -q -l init.el
```
First run will take several minutes to install elpa packages

### ELPA Dependency
see code variable my-packages in init.el

### Feature log

1. on branch master
start with emacs-starter-kit and add a little custom config.

2. Add smart tab feature on smart-tab branch. Its hotkey conflict with yas, so we change latter hot key
so far so good.

3. Add session feature on session-mode branch.

4. Add ror-kit branch to add several convenient lib: autopair, rhtml, sass, yaml.

5. Add markdown-mode and other global configure.
So far so good.

6. Add Textmate-mode configure.

7. remove ruby-electric on ror-kit branch. cause it conflict with smart-tab.

8. Setup el-get. And replace ruby-mode with enh-ruby-mode(it is a fork of Enhanced-Ruby-Mode but more active)

9. Install load-relative. Reinstall some lib by el-get. Remove enh-ruby-mode cause it seems conflicts with color-theme.

10. Install jade-mode manually cause package installation was failed.

11. Merge robe-mode which install robe-mode and cleanup el-get and elpa packages.

12. Add Projectile-rails mode. It replace the Rinari mode. Remove Rinari.

13. Remove starter-kit-ruby.
