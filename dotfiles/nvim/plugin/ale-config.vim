"Wait 5 seconds=5000ms after text insertion before linting (default 200ms) 
let g:ale_lint_delay=5000

" Disable ALE by default for .tex files
" let g:ale_pattern_options = {
" \   '.*\.tex$': {'ale_enabled': 0},
" \}

" Use signs in sign column to indicate issues
let g:ale_set_signs=1
" Disable virtual text
let g:ale_virtualtext_cursor='disable'
" Echo issues in buffer
let g:ale_echo_cursor=1

let g:ale_linters = {'haskell': ['cabal_ghc', 'ghc-mod', 'hdevtools', 'hie', 'hlint', 'stack_build', 'stack_ghc']}
