"==============================================================
"    file: go.vim
"   brief: 
" VIM Version: 8.0
"  author: tenfyzhong
"   email: tenfyzhong@qq.com
" created: 2017-06-10 09:59:22
"==============================================================

" youcompleteme
" {'word': 'Scan', 'menu': 'func(a ...interface{}) (n int, err error)', 'info': 'Scan func(a ...interface{}) (n int, err error) func', 'kind': 'f', 'abbr': 'Scan'}
" completor
" {'word': 'Scanf', 'menu': 'func(format string, a ...interface{}) (n int, err error)', 'info': '', 'kind': '', 'abbr': ''}
function! s:parser0(menu)
    if empty(a:menu)
        return []
    endif
    let param = substitute(a:menu, '\mfunc\(([^(]*)\).*', '\1', '')
    " remove type
    let param = substitute(param, '\m\(\w\+\)\s*[^,)]*', '\1', 'g')
    return [param]
endfunction

" neocomplete
" {'word': 'Scan(', 'menu': '[O] ', 'info': 'func Scan(a ...interface{}) (n int, err error)', 'kind': '', 'abbr': 'func Scan(a ...interface{}) (n int, err error)'}
function! s:parser1(info, word)
    if empty(a:info)
        return []
    endif
    let word = substitute(a:word, '\(.*\)(', '\1', '')
    let param = substitute(a:info, '\m^func '.word.'\(([^()]*)\).*', '\1', '')
    " remove type
    let param = substitute(param, '\m\(\w\+\)\s*[^,)]*', '\1', 'g')
    return [param]
endfunction

function! cm_parser#go#parameters(completed_item) "{{{
    let kind = get(a:completed_item, 'kind', '')
    let menu = get(a:completed_item, 'menu', '')
    let info = get(a:completed_item, 'info', '')
    let word = get(a:completed_item, 'word', '')
    if menu =~# '^func'
        return <SID>parser0(menu)
    elseif word =~# '\w*(' && !empty(info)
        return <SID>parser1(info, word)
    else
        return []
    endif
endfunction "}}}

function! cm_parser#go#parameter_delim() "{{{
    return ','
endfunction "}}}

function! cm_parser#go#parameter_begin() "{{{
    return '('
endfunction "}}}

function! cm_parser#go#parameter_end() "{{{
    return ')'
endfunction "}}}
