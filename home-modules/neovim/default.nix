# Neovim: Home manager module
{ config, pkgs, ... }:
let 
  config-dir      = ../../dotfiles/nvim/my-config;
  plug-config-dir = ../../dotfiles/nvim/plugin;
  functions       = builtins.readFile "${config-dir}/functions.vim";
  settings        = builtins.readFile "${config-dir}/settings.vim";
  keybindings     = builtins.readFile "${config-dir}/keybindings.vim";
  # Note: extraConfig is loaded *after* plugin specific configs
  # Because mapleader is set first, we cannot modularize plugin keybindings
  plugin-keybindings = builtins.readFile "${config-dir}/plugin-keybindings.vim";

  # Helper for wrapping a plugin up with its vimscript configuration
  # found in plug-config-dir; config file names are standardized
  # withVimscriptConfig = 
  # let
  #   inherit plug-config-dir;
  # in
  # plugin-name: 
  # {
  #   plugin = plugin-name;
  #   config = builtins.readFile "${plug-config-dir}/${plugin-name}-config.vim";
  # };
in
{
  config = {
    home.file ={
      "${config.xdg.configHome}/nvim/after".source = ../../dotfiles/nvim/after;
      # Spell file is frequently changing, must be out of store
      # "${config.xdg.configHome}/nvim/spell".source = config.lib.file.mkOutOfStoreSymlink ../../dotfiles/nvim/spell;
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      extraConfig = functions + settings + keybindings + plugin-keybindings;

      plugins = with pkgs.vimPlugins; [
        # Appearance
        ## Colorschemes
        palenight-vim
        gruvbox-nvim
        {
          plugin = ayu-vim;
          config = builtins.readFile "${plug-config-dir}/ayu-vim-config.vim";
        }
        ## Statusline
        {
          plugin = vim-airline;
          config = builtins.readFile "${plug-config-dir}/vim-airline-config.vim";
        }

        # Languages
        # vim-gnupg
        vim-nix
        {
          plugin = vimtex;
          config = builtins.readFile "${plug-config-dir}/vimtex-config.vim";
        }
        haskell-vim
        # vim-haskell-indent
        # octave.vim

        # Behavior
        vim-lastplace # opens from last spot
        vim-autoswap  # switch to already open file
        {
          plugin = vim-cool; # automatic :noh
          config = builtins.readFile "${plug-config-dir}/vim-cool-config.vim";
        }
        # nvim-autopairs
        {
          plugin = auto-pairs; # pair () [] {}
          config = builtins.readFile "${plug-config-dir}/auto-pairs-config.vim";
        }
        markdown-preview-nvim

        # Enhancements
        # Basic
        vim-repeat
        {
          plugin = vim-surround;
          config = builtins.readFile "${plug-config-dir}/vim-surround-config.vim";
        }
        vim-commentary
        vim-abolish
        vim-matchup

        ## Fancier
        vim-easy-align
        vim-exchange

        # Git stuff
        vim-fugitive

        ## Motion
        {
          plugin = vim-sneak; # two letter search using 's'
          config = builtins.readFile "${plug-config-dir}/vim-sneak-config.vim";
        }
        vim-easymotion # two letter search everywhere 

        # Heavy plugins
        {
          plugin = ale; # linter
          config = builtins.readFile "${plug-config-dir}/ale-config.vim";
        }
        # {
        #   plugin = supertab;
        #   config = builtins.readFile "${plug-config-dir}/supertab-config.vim";
        # }
        {
          plugin = fzf-vim;
          config = builtins.readFile "${plug-config-dir}/fzf-vim-config.vim";
        }
        {
          plugin = ultisnips;
          config = builtins.readFile "${plug-config-dir}/ultisnips-config.vim";
        }
    ];
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
