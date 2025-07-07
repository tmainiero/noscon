" Convert a tab to 4 spaces
set tabstop=4 shiftwidth=4 expandtab

" Make tab characters visible
set list
set listchars=tab:!·,trail:·

let g:ale_lint_delay=200

"Intero Shortcuts as suggested at github.com/parsonsmatt/intero-neovim

"Background process and window management
"nnoremap <leader>is :InteroStart<CR>
"nnoremap <leader>ik :InteroKill<CR>

""Open intero/GHCi split horizontally
"nnoremap <leader>io :InteroOpen<CR>

""Open intero/GHCi split vertically


" Intero settings
"nnoremap <leader>iov :InteroOpen<CR><C-W>H
"nnoremap <leader>ih :InteroHide<CR>

""===Reloading
""Manually save and reload
"nnoremap <leader>wr :w \| :InteroReload<CR>

""Load individual modules
"nnoremap <leader>il :InteroLoadCurrentModule<CR>
"nnoremap <leader>if :InteroLoadCurrentFile<CR>

""Type related information
"map <leader>t <Plug>InteroGenericType
"map <leader>T <Plug>InteroType
"map <leader>it :InteroTypeInsert<CR>

""Navigation
"nnoremap <leader>jd :InteroGoToDef<CR>
"nnoremap <leader>iu :InteroUses<CR>

""Managing targets
""Prompts you to enter targets
"nnoremap <leader>ist :InteroSetTargets<SPACE>

"See .vimrc for intero specific settings
