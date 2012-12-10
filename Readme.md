### Emacs Version
24

### Project Rule
I've copy and create some emacs configuration repo.But all are not good enough and maintatinable.

And finally I decide follow several rules to 

Less configuration is much more better. Stable is most important. So master branch must be less and stable.
Every new feature which depend on other resources must be build on a new branch first.
Feature log is really needed.

### Usage
It's better to test it before use it as default configuration.
So clone the repo into emacs-conf and cd it and run 
emacs -q -l init.el

### ELPA Dependency 
make sure following package all existed 

* mode-compile


### Feture log

1. on branch master
start with emacs-starter-kit and add a little custom config.

2. Add smart tab feature on smart-tab branch. Its hotkey conflict with yas, so we change latter hot key 
so far so good.
