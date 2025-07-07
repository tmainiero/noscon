" Open even an empty .tex file as a latex file
let g:tex_flavor='latex'		

" No spell-checking of tex syntax in comments          
let g:tex_comment_nospell=1     

let g:vimtex_view_method='zathura'

" Have completion add closing brace as well
let g:vimtex_complete_enabled=1
let g:vimtex_complete_close_braces=1

" Disable syntax concealing (greeks, etc.)
let g:vimtex_syntax_conceal_disable=1

" Check if in nixos to fix inverse search on zathura
" https://github.com/lervag/vimtex/issues/2261
" https://github.com/lervag/vimtex/pull/2262
if isdirectory('/etc/nixos')
	" By default the following uses v:progpath
	" which is an unwrapped binary
	let g:vimtex_callback_progpath = exepath('nvim')
endif

" Set continuous to 1 for compile on write
let g:vimtex_compiler_latexmk = {
            \ 'continuous' : 0,
			\ 'aux_dir' : 'texbuild',
			\ 'out_dir' : 'pdf-out',
			\ 'options' : [
			\   '-verbose',
			\   '-file-line-error',
			\   '-synctex=1',
			\   '-interaction=nonstopmode',
			\   '-shell-escape',
			\ ],
            \}

" Insert mode leader for vimtex (default is backtick '`') 
let g:vimtex_imaps_leader = '@'
