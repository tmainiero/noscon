""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                Keybindings                                 "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" Neovim Specific
if has('nvim')
" Give escape key expected behaviour in terminal emulator
" (only sensible if terminal is not in vi-mode)
	:tnoremap <Esc> <C-\><C-n>
	:tnoremap <C-n> <Esc>
	"Remove Line numbering in terminal
	augroup TerminalStuff
		au! 					
		autocmd TermOpen * setlocal nonumber norelativenumber
	augroup END

endif
let mapleader= "\<Space>"

" Toggle between hybrid relative or absolute number lines
" <C-N> does the same thing as j
nnoremap <silent> <C-N> :call NumberToggle()<CR>

"=== Autocomplete Menu ===="
" https://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
inoremap <expr><C-J> pumvisible() ? "\<C-n>" : "\<C-J>"
inoremap <expr><C-K> pumvisible() ? "\<C-p>" : "\<C-K>"
" Enter to select item
inoremap <expr><CR>  pumvisible() ? "\<C-y>" : "\<CR>"

"======= Clipboard ========"
" make sure xclip is installed!

" Copy to clipboard
nnoremap  <leader>Y  "+yg_
nnoremap  <leader>y  "+y
" unnecessary for some reason
vnoremap  <leader>y  "+y

" Paste from clipboard
nnoremap <leader>p "+p
nnoremap <leader>P "+P
vnoremap <leader>p "+p
vnoremap <leader>P "+P

" Cycle between windows
nnoremap <leader>w :wincmd w<CR>

" Move lines around with alt keys
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv


" Toggle folds
nnoremap <silent> <leader><Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
vnoremap <leader><space> zf

" reference: https://github.com/fadein/dotvim/blob/master/vimrc#L236
" execute the current line of text as a shell command
noremap  Q !!zsh<CR>
vnoremap Q  !zsh<CR>

" Map alt-v in command-line mode to replace the commandline with the Ex
" command-line beneath the cursor in the buffer
cnoremap <Esc>v <C-\>esubstitute(getline('.'), '^\s*\(' . escape(substitute(&commentstring, '%s.*$', '', ''), '*') . '\)*\s*:*' , '', '')<CR>

nnoremap <F3> :call ShowSynStack()<CR>

