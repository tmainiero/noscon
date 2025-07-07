"=============================== vim-surround ==============================="
" Surround with a latex command (e.g. ysiwctextbf surrounds word with \textbf)
let g:surround_{char2nr('c')} = "\\\1command\1{\r}"
