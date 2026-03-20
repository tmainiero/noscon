{ config, lib, pkgs, ... }:

let cfg = config.my.neovim-system;
in {
  options.my.neovim-system = {
    enable = lib.mkEnableOption "Neovim (system-level with basic plugins)";
  };

  config = lib.mkIf cfg.enable {
    environment.systemPackages = with pkgs; [
      (neovim.override {
        vimAlias = true;
        configure = {
          packages.myPlugins = with pkgs.vimPlugins; {
            start = [
              vim-nix
              vim-lastplace
              vim-cool
              vim-repeat
              vim-surround
              vim-commentary
              vim-sneak
              vim-airline
              auto-pairs
            ];
            opt = [];
          };
          customRC = ''
            " Baseline system-level vimrc
            set nocompatible
            set backspace=indent,eol,start
            set number relativenumber
            " Show filename in title
            set title
            set mouse=a
            set showcmd
            " Always show statusline
            set laststatus=2
            " Smartcase search
            set ignorecase smartcase

            " ==Indentation==
            set autoindent
            " Tab to space conversion if needed
            set tabstop=4
            " Do not expand tabs globally
            set softtabstop=0 noexpandtab
            " Word-wrapped lines indented as much as parent
            set breakindent
            " Word-wrap does not split words
            set formatoptions=l linebreak

            " == Keybindings
            let mapleader = "\<Space>"
            nnoremap <silent> <C-L> :call NumberToggle() <CR>

            " Yank to clipboard
            nnoremap <leader>Y "+yg_
            nnoremap <leader>y "+y
            vnoremap <leader>y "+y

            " Paste from clipboard
            nnoremap <leader>p "+p
            nnoremap <leader>P "+P
            vnoremap <leader>p "+p
            vnoremap <leader>P "+P

            "Move lines around with alt keys
            nnoremap <A-j> :m .+1<CR>==
            nnoremap <A-k> :m .-2<CR>==
            inoremap <A-j> <ESC>:m .+1<CR>==gi
            inoremap <A-k> <ESC>:m .-2<CR>==gi
            vnoremap <A-j> :m '>+1<CR>gv=gv
            vnoremap <A-k> :m '<-2<CR>gv=gv

            " == Plugin Settings
            " Delete matched pairs
            let g:AutoPairsMapBS = 1
            let g:AutoPairsCompleteOnlyOnSpace = 1
            let g:AutoPairsCompatibleMaps = 0
            " ...
          '';
        };
      }
    )];
  };
}
