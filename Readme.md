### Emacs Version
24

### Project Rule
I've copy and create some emacs configuration repos.But all are not good enough and maintatinable.

And finally I decide follow several rules to create a new one.

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

6.5 remove ruby-electric on ror-kit branch. cause it conflict with smart-tab.
