if exists('g:_lyne_defaults_loaded')
	finish
endif
let g:_lyne_defaults_loaded = 1

let s:active = {
\	'left': [
\		'h|LyneMode', 'r:lyne#get_mode',
\		'h|LyneBufname', 'r>lyne#utils#get_bufname', 'e|%<', 'r<lyne#utils#get_bufflags',
\		'h|StatusLine', 'e>%{&filetype}'
\	],
\	'right': ['e<[%l/%L] %p%%', 'h|LyneBufname', 'e:%02v']
\}

let s:inactive = {
\	'left': ['e:%f%<%h%w%m%r'],
\	'right': ['e:%p%%']
\}

let s:separators = {'left': '', 'right': ''}

let s:pre_functions = []
let s:post_functions = ['lyne#utils#update_bufname', 'lyne#utils#update_mode', 'lyne#utils#update_separators']

let s:pre_compile_functions = []
let s:post_compile_functions = []

function lyne#defaults#get(name)
	return copy(get(s:, a:name))
endfunction

function! lyne#defaults#colors()
	highlight LyneDefaultDefault        ctermbg=7 ctermfg=0
	highlight LyneDefaultUnmodified     ctermbg=7 ctermfg=7
	highlight LyneDefaultModified       ctermbg=7 ctermfg=53 cterm=bold
	highlight LyneDefaultUnmodifiable   ctermbg=7 ctermfg=52 cterm=bold
	if empty(synIDattr(synIDtrans(hlID('StatusLine')), 'bg', 'cterm'))
		highlight StatusLine ctermbg=0
	endif
	if empty(synIDattr(synIDtrans(hlID('StatusLine')), 'fg', 'cterm'))
		highlight StatusLine ctermfg=7
	endif
	highlight StatusLine cterm=NONE
	highlight! default link LyneDefault             LyneDefaultDefault
	highlight! default link LyneUnmodified          LyneDefaultUnmodified
	highlight! default link LyneModified            LyneDefaultModified
	highlight! default link LyneUnmodifiable        LyneDefaultUnmodifiable
	silent! call call('lyne#colors#'.get(g:, 'colors_name', ''), [])
endfunction

