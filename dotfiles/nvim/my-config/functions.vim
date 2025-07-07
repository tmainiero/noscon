""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"                                 Functions                                  "
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugin-agnostic functions go here

" Toggle between hybrid relative or absolute number lines
function! NumberToggle()
    if (&rnu == 0)
        set rnu
    elseif (&rnu == 1)
        set nornu
    endif
endfunction

" Taken from: https://github.com/fadein/dotvim/blob/dc4fb4b02f8b43fad63715f568a0b251c409fd80/vimrc#L236
if v:version > 700
	function! ShowSynStack()
		for id in synstack(line('.'), col('.'))
			echo synIDattr(id, "name")
		endfor
	endfunction
endif

" " https://vi.stackexchange.com/questions/4353/how-to-generate-patterns-for-comments
" function! MyComment(...)
"     " get the arguments properly
"     let commentText = get(a:000, 0, '')
"     let commentChar = get(a:000, 1, '-')[0]

"     " Get the number of char to add on left
"     let len   = (80 - len(commentText) - len(printf(&commentstring, '')))
"     let left  = len / 2
"     let right = len - left

"     " force the title with repeat() function and insert it in the buffer
"     put=printf(&commentstring, repeat(commentChar, left) . commentText . repeat(commentChar, right))
" endfunction

""============= Folding =============="

"" Autofolding .vimrc
"" see http://vimcasts.org/episodes/writing-a-custom-fold-expression/
"" defines a foldlevel for each line of code
"" stolen from https://vi.stackexchange.com/questions/3814/is-there-a-best-practice-to-fold-a-vimrc-file
"" Needs to be updated
"function! VimFolds(lnum)
"  let s:thisline = getline(a:lnum)
"  if match(s:thisline, '^"" ') >= 0
"    return '>2'
"  endif
"  if match(s:thisline, '^""" ') >= 0
"    return '>3'
"  endif
"  let s:two_following_lines = 0
"  if line(a:lnum) + 2 <= line('$')
"    let s:line_1_after = getline(a:lnum+1)
"    let s:line_2_after = getline(a:lnum+2)
"    let s:two_following_lines = 1
"  endif
"  if !s:two_following_lines
"      return '='
"    endif
"  else
"    if (match(s:thisline, '^"""""') >= 0) &&
"       \ (match(s:line_1_after, '^"  ') >= 0) &&
"       \ (match(s:line_2_after, '^""""') >= 0)
"      return '>1'
"    else
"      return '='
"    endif
"  endif
"endfunction

"" defines a foldtext
"function! VimFoldText()
"  " handle special case of normal comment first
"  let s:info = '('.string(v:foldend-v:foldstart).' l)'
"  if v:foldlevel == 1
"    let s:line = ' ◇ '.getline(v:foldstart+1)[3:-2]
"  elseif v:foldlevel == 2
"    let s:line = '   ●  '.getline(v:foldstart)[3:]
"  elseif v:foldlevel == 3
"    let s:line = '     ▪ '.getline(v:foldstart)[4:]
"  endif
"  if strwidth(s:line) > 80 - len(s:info) - 3
"    return s:line[:79-len(s:info)-3+len(s:line)-strwidth(s:line)].'...'.s:info
"  else
"    return s:line.repeat(' ', 80 - strwidth(s:line) - len(s:info)).s:info
"  endif
"endfunction

