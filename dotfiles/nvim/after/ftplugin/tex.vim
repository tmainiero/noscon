"=====Indentation (No defaults in ~/vim/runtime/indent/tex.vim but if they
"are overridden, it's because of filetype indent on; put these settings in
"after/ftplugin to override defaults)

set autoindent

"The width of a tab character (measured in spaces)
set tabstop=4

"Do not expand tabs into spaces (these are defaults, but set here for safety)
set softtabstop=0 noexpandtab

"The width of an 'indent' (used by '>', '<', '=' commands), measured in spaces
"Equal to tabstop value if one tab is one indent
set shiftwidth=4

" TIP: if you write your \label's as \label{fig:something}, then if you
" type in \ref{fig: and press <C-n> you will automatically cycle through
" all the figure labels. Very useful!
set iskeyword+=:

"Highlight misspelled words by default
set spell

"======================== Plugin ========================"

" Remove quotes from autopair expansion if plugin is equipped
let g:AutoPairs={'(':')', '[':']', '{':'}'}
" let g:AutoPairs = autopairs#AutoPairsDefine([{'open': '\\{', 'close': '\}', 'filetype': 'tex'}])
let g:AutoPairsFlyMode = 0


" Change default math toggling
let g:vimtex_env_toggle_math_map = {
			\ '$': 'equation',
			\ 'equation': '$',
			\ '$$': '\[',
			\ '\(': '$',
			\}

"===================== Keybindings ======================"


"Correct previous misspelled word using first suggestion
inoremap <C-S> <C-G>u<Esc>[s1z=`]a<C-G>u
" nnoremap <C-S> [s1z=<c-o> "has some issues with jumplist
nnoremap <C-S> i<C-G>u<Esc>[s1z=`]a<C-G>u<Esc>

