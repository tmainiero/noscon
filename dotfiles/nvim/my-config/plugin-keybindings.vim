""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                        Plugin Specific Keybindings                         "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" nnoremap <leader>ut :MundoToggle<CR>
" nnoremap <leader>nt :NERDTreeToggle<CR>

"=================================== Ale ===================================="
nnoremap <leader>at :ALEToggle<CR>
nnoremap <silent> <C-k> <Plug>(ale_previous_wrap)
nnoremap <silent> <C-j> <Plug>(ale_next_wrap)

"================================ EasyMotion ================================"
map <Leader> <Plug>(easymotion-prefix)
nmap <leader>s <Plug>(easymotion-overwin-f2)

"================================ Ultisnips ================================="
nmap <leader>ue :UltiSnipsEdit<CR>

"================================= SnipRun =================================="
" nmap \ee <Plug>SnipRun
" nmap \eo <Plug>SnipRunOperator
" vmap \e <Plug>SnipRun

"=================================== FZF ===================================="
nnoremap <leader>/  :BLines<CR>
nnoremap <leader>ff :FZF<CR>

"================================ Easy Align ================================"
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)
