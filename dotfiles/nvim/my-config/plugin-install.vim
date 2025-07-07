"================================= Comments ================================="
" Use zR to open all folds; zM to close all folds; za to toggle a fold
" To go to a section under outline use * (search under string) on >XZ[...]
"================================= Outline =================================="
" To go to a section under outline use * (search under string) on >XZ[...]
" * Plugins:                        >XZPLUG
" ** Install Script:                >XZINSTALL
" ** Colorschemes:                  >XZCOLOR
" ** Behavior and Basic Extensions: >XZBEHAVE
" ** Experimental:                  >XZEXPER
" ** End Plug/Posthooks:            >XZENDPL

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                  Plugins                                   "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" XZPLUG

"" Conditional Load Helper
function! CondLd(CondLd, ...)
  let opts = get(a:000, 0, {})
  return a:CondLd ? opts : extend(opts, { 'on': [], 'for': [] })
endfunction

"" Install Script and Begin
" XZINSTALL

let data_dir = has('nvim') ? stdpath('data') . '/site' : '~/.vim'
if empty(glob(data_dir . '/autoload/plug.vim'))
  silent execute '!curl -fLo '.data_dir.'/autoload/plug.vim --create-dirs  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

" The default plugin directory will be as follows:
"   - Vim (Linux/macOS): '~/.vim/plugged'
"   - Vim (Windows): '~/vimfiles/plugged'
"   - Neovim (Linux/macOS/Windows): stdpath('data') . '/plugged'
" You can specify a custom plugin directory by passing it as the argument
"   - e.g. `call plug#begin('~/.vim/plugged')`
"   - Avoid using standard Vim directory names like 'plugin'

call plug#begin()


"" Colorschemes

" XZCOLOR

Plug 'drewtempelmeyer/palenight.vim'    
Plug 'morhetz/gruvbox'
Plug 'ayu-theme/ayu-vim'
Plug 'sjl/badwolf'
" Plug 'joshdick/onedark.vim'
"
Plug 'catppuccin/nvim', {'as': 'catppuccin'}

"" Behavior and Basic Extensions

" XZBEHAVE

"=================== Behavior Changes ==================="
" Saves last place
Plug 'farmergreg/vim-lastplace'              
" Switch to window instead of swap file prompt
" Requires installing wmctrl to work properly! Doesn't work on konsole without vim-konsole
Plug 'gioele/vim-autoswap'					
"Turn off highlighting when done searching and show total # of matches
Plug 'romainl/vim-cool'                      
"Smoother scrolling via <C-f>, <C-b>
Plug 'yuttie/comfortable-motion.vim'                            

" ========= Basic Extensions ========="
Plug 'tpope/vim-repeat'						
Plug 'tpope/vim-surround'                
Plug 'tpope/vim-commentary'                  
Plug 'tpope/vim-abolish'
Plug 'andymass/vim-matchup'
Plug 'tpope/vim-fugitive'					

" Alignment
Plug 'junegunn/vim-easy-align'				
" visualize undo tree
Plug 'simnalamburt/vim-mundo'	    	
" cx and X{visual} operators for swapping
Plug 'tommcdo/vim-exchange'					

" ======================== Motion ========================"
Plug 'easymotion/vim-easymotion'
" Plug 'easymotion/vim-easymotion', CondLd(!exists('g:vscode'))
" Plug 'asvetliakov/vim-easymotion', CondLd(exists('g:vscode'), { 'as': 'vsc-easymotion' })
"Two letter searching using 's'
Plug 'justinmk/vim-sneak'                    

" ==================== Heavy Plugins ====================="
"Linting (requires Vim >=8 or nv )
Plug 'w0rp/ale'							
Plug 'scrooloose/nerdtree'				
" Supertab completion
Plug 'ervandew/supertab'
" Fuzzy file searching (works in terminal too)
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' } 
Plug 'junegunn/fzf.vim'
" Snippets
Plug 'SirVer/ultisnips'						
" Link with overleaf
Plug 'da-h/AirLatex.vim', {'do': ':UpdateRemotePlugins'}


"===================== Status line ======================"
"Plug 'https://github.com/itchyny/lightline.vim'			    
Plug 'vim-airline/vim-airline'
"color themes for status bar
"Plug 'vim-airline/vim-airline-themes'
"
"===================== General REPL ====================="
Plug 'axvr/zepl.vim'

"================== Filetype specific ==================="
"========= Latex =========="
Plug 'lervag/vimtex'				    	

"======== Haskell ========="
"Haskell syntax highlighting, better than Vim default
Plug 'neovimhaskell/haskell-vim'				
Plug 'itchyny/vim-haskell-indent'
" Plug 'alx741/vim-hindent' "Automatic formatting
"========== Lisp =========="
Plug 'kovisoft/slimv', {'for': ['lisp', 'scheme', 'clojure']}
Plug 'junegunn/rainbow_parentheses.vim'

" Plug 'tpope/vim-sexp-mappings-for-regular-people'
" Plug 'bhurlow/vim-parinfer'
"========= Python ========="
"python-mode (adds 10ms to startuptime even on non .py files because python)
" Plug 'python-mode/python-mode', { 'branch': 'develop' }		
" ========= Octave ========="
Plug 'tranvansang/octave.vim'
"========== GPG ==========="
Plug 'jamessan/vim-gnupg'
"======== Markdown ========"
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}

"" Experimental
" XZEXPER
" Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
" Plug 'nvim-treesitter/playground'
Plug 'michaelb/sniprun', {'do': 'bash install.sh'}
Plug 'lunarWatcher/auto-pairs'

Plug 'neoclide/coc.nvim', {'branch': 'release', 'for': ['haskell', 'python']}
" Plug 'neoclide/coc.nvim', CondLd(!exists('g:vscode'), {'branch': 'release', 'for': ['haskell', 'python']})


"" End Plug
" XZENDPL
call plug#end()