" Select last misspelled word (typing will edit).
" (c.f. https://vi.stackexchange.com/questions/68/autocorrect-spelling-mistakes)
nnoremap <C-K> <Esc>[sve<C-G>

"Inline math (C-Space can also be entered as C-@)
" inoremap <C-Space> $$<Esc>i
inoremap <C-Space> <ESC>:call SimpleJump()<CR>

" Mapping for double quotation marks
inoremap <buffer> " <C-R>=<SID>TexQuotes()<CR>

" Mapping for single quotation mark
inoremap <buffer> ' <C-R>=<SID>TexSingQuotes()<CR>

" Insert alingment ampersand in front of previous word
" If no other ampersand exists before it
" Otherwise remove any previous ampersand
nnoremap <leader>al :call ToggleAmpersand()<CR>

" Toggle between inline math and display math: needs to be fixed
nnoremap <leader>tm <plug>(vimtex-env-toggle-math)

" Abbreviations to correct spacing
iabbrev i.e. i.e.\
iabbrev ---i.e. ---i.e.\
iabbrev (i.e. (i.e.\
iabbrev I.e. I.e.\

iabbrev e.g. e.g.\
iabbrev (e.g. (e.g.\
iabbrev ---e.g. ---e.g.\
iabbrev E.g. E.g.\

iabbrev c.f. c.f.\
iabbrev (c.f. (c.f.\
iabbrev ---c.f. ---c.f.\
iabbrev C.f. C.f.\

iabbrev s.t. s.t.\

iabbrev a.e. a.e.\
iabbrev A.e. A.e.\

" Common typos 
iabbrev teh the
iabbrev Teh The
iabbrev hte the

" Probationary abbreviations
iabbrev homomoprhism homomorphism
iabbrev homomoprhisms homomorphisms

" Useful name replacements
iabbrev Kahler K\"{a}hler
iabbrev Mobius M\"{o}bius
iabbrev Cech \v{C}ech
iabbrev Poincare Poincar\'{e}
iabbrev Froebenius Fr\"{o}benius
iabbrev Frobenius Fr\"{o}benius

" Helpful latex shortcuts (coloneqq requires mathtools)
iabbrev a= &=
iabbrev := \coloneqq
iabbrev a:= &\coloneqq


" Format one sentence per line.  Inspired by
" https://vi.stackexchange.com/questions/2846/how-to-set-up-vim-to-work-with-one-sentence-per-line  
function! SemanticLineBreak(start, end)
    silent execute a:start.','.a:end.'s/\(\u\|\a\.\a\|\<al\)\@<![.!?]\zs /\r/g|normal =``'
endfunction

set formatexpr=SemanticLineBreak(v:lnum,v:lnum+v:count-1)

" function! InsertInlineMath(..)
" let position = let save_pos = getpos('.')
" 	if AlreadyInMath(line('.'),col('.'))==0
" 		exec $$<Esc>i
" 	else
" 		if ClosingDollar(line('.'),col('.'))==1
" 			f$a
" 		else 
" 			$
" 		endif
" 	endif
" endfunction



" == Possibly useful for formatting in the future
" Don't try to reformat stuff in math mode	
"C.f. https://tex.stackexchange.com/questions/1548/intelligent-paragraph-reflowing-in-vim
""Reformat lines (getting the spacing correct) {{{
" fun! TeX_fmt()
"     if (getline(".") != "")
"     let save_cursor = getpos(".")
"         let op_wrapscan = &wrapscan
"         set nowrapscan
"         let par_begin = '^\(%D\)\=\s*\($\|\\label\|\\begin\|\\end\|\\[\|\\]\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\|\\noindent\>\)'
"         let par_end   = '^\(%D\)\=\s*\($\|\\begin\|\\end\|\\begin\|\\end\|\\place\|\\\(sub\)*section\>\|\\item\>\|\\NC\>\|\\blank\>\)'
"     try
"       exe '?'.par_begin.'?+'
"     catch /E384/
"       1
"     endtry
"         norm V
"     try
"       exe '/'.par_end.'/-'
"     catch /E385/
"       $
"     endtry
"     norm gq
"         let &wrapscan = op_wrapscan
"     call setpos('.', save_cursor) 
"     endif
" endfun

" nmap Q :call TeX_fmt()<CR>

"Smarts quotes (c.f. https://tex.stackexchange.com/questions/8537/vim-latex-double-quote-automatically-replaced)
"" Function for smart-quotes: double
function! s:TexQuotes()
    if getline('.')[0:col(".")] =~ '\(^\|[^\\]\)%'
       let kinsert = "\""
    else
        let kinsert = "\'\'"
        let left = getline('.')[col('.')-2]
        if left =~ '^\(\|\s\|{\|(\|\[\|&\)$'
            let kinsert = "\`\`"
        elseif left == "\\"
            let kinsert = "\""
        endif
    endif
    return kinsert
endfunction

" Function for smart-quotes: single
function! s:TexSingQuotes()
    if getline('.')[0:col(".")] =~ '\(^\|[^\\]\)%'
       let schminsert = "'"
    else
        let schminsert = "'"
        let left = getline('.')[col('.')-2]
        if left =~ '^\(\|\s\|{\|(\|\[\|&\)$'
            let schminsert = '`'
        endif
    endif
    return schminsert
endfunction

function! ToggleAmpersand() abort
	let l:save_pos = getpos('.')
	if getline('.')[0:col('.')] =~ '&'
		execute "normal! F&x"
	else
		execute "normal! Bi&\<esc>"
	endif
	call setpos('.',save_pos)
endfunction

"""""""""""""""""""""
"""""""""""""""""""""

function! SimpleJump() abort
	" Grab initial position
	let l:pos = [line('.'), col('.')]

	if IsText(l:pos)
		call TextProcedure(l:pos)
	else  
		call SimpleInlineProcedure(l:pos)
	endif
endfunction

function! TextProcedure(...)
	let [l:lnum,l:cnum] = a:0 > 0 ? a:1 : [line('.'), col('.')]
	if (getline(l:lnum)[l:cnum-1] == "$")
		call JumpDollar()
	else
		execute "normal! a$$"
		call feedkeys('i','n')
	endif
endfunction

function! JumpDollar()
	call cursor(searchpos('\$','enW'))
	call feedkeys('a','n')
endfunction

function! SimpleInlineProcedure(pos) abort
	let [l:lnum,l:cnum]=a:pos

	if (getline(l:lnum)[l:cnum] == "$") && (getline(l:lnum)[l:cnum-1] == "$")
		execute "normal! xx"
		call feedkeys('a','n')
	elseif IsMathOdd(a:pos) && IsMathTextOdd(a:pos)
		call TextProcedure(a:pos)
	else
		call JumpDollar()
		" endif
	" elseif IsDInline(a:pos)
	" 	if !IsMathText(a:pos)
	" 		call JumpDollar()
	" 	else 
	" 		if IsDInlineOdd(a:pos)
	" 			call TextProcedure()
	" 		else
	" 			call JumpDollar()
	" 		endif
	" 	end
	" else
	" 	call feedkeys('i','n')
	endif
endfunction

"""""""""""""""""
" Syntax Checkers
"""""""""""""""""

function! InSyntax(name,...) abort
	" usage: InSyntax(name, [line, col])

	" Check if position is supplied, get current position if not
	let l:pos = a:0 > 0 ? a:1 : [line('.'), col('.')]

	" Correct position if in insert mode
	if mode() ==# 'i'
		let l:pos[1] -= 1
	endif
	call map(l:pos, 'max([v:val, 1])')

	" Check syntax at position
	return match(map(synstack(l:pos[0], l:pos[1]),
				\          "synIDattr(v:val, 'name')"),
				\      '^' . a:name) >= 0
endfunction

function! IsMath(...) abort
	return call('InSyntax',['texMathZone'] + a:000)
endfunction

function! IsText(...) abort
	return !call('InSyntax',['texMathZone'] + a:000)
endfunction

"""
" Unused
"""

" function! IsMathText(...) abort
" 	return call('InSyntax',['texMathText'] + a:000)
" endfunction

" function! IsDInline(...) abort 
" 	return call('InSyntax',['texMathZoneX$'] + a:000)
" endfunction

" function! IsPInline(...) abort 
" 	return call('InSyntax',['texMathZoneV$'] + a:000)
" endfunction

" function! IsInline(...) abort 
" 	return call('InSyntax',['texMathZone[X,V]$'] + a:000)
" endfunction

""""""""""""""
" Syntax Parity Checkers
""""""""""""""
function! InSyntaxParity(name,...) abort
	" usage: InSyntax(name, [line, col])

	" Check if position is supplied, get current position if not
	let l:pos = a:0 > 0 ? a:1 : [line('.'), col('.')]

	" Correct position if in insert mode
	" if mode() ==# 'i'
	" 	let l:pos[1] -= 1
	" endif
	call map(l:pos, 'max([v:val, 1])')

	" Check syntax at position
	let l:name_val='^'.a:name
	return len(filter(map(synstack(l:pos[0], l:pos[1]),
				\          "synIDattr(v:val, 'name')"),
				\      'v:val =~ l:name_val'))%2
endfunction

function! IsDInlineOdd(...) abort 
	return call('InSyntaxParity',['texMathZoneX$'] + a:000)
endfunction


function! IsMathOdd(...) abort
	return call('InSyntaxParity',['texMathZone'] + a:000)
endfunction


function! IsMathTextOdd(...) abort
	return call('InSyntaxParity',['texMathText'] + a:000)
endfunction


"""""""""""""""""""""
"""""""""""""""""""""

"Useful for determining current syntax state
function! SynStack()
  if !exists("*synstack")
    return
  endif
  echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc


" https://vi.stackexchange.com/questions/26736/toggle-between-displaymath-and-inline-math-modes-in-latex: only toggles first $..$ needs to be fixed
" Use vimtex's ts$ instead
"

" function! ToggleLatexMathMode()
"     " Get the current line and check if we find an expression surrounded by $ signs
"     let l=getline('.')
"     let inline=match(l, '\$[^$]\+\$')

"     " Inline to block
"     if (inline >= 0)
"         " Get the expression
"         let l=matchstr(l, '\$[^$]\+\$')
"         " Remove the surrounding $ signs
"         let expr=substitute(l, '\$', '', 'g')
"         " Remove the expression from the line
"         execute 's/\%' . inline  . 'c.\{' . ( len(l)+1 ) . '}//'
"         " Append the delimitors and the expression without $ signs
"         call append(line('.'), '\end{equation*}')
"         call append(line('.'), expr)
"         call append(line('.'), '\begin{equation*}')
"         " Format to get the right indentation
"         normal! =}
"     " Block to inline
"     else
"         " Get the lines delimiting the expression
"         let start=search('begin{equation*}', 'b')
"         let end=search('end{equation*}')
"         " Delete the surrounding lines
"         execute(end . 'd')
"         execute(start . 'd')
"         " Join the lines in the expression
"         execute(start . ',' . (end-2) . 'join')
"         " Add the surrounding dollar signs
"         call setline(start, substitute(getline(start), '^\s*', '$', '') . '$')
"         " Join with the previous line
"         normal! kJ
"     endif
" endfunction
