# Neovim: Home manager module
#
# Plugin configs are loaded via extraConfig (before filetype detection) rather
# than home-manager's {plugin, config} attrset. Home-manager appends plugin
# config blocks AFTER extraConfig in the generated init file, but ftplugin-based
# plugins (vimtex, ale, ultisnips) initialize during extraConfig's source call
# in neovim 0.11+, so g: variables set in late-loaded config blocks are ignored.
# By concatenating plugin configs into extraConfig ourselves, we guarantee they
# execute first. See dotfiles/nvim/home-manager-feature-request.md for details.
{ config, pkgs, ... }:
let
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
    # {
    #   plugin = supertab;
    #   configFile = "supertab-config.vim";
    # }
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
  config = {
    home.file = {
      "${config.xdg.configHome}/nvim/after".source = ../../dotfiles/nvim/after;
      # Spell file is frequently changing, must be out of store
      # "${config.xdg.configHome}/nvim/spell".source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/nvim/spell;
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

  # environment.systemPackages = with pkgs; [
  #   (neovim.override {
  #     vimAlias = true;
  #     configure = {
  #       packages.myPlugins = with pkgs.vimPlugins; {
  #         start = [ 
  #       # Languages
  #       vim-nix
  #       vimtex
  #       haskell-vim
  #       # vim-haskell-indent
  #       # octave.vim
  #       vim-gnupg
  #       # markdown-preview.nvim

  #       # Appearance
  #       ## Colorschemes
  #       palenight-vim
  #       gruvbox-nvim
  #       ayu-vim
  #       badwolf
  #       ## Statusline
  #       vim-airline

  #       # Behavior
  #       vim-lastplace # opens from last spot
  #       vim-autoswap # switch to already open file
  #       vim-cool # automatic :noh
  #       auto-pairs # pair () [] {}

  #       # Enhancements
  #       # Basic
  #       vim-repeat
  #       vim-surround
  #       vim-commentary
  #       vim-abolish
  #       vim-matchup
  #       ## Fancier
  #       vim-easy-align
  #       vim-exchange

  #       # Git stuff
  #       vim-fugitive

  #       ## Motion
  #       vim-sneak # two letter search using 's'
  #       vim-easymotion # two letter search everywhere 

  #       # Heavy plugins
  #       ale
  #       supertab
  #       fzf-vim
  #       ultisnips
  #     ]; 
  #     opt = [];
  #   };
  #       customRC = ''
  #         let g:config_dir=$HOME.'/noscon/dotfiles/nvim'
  #         " execute "set runtimepath +=".g:config_dir

  #         let global_colorscheme = 'palenight'
  #         let fallback_colorscheme = 'badwolf'

  #         let myterm = $TERM
  #         if has('gui_running')
  #         " With GUI
  #         execute 'colorscheme ' . global_colorscheme
  #         elseif myterm=~'linux'
  #         " TTY
  #         execute 'colorscheme ' . fallback_colorscheme
  #         else
  #         " Without GUI and not in TTY (e.g. terminal emulator)
  #         execute 'colorscheme ' . global_colorscheme
  #         endif


  #         " Baseline system-level vimrc
  #         set nocompatible
  #         set backspace=indent,eol,start
  #         set number relativenumber
  #         " Show filename in title
  #         set title
  #         set mouse=a
  #         set showcmd
  #         " Always show statusline
  #         set laststatus=2
  #         " Smartcase search
  #         set ignorecase smartcase

  #         " ==Indentation==
  #         set autoindent
  #         " Tab to space conversion if needed
  #         set tabstop=4
  #         " Do not expand tabs globally
  #         set softtabstop=0 noexpandtab
  #         " Word-wrapped lines indented as much as parent
  #         set breakindent
  #         " Word-wrap does not split words
  #         set formatoptions=l linebreak

  #         " == Keybindings
  #         let mapleader = "\<Space>"
  #         nnoremap <silent> <C-L> :call NumberToggle() <CR>

  #         " Yank to clipboard
  #         nnoremap <leader>Y "+yg_
  #         nnoremap <leader>y "+y
  #         vnoremap <leader>y "+y

  #         " Paste from clipboard
  #         nnoremap <leader>p "+p
  #         nnoremap <leader>P "+P
  #         vnoremap <leader>p "+p
  #         vnoremap <leader>P "+P

  #         "Move lines around with alt keys
  #         nnoremap <A-j> :m .+1<CR>==
  #         nnoremap <A-k> :m .-2<CR>==
  #         inoremap <A-j> <ESC>:m .+1<CR>==gi
  #         inoremap <A-k> <ESC>:m .-2<CR>==gi
  #         vnoremap <A-j> :m '>+1<CR>gv=gv
  #         vnoremap <A-k> :m '<-2<CR>gv=gv

  #         " == Plugin Settings
  #         " Delete matched pairs
  #         let g:AutoPairsMapBS = 1
  #         let g:AutoPairsCompleteOnlyOnSpace = 1
  #         let g:AutoPairsCompatibleMaps = 0

  #         " == Ale
  #         let g:ale_set_signs=1
  #         let g:ale_virtualtext_cursor='disable'
  #         let g:ale_echo_cursor=1

  #         " == Ultisnips
  #         let g:UltisnipsEditSplit = 'vertical'
  #         nmap <leader>ue :UltiSnipsEdit<CR>

  #         let g:UltiSnipsSnippetDirectories = [ g:config_dir.'/my_snippets' ]

  #         let g:UltisnipsExpandTrigger = "<tab>"
  #         let g:UltisnipsJumpForwardTrigger = "<C-F>"
  #         let g:UltiSnipsBackwardTrigger = "<C-D>"

  #         " == Vim Sneak
  #         " EasyMotion Alternative--suggests labels
  #         let g:sneak#label = 1
  #         " disable strange unicode conversion
  #         let g:tex_conceal = ""
  #       '';
  #     };
  #   }
  #   )];
