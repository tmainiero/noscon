# Neovim: Home manager module
#
# Plugin configs are loaded via extraConfig (before filetype detection) rather
# than home-manager's {plugin, config} attrset. Home-manager appends plugin
# config blocks AFTER extraConfig in the generated init file, but ftplugin-based
# plugins (vimtex, ale, ultisnips) initialize during extraConfig's source call
# in neovim 0.11+, so g: variables set in late-loaded config blocks are ignored.
# By concatenating plugin configs into extraConfig ourselves, we guarantee they
# execute first. See dotfiles/nvim/home-manager-feature-request.md for details.
{ config, lib, pkgs, ... }:

let
  cfg = config.my.neovim;
  config-dir      = ../../dotfiles/nvim/my-config;
  plug-config-dir = ../../dotfiles/nvim/plugin;
  functions       = builtins.readFile "${config-dir}/functions.vim";
  settings        = builtins.readFile "${config-dir}/settings.vim";
  keybindings     = builtins.readFile "${config-dir}/keybindings.vim";
  # Because mapleader is set first, we cannot modularize plugin keybindings
  plugin-keybindings = builtins.readFile "${config-dir}/plugin-keybindings.vim";

  # Each entry is either a bare plugin or { plugin, configFile } pair.
  # To disable a plugin, comment out or remove its single line.
  pluginDefs = with pkgs.vimPlugins; [
    # Appearance
    ## Colorschemes
    palenight-vim
    gruvbox-nvim
    { plugin = ayu-vim;      configFile = "ayu-vim-config.vim"; }
    ## Statusline
    { plugin = vim-airline;   configFile = "vim-airline-config.vim"; }

    # Languages
    # vim-gnupg
    vim-nix
    { plugin = vimtex;        configFile = "vimtex-config.vim"; }
    haskell-vim
    # vim-haskell-indent
    # octave.vim

    # Behavior
    vim-lastplace # opens from last spot
    vim-autoswap  # switch to already open file
    { plugin = vim-cool;      configFile = "vim-cool-config.vim"; }  # automatic :noh
    # nvim-autopairs
    { plugin = auto-pairs;    configFile = "auto-pairs-config.vim"; }  # pair () [] {}
    markdown-preview-nvim

    # Enhancements
    # Basic
    vim-repeat
    { plugin = vim-surround;  configFile = "vim-surround-config.vim"; }
    vim-commentary
    vim-abolish
    vim-matchup

    ## Fancier
    vim-easy-align
    vim-exchange

    # Git stuff
    vim-fugitive

    ## Motion
    { plugin = vim-sneak;     configFile = "vim-sneak-config.vim"; }  # two letter search using 's'
    vim-easymotion # two letter search everywhere

    # Heavy plugins
    { plugin = ale;            configFile = "ale-config.vim"; }  # linter
    { plugin = fzf-vim;       configFile = "fzf-vim-config.vim"; }
    { plugin = ultisnips;     configFile = "ultisnips-config.vim"; }
  ];

  # Normalize bare plugins to attrsets
  normalize = p: if p ? configFile then p else { plugin = p; configFile = null; };
  normalized = map normalize pluginDefs;

  # Extract flat plugin list (for home-manager plugins field)
  plugin-list = map (p: p.plugin) normalized;

  # Concatenate all plugin config files (for prepending to extraConfig)
  plugin-configs = builtins.concatStringsSep "\n" (
    map (p: builtins.readFile (plug-config-dir + "/${p.configFile}"))
    (builtins.filter (p: p.configFile != null) normalized)
  );
in
{
  options.my.neovim = {
    enable = lib.mkEnableOption "Neovim (home-manager with full plugin pipeline)";
  };

  config = lib.mkIf cfg.enable {
    home.file = {
      "${config.xdg.configHome}/nvim/after".source = ../../dotfiles/nvim/after;
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      # Plugin configs come first so g: variables are set before ftplugin fires
      extraConfig = plugin-configs + "\n" + functions + settings + keybindings + plugin-keybindings;

      plugins = plugin-list;
    };
  };
}
