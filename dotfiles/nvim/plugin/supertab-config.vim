" I need s:contextdiscover, and supertabchain
" but AFTER READING DOCUMENTATION it seems redundant with supertabchain

let g:SuperTabDefaultCompletionType = 'context'
let g:SuperTabCompletionContexts = ['s:ContextText','s:ContextDiscover']
let g:SuperTabContextDiscoverDiscovery = ["&completefunc:<c-x><c-u>", "&omnifunc:<c-x><c-o>"]

" The following commented variable is default
" let g:SuperTabContextTextOmniPrecedence = ['&completefunc', '&omnifunc']
"
" Use 'context' first, then omnifunc, then control-p
" See :h supertab
if &omnifunc != '' |
	call SuperTabChain(&omnifunc, "<c-p>") |
endif

" Hitting enter cancels completion menu
" let g:SuperTabCrMapping = 1

