# noscon: A NixOS Configuration for a Working Mathematician

> Disclaimer: This is a private configuration that will change drastically based on my own use cases: it is not a community distribution or framework.
> This configuration is only on Github here for my own convenience and to inspire others.

## Overview 
This is an evolving, pragmatic NixOS configuration + various dotfiles, built around my daily computing use cases:

+ *evolving* because I'm still figuring out what kind of structure I like best, and have a lot to learn.
There are many TODOs to properly refactor the code.
+ *pragmatic* because I strive for reproducibility, purity, and modularity, but there may be sacrifices as temporary workarounds or due to my current lack of knowledge.

As far as my use cases: I'm a mathematician who spends a lot of time in [neovim](https://neovim.io) writing LaTeX using the [vimtex](https://github.com/lervag/vimtex) plugin; 
I live in terminal emulators, and I like to toy with functional programming.

## Details:

### NixOS Specifics
  - Based on an entry point flake
  - Unstable channel by default (this may change)
  - Home manager is used as a module, although I might move it to a standalone


### Primary Desktop Configuration Profile

+ **Window Manager**: a highly customized [XMonad](https://xmonad.org)
+ **Status Bar**: [XMobar](https://hackage.haskell.org/package/xmobar)
+ **Shell**: Fish shell with a custom prompt forked from the sample fish [nim prompt](https://github.com/fish-shell/fish-shell/blob/master/share/tools/web_config/sample_prompts/nim.fish)
+ **Terminal Emulator**: Alacritty
+ **Editor**: Neovim, with many custom [Ultisnips](https://github.com/SirVer/ultisnips) snippets that built around latex snippets for my current research papers.
+ Other
  - I use [Interception tools](https://gitlab.com/interception/linux/tools) with custom plugins to modify the behavior of pressed keys: 
    + my caps lock key is swapped with escape (turning into escape immediately on press, this is different than [caps2esc](https://github.com/oblitum/caps2esc)); 
    + my right control functions as another super key (useful for XMonad); 
    + and my enter key functions as right control when held, enter when tapped.

### Servers
I run a couple of servers, but they're not on NixOS...yet.

### Organization
Here's a description of the most important files and directories:
  + `flake.nix`: entrypoint flake
  + `configuration.nix`: currently the main desktop, system-level config
  + `home.nix`: some user-level configuration
  + `modules/`: NixOS modules
  + `home-modules/`: modules called by home-manager
  + `packages/`: custom packages
  + `dotfiles/`: configuration files and data
  + `data/`: more static data: (TODO: combine with dotfiles)
  + `hosts/`: machines to run NixOS on; currently there is only one

## Why NixOS?
`bespoke configuration + lazy functional programming mathematician => NixOS`

## Should I use NixOS?
Paraphrasing Henrik Lissner: [almost certainly no](https://github.com/hlissner/dotfiles?tab=readme-ov-file#frequently-asked-questions).

## References
The following dotfiles are configurations that I use as inspiration and strive for:

+ [hlissner's config](https://github.com/hlissner/dotfiles): I aspire toward a configuration with this sort of organization
+ [vyp's config](https://codeberg.org/vyp/dots): I picked up a few tricks from here
