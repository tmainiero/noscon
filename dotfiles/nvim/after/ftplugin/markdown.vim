"Highlight misspelled words by default
set spell

"Correct previous misspelled word using first suggestion
inoremap <C-S> <C-G>u<Esc>[s1z=`]a<C-G>u
" nnoremap <C-S> [s1z=<c-o> "has some issues with jumplist
nnoremap <C-S> i<C-G>u<Esc>[s1z=`]a<C-G>u<Esc>

" Select last misspelled word (typing will edit).
" (c.f. https://vi.stackexchange.com/questions/68/autocorrect-spelling-mistakes)
nnoremap <C-K> <Esc>[sve<C-G>

