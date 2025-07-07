""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                              Plugin Settings                               "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"==================== lastplace ====================="
" "Don't automatically open folds
" let g:lastplace_open_folds = 0

"==================== matchup ====================="
" let g:matchup_motion_enabled = 0

"==================== vim-autopairs ====================="
" let g:AutoPairsFlyMode = 1
" " Delete matched pairs
" let g:AutoPairsMapBS = 1
" let g:AutoPairsShortcutBackInsert = '<M-b>'
" let g:AutoPairsCompleteOnlyOnSpace = 1
" let g:AutoPairsCompatibleMaps = 0

"==================== airline =========================="

" "Allow for powerline fonts in airline status bar
" let g:airline_powerline_fonts=1

" " Let Airline interact with ALE
" let g:airline#extensions#ale#enabled = 1

" call airline#add_statusline_func('WindowNumber')
" call airline#add_inactive_statusline_func('WindowNumber')

"==================== surround =========================="
"Surround with latex command (e.g. ysiwctextbf surrounds word with \textbf{})
" let g:surround_{char2nr('c')} = "\\\1command\1{\r}"

"======================== vimtex ========================"
" Open even an empty .tex file as a latex file
" let g:tex_flavor='latex'		
" 
" " No spell-checking of tex syntax in comments          
" let g:tex_comment_nospell=1     
" 
" let g:vimtex_view_method='zathura'
" 
" " Have completion add closing brace as well
" let g:vimtex_complete_enabled=1
" let g:vimtex_complete_close_braces=1
" 
" " Disable syntax concealing (greeks, etc.)
" let g:vimtex_syntax_conceal_disable=1
" 
" " Single shot callbacks only 
" " Set to 1 for continuous mode (compile on write)
" let g:vimtex_compiler_latexmk = {
"             \ 'continuous' : 0,
" 			\ 'build_dir' : 'texbuild',
" 			\ 'options' : [
" 			\   '-verbose',
" 			\   '-file-line-error',
" 			\   '-synctex=1',
" 			\   '-interaction=nonstopmode',
" 			\   '-shell-escape',
" 			\ ],
"             \}
" 
" " Insert mode leader for vimtex (default is backtick '`') 
" let g:vimtex_imaps_leader = '@'

"=============== ALE ================"

" "Wait 5 seconds=5000ms after text insertion before linting (default 200ms) 
" let g:ale_lint_delay=5000
" 
" " Disable ALE by default for .tex files
" " let g:ale_pattern_options = {
" " \   '.*\.tex$': {'ale_enabled': 0},
" " \}
" 
" " Use signs in sign column to indicate issues
" let g:ale_set_signs=1
" " Disable virtual text
" let g:ale_virtualtext_cursor='disable'
" " Echo issues in buffer
" let g:ale_echo_cursor=1
" 
" let g:ale_linters = {'haskell': ['cabal_ghc', 'ghc-mod', 'hdevtools', 'hie', 'hlint', 'stack_build', 'stack_ghc']}
" 

"============= Supertab ============="

" I need s:contextdiscover, and supertabchain
" but AFTER READING DOCUMENTATION it seems redundant with supertabchain

" let g:SuperTabDefaultCompletionType = 'context'
" let g:SuperTabCompletionContexts = ['s:ContextText','s:ContextDiscover']
" let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]
" 
" The following commented variable is default
" let g:SuperTabContextTextOmniPrecedence = ['&completefunc', '&omnifunc']
" Use 'context' first, then omnifunc, then control-p
autocmd FileType *
			\ if &omnifunc != '' |
			\   call SuperTabChain(&omnifunc, "<c-p>") |
			\ endif

" Hitting enter cancels completion menu
" let g:SuperTabCrMapping = 1

"======= Ultisnips ========"

" let g:UltiSnipsEditSplit = 'vertical'
" 
" "==Needs to be included for Ultisnips to find appropriate folder
" if !has('nvim') 
" 	set runtimepath+=~/.vim/my_snippets
" endif
" 
" "==Directories to search for snippets (first one is for plugins)
" " let g:UltiSnipsSnippetDirectories = ["UltiSnips", "my_snippets"]
" 
" "Use following if you only want custom snippets (faster searching)
" let g:UltiSnipsSnippetDirectories = [g:config_dir.'/my_snippets'] "absolute path
" "relative path (any folder in runtimepath)
" " let g:UltiSnipsSnippetDirectories = ['my_snippets'] 
" 
" " " better key bindings for UltiSnipsExpandTrigger
" let g:UltiSnipsExpandTrigger = "<tab>"
" let g:UltiSnipsJumpForwardTrigger = "<C-F>"
" let g:UltiSnipsJumpBackwardTrigger = "<C-D>"
" 
" "See ultisnips documentation for the following -- prevents
" " interference with default completion mapping (remove if using supertab)
" " inoremap <c-x><c-k> <c-x><c-k>
" 
"========== FZF ==========="

" " Customize fzf colors to match your color scheme
" let g:fzf_colors =
" \ { 'fg':      ['fg', 'Normal'],
"   \ 'bg':      ['bg', 'Normal'],
"   \ 'hl':      ['fg', 'Comment'],
"   \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
"   \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
"   \ 'hl+':     ['fg', 'Statement'],
"   \ 'info':    ['fg', 'PreProc'],
"   \ 'border':  ['fg', 'Ignore'],
"   \ 'prompt':  ['fg', 'Conditional'],
"   \ 'pointer': ['fg', 'Exception'],
"   \ 'marker':  ['fg', 'Keyword'],
"   \ 'spinner': ['fg', 'Label'],
"   \ 'header':  ['fg', 'Comment'] }


"======== Vim Cool ========"

" "Show total number of matches
" let g:CoolTotalMatches = 1

"======= Vim Sneak ========"

" let g:sneak#label = 1    "EasyMotion Alternative--suggests labels
" let g:tex_conceal = ""   "Disable strange unicode conversion of math in .tex files when sneaking 


"============= Gruvbox =============="
" Hard contrast in dark mode
" let g:gruvbox_contrast_dark = 'hard'
" let g:gruvbox_italic = '1'
" "let g:gruvbox_number_column = 'bg1'
" let g:gruvbox_hls_cursor = 'purple'

 " Darker number column
"let g:gruvbox_number_column = 'bg0'

"========================= Ayu =========================="

" " other options: light, mirage
" let ayucolor="dark"   

"======================= Badwolf ========================"
" Make the gutters darker than the background.
let g:badwolf_darkgutter = 1


""========================= Zepl ========================="
"let g:repl_config = {
"			\   'haskell': { 'cmd': 'stack ghci' },
"			\   'octave': { 'cmd': 'octave --no-gui' },
"			\   'mma': {'cmd': 'math'},
"            \   'python': {
"            \     'cmd': 'ipython'
"            \   }
"            \ }

""======================== Slimv ========================="
"" Open slimv server inside of a separate instance
"" let g:slimv_swank_cmd = '! xterm -e sbcl --load /usr/share/common-lisp/source/slime/start-swank.lisp &'
"let g:slimv_leader = '\'
"" Also set in ftplugin/lisp.vim!
"let g:paredit_leader = ';'
"let g:paredit_shortmaps = 1
""REPL appears as vertical split on right side; 40 columns wide
"" let g:slimv_repl_split = 4
"let g:slimv_repl_split_size = 10

""======== Airlatex ========"
"" optional: set server name
"let g:AirlatexDomain="www.overleaf.com"
