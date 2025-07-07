let g:airline#extensions#ale#enabled = 1

" Show window numbers on statusline
" Apparently this is already added
" function! WindowNumber(...)
"     let builder = a:1
"     let context = a:2
"     call builder.add_section('airline_b', '%{tabpagewinnr(tabpagenr())}')
"     return 0
" endfunction

" call airline#add_statusline_func('WindowNumber')
" call airline#add_inactive_statusline_func('WindowNumber')
