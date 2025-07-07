# Dotfiles Directory

This directory consists of configuration data for various user-level programs.
Some of these dotfiles are directly sourced by home manager modules, or deployed by home manager with `home.file`.
However, some settings of NixOS system-level modules are *not* sourced home manager deployed files from this directory: one must consult the corresponding module to determine which is the case.
Non-sourced or deployed dotfiles remain here for reference and for easing portability to other distributions.
