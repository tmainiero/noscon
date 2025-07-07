let g:UltiSnipsEditSplit = 'vertical'

" " better key bindings for UltiSnipsExpandTrigger
let g:UltiSnipsExpandTrigger = "<tab>"
let g:UltiSnipsJumpForwardTrigger = "<C-F>"
let g:UltiSnipsJumpBackwardTrigger = "<C-D>"

"=============================== RuntimePath ================================"
"Add ultisnips subdirectory in the runtime path so that ultisnips can find
"The pythonx folder
let g:ultisnips_runtime_dir=$HOME.'/noscon/dotfiles/nvim/ultisnips'
execute "set runtimepath +=".g:ultisnips_runtime_dir

"============================= Custom Snippets =============================="
" Use only custom snippets
let g:UltiSnipsSnippetDirectories = [ g:ultisnips_runtime_dir.'/my-snippets' ]
