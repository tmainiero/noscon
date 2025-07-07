""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              General Settings                              "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"=========================== Convenient Variables ==========================="

" Global Colorscheme
let global_colorscheme='palenight'
" Fallback colorscheme (TTY)
let fallback_colorscheme='slate'

"================================ Spellfile ================================="
set spellfile=~/noscon/dotfiles/nvim/spell/en.utf-8.add

"====================== Appearance ======================"

set number relativenumber " hybrid line numbers
set title                 " filename in title
set mouse=a               " mouse support in terminal
set showcmd               " show commands
set laststatus=2          " always show status line (air/light)line

"======= Indentation Settings ======="
set autoindent                " Preserve previous line indentation
set tabstop=4                 " with a tab in spaces
set softtabstop=0 noexpandtab " do not expand tabs globally
set shiftwidth=4              " with of an ident
                              " (c.f. https://stackoverflow.com/questions/2828174/word-wrap-in-vim-preserving-indentation)
set breakindent               " word-wrapped lines indented as much as parent
set formatoptions=l linebreak " word-wrap does not split words

"=========== Colors ============"
syntax enable  "Use syntax highlighting     

"True color support if available 
if has("termguicolors")
  set termguicolors
endif	

set colorcolumn=0 "Prevent change of color at 80 columns

"=========== Colorscheme ============"
" Different colorscheme depending on whether a terminal emulator
" is being run or not	
let myterm = $TERM
if has('gui_running')
    " With GUI
    execute 'colorscheme ' . global_colorscheme
elseif myterm=~'linux'
    " TTY
    execute 'colorscheme ' . fallback_colorscheme
else
    " Without GUI and not in TTY (e.g. terminal emulator)
    execute 'colorscheme ' . global_colorscheme
endif

"======= Searching ========"
" set ignorecase smartcase "ignore cases in search except when capitals exist

" Inspired by https://www.youtube.com/watch?v=XA2WjJbmmoM
" FINDING FILES
" Search down into Subfolders
" Provides tab-completion for all file-related tasks
set path+=**

"Display all matching files when we tab complete
set wildmenu
set wildmode=list:longest,full

" Ignore build files
" python
set wildignore+=*.pyc
set wildignore+=*_build/*
set wildignore+=*/coverage/*

" C 
set wildignore+=*.o
set wildignore+=*.obj

" Make search highlighting more readable
highlight IncSearch guibg=green ctermbg=green term=underline

"=== Filetype Specific ===="
filetype plugin on " run filetype appropriate plugins
filetype indent on " load filetype-specific indent files

"= Distinguish Filetypes =="

augroup filetypedetect 
	" Octave syntax highlighting (requires octave.vim in syntax folder)
	au! BufRead,BufNewFile *.m,*.oct set filetype=octave
	" Mathematica syntax highlighting (from vim-mma plugin)
	au! BufRead,BufNewFile *.wl,*.wls set filetype=mma 
augroup END 
